#!/usr/bin/env bash
# Mirror claude.ai/settings/usage percentages + status.claude.com health.
#
# Usage: claude-usage.sh            emit waybar JSON
#        claude-usage.sh --toggle   cycle display mode, refresh the bar
#
# Auth: reads OAuth token from ~/.claude/.credentials.json
# Override: CLAUDE_OAUTH_TOKEN, CLAUDE_CREDENTIALS_FILE
# Cache: 5 min TTL at $XDG_CACHE_HOME/claude-usage.json (default ~/.cache)
# Override: CLAUDE_USAGE_CACHE, CLAUDE_USAGE_TTL (seconds), CLAUDE_USAGE_SIGNAL

set -euo pipefail

creds="${CLAUDE_CREDENTIALS_FILE:-$HOME/.claude/.credentials.json}"
tok="${CLAUDE_OAUTH_TOKEN:-}"
cache="${CLAUDE_USAGE_CACHE:-${XDG_CACHE_HOME:-$HOME/.cache}/claude-usage.json}"
ttl="${CLAUDE_USAGE_TTL:-300}"
mode_file="${XDG_RUNTIME_DIR:-/tmp}/claude-usage.mode"
signal="${CLAUDE_USAGE_SIGNAL:-7}"
modes=(short long)

mode() {
  local m
  m="$(cat "$mode_file" 2>/dev/null || true)"
  [[ " ${modes[*]} " == *" $m "* ]] && echo "$m" || echo "${modes[0]}"
}

if [[ "${1:-}" == "--toggle" ]]; then
  cur="$(mode)"
  for i in "${!modes[@]}"; do
    [[ "${modes[$i]}" == "$cur" ]] && next="${modes[$(( (i + 1) % ${#modes[@]} ))]}"
  done
  echo "$next" > "$mode_file"
  pkill "-RTMIN+$signal" waybar 2>/dev/null || true
  exit 0
fi

# ponytail: cache holds every mode's text, so toggling never hits the network
emit() { jq -c --arg m "$(mode)" --arg d "${modes[0]}" '.text = (.texts[$m] // .texts[$d]) | del(.texts)' "$1"; }

# ponytail: a broken fetch says so rather than showing stale percentages
fail() {
  local why="$1" msg
  case "$why" in
    401)   msg="token expired - run any claude command to refresh it" ;;
    429)   msg="rate limited by the usage API" ;;
    000)   msg="cannot reach api.anthropic.com" ;;
    parse) msg="unexpected response body from the usage API" ;;
    *)     msg="usage API returned HTTP $why" ;;
  esac
  jq -cn --arg m "$msg" '{text:"\u26a0", alt:"err", class:["err"], tooltip:$m}'
  exit 0
}

now=$(date +%s)

if [[ -f "$cache" ]]; then
  cached_at=$(jq -r '.cached_at // 0' "$cache" 2>/dev/null || echo 0)
  if (( now - cached_at < ttl )); then
    emit "$cache"
    exit 0
  fi
fi

if [[ -z "$tok" ]]; then
  if [[ ! -r "$creds" ]]; then
    echo "error: no token; set CLAUDE_OAUTH_TOKEN or provide $creds" >&2
    exit 1
  fi
  tok="$(jq -r '.claudeAiOauth.accessToken // empty' "$creds")"
  [[ -n "$tok" ]] || {
    echo "error: accessToken missing in $creds" >&2
    exit 1
  }
fi

# ponytail: skip a request we already know answers 401
if [[ -z "${CLAUDE_OAUTH_TOKEN:-}" && -r "$creds" ]]; then
  exp="$(jq -r '.claudeAiOauth.expiresAt // 0' "$creds")"
  if [[ "$exp" =~ ^[0-9]+$ ]] && (( exp / 1000 <= now )); then
    fail 401
  fi
fi

mkdir -p "$(dirname "$cache")"
tmp="$(mktemp "${cache}.XXXXXX")"
body="$(mktemp "${cache}.body.XXXXXX")"
trap 'rm -f "$tmp" "$body"' EXIT

# ponytail: status is best-effort, empty object when the endpoint is down
status="$(curl -fsSL --max-time 8 https://status.claude.com/api/v2/summary.json 2>/dev/null || echo '{}')"

code="$(curl -sS -o "$body" -w '%{http_code}' --max-time 8 \
  -H "Authorization: Bearer $tok" \
  -H 'anthropic-beta: oauth-2025-04-20' \
  https://api.anthropic.com/api/oauth/usage 2>/dev/null || true)"
# curl itself prints 000 when it never got a response; empty means it printed nothing
code="${code:-000}"

[[ "$code" == 200 ]] || fail "$code"

jq -c --argjson now "$now" --argjson st "$status" '
    # ISO8601 with fractional seconds and +00:00 offset -> epoch
    def epoch: if . == null then null
               else sub("\\.[0-9]+";"") | sub("\\+00:00$";"Z") | fromdateiso8601 end;
    def at: if . == null then "unknown" else strflocaltime("%a %H:%M") end;
    def in_: if . == null then "?" else . - $now
             | if . <= 0 then "now"
               elif . < 3600 then "\(. / 60 | floor)m"
               else "\(. / 3600 | floor)h\((. % 3600) / 60 | floor)m" end end;
    def reset: (.resets_at | epoch) as $e | "\($e | at) (in \($e | in_))";

    # statuspage indicator / component-status -> badge icon
    {none:"✔", minor:"⚠", major:"✖", critical:"‼",
     maintenance:"⚙", unknown:"?"} as $iicon |
    {operational:"✔", degraded_performance:"⚠", partial_outage:"✖",
     major_outage:"‼", under_maintenance:"⚙"} as $cicon |

    (.five_hour.utilization // 0) as $s |
    (.seven_day.utilization // 0) as $w |
    (.five_hour | reset) as $sr |
    (.seven_day | reset) as $wr |
    ($st.status.description // "status unavailable") as $sdesc |
    (($st.components // []) | map(select(.status != "operational"))) as $down |
    (if $st.status.indicator == null then "unknown" else $st.status.indicator end) as $ind |
    ($iicon[$ind] // "?") as $badge |
    (if   $w >= 80 or $ind == "critical" or $ind == "major" then "critical"
     elif $w >= 50 or ($ind | IN("minor","maintenance"))    then "warning"
     else                                                        "ok"       end) as $state |
    {
      texts: {
        long:  "session: \($s)%, weekly: \($w)% \($badge)",
        short: "S \($s | round)% · W \($w | round)% \($badge)"
      },
      alt: $state,
      tooltip: (
        "Session: \($s)% — resets \($sr)\r" +
        "Weekly:  \($w)% — resets \($wr)\r" +
        "\($badge) \($sdesc)" +
        (if ($down | length) > 0
         then "\r" + ($down | map("  \($cicon[.status] // "?") \(.name): \(.status)") | join("\r"))
         else "" end) +
        "\rUpdated: \($now | strflocaltime("%Y-%m-%d %H:%M:%S"))"
      ),
      class: [$state, "st-\($ind)"],
      percentage: ($w | floor),
      cached_at: $now
    }
  ' "$body" > "$tmp" || fail parse

mv "$tmp" "$cache"
emit "$cache"
