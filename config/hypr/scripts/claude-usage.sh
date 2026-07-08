#!/usr/bin/env bash
# Mirror claude.ai/settings/usage percentages.
# Output: {"session": <5h %>, "weekly": <7d %>}
#
# Auth: reads OAuth token from ~/.claude/.credentials.json
# Override: CLAUDE_OAUTH_TOKEN, CLAUDE_CREDENTIALS_FILE
# Cache: 5 min TTL at $XDG_CACHE_HOME/claude-usage.json (default ~/.cache)
# Override: CLAUDE_USAGE_CACHE, CLAUDE_USAGE_TTL (seconds)

set -euo pipefail

creds="${CLAUDE_CREDENTIALS_FILE:-$HOME/.claude/.credentials.json}"
tok="${CLAUDE_OAUTH_TOKEN:-}"
cache="${CLAUDE_USAGE_CACHE:-${XDG_CACHE_HOME:-$HOME/.cache}/claude-usage.json}"
ttl="${CLAUDE_USAGE_TTL:-300}"

now=$(date +%s)

if [[ -f "$cache" ]]; then
  cached_at=$(jq -r '.cached_at // 0' "$cache" 2>/dev/null || echo 0)
  if (( now - cached_at < ttl )); then
    cat "$cache"
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

mkdir -p "$(dirname "$cache")"
tmp="$(mktemp "${cache}.XXXXXX")"
trap 'rm -f "$tmp"' EXIT

curl -fsS \
  -H "Authorization: Bearer $tok" \
  -H 'anthropic-beta: oauth-2025-04-20' \
  https://api.anthropic.com/api/oauth/usage |
  jq -c --argjson now "$now" '
    (.five_hour.utilization // 0) as $s |
    (.seven_day.utilization // 0) as $w |
    (if   $w >= 80 then "critical"
     elif $w >= 50 then "warning"
     else              "ok"       end) as $state |
    {
      text: "session: \($s)%, weekly: \($w)%",
      alt: $state,
      tooltip: "Session: \($s)%\rWeekly: \($w)%\rUpdated: \($now | strflocaltime("%Y-%m-%d %H:%M:%S"))",
      class: $state,
      percentage: ($w | floor),
      cached_at: $now
    }
  ' > "$tmp"

mv "$tmp" "$cache"
cat "$cache"
