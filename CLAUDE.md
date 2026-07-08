# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

Personal Hyprland (Wayland) dotfiles. No build/test/lint — everything here is config and shell scripts. Inspired by JaKooLit's setup.

## Install

```bash
./install.sh   # symlinks every config/<name> → ~/.config/<name> (rm -rf's existing first)
```

Configs are **symlinked, not copied** — editing a file in this repo takes effect live in `~/.config`. No re-install needed after the first run. `install.sh` blindly `rm -rf`s any existing `~/.config/<name>` before linking, so anything not tracked here is destroyed on install.

## Hyprland config layout

**Config is Lua** (Hyprland 0.55+ `hl` API). `config/hypr/hyprland.lua` is the entry point — Hyprland auto-picks `hyprland.lua` over `hyprland.conf` at **startup** (not on reload). It `require`s, in order:
1. `configs/default/*.lua` — base config
2. `monitors.lua`, `workspaces.lua`
3. `configs/user/*.lua` — **overrides**, required last so they win
4. `configs/user/hypremoji.lua` — inlines the external `~/.config/hypremoji/hypremoji.conf` (Lua can't `source` a `.conf`)

Put machine/personal tweaks in `configs/user/`, not `configs/default/`. Both dirs have parallel modules (`env`, `input`, `keybinds`, `look_n_feel`, `window_rules`, `permissions`, `autostart`). `colors.lua` (wallust-generated) is `require`d by `configs/user/look_n_feel.lua` for border colors.

The old `.conf` config was fully migrated to `.lua` and **removed** (it's in git history). The only `.conf` left under `config/hypr/` are `hypridle.conf` and `hyprlock.conf` — separate daemons, NOT part of the Hyprland config. `.luarc.json` wires up the `hl` global + LSP stubs (`/usr/share/hypr/stubs/hl.meta.lua`).

Gotchas in Lua mode:
- **`hyprctl reload` cannot hot-swap `.conf`↔`.lua`** — a running instance re-reads the *path it launched with*. Switching formats needs a full restart / re-login. (If the launch-path config is missing on reload, Hyprland generates a stub default — don't rename the active config out from under a running session.)
- `$terminal`/`$scriptsDir`-style conf vars don't exist in Lua — use Lua locals + `..`. `$HOME` still works (shell-expanded in `exec`).
- Validate before switching: `Hyprland --config <path>/hyprland.lua --verify-config` (evaluates dispatchers/rules, not just syntax).
- `monitors.lua`/`workspaces.lua` must be hand-edited — nwg-displays only writes the `.conf` versions.
- `colors.lua` is wallust-generated (template `wallust/templates/hyprland.lua`) — don't hand-edit it.
- The animation swapper is Lua too: `change_anim.sh` copies `animations/*.lua` presets over `configs/user/animations.lua`.

## Theming pipeline (wallust — generated files, do not hand-edit)

Changing the wallpaper regenerates the color scheme:

`scripts/change_wallpaper.sh` (rofi picker) → `awww img` → `scripts/wallpaper.sh` → `wallust run <wallpaper>`

`wallust run` renders `config/wallust/templates/*` into these **generated targets** (per `wallust/wallust.toml [templates]`) — edits here get overwritten:
- `hypr/colors.lua` (a Lua table `{ background, foreground, color0..15 }`, `require`d by `look_n_feel.lua`)
- `waybar/wallust.css`
- `mako/color.conf`

To change *how* colors map, edit the templates in `wallust/templates/`, not the targets. `awww` (not `swww`) is the wallpaper daemon in this setup. wallust is **v4-alpha** — its config differs from v3 (e.g. `kmeans` is now a `palette`, not a `backend`); run `wallust migrate` cautions apply.

## Waybar (swappable layouts + themes)

The **active** files are `waybar/config.jsonc` and `waybar/style.css`. Both are copies written by swap scripts and get overwritten — edit the sources instead:
- Layouts (module arrangement): `waybar/layouts/*.jsonc` → `change_waybar_layout.sh` copies one over `config.jsonc`
- Themes (styling): `waybar/themes/*.css` → `change_waybar_theme.sh` copies one over `style.css`

Module definitions live in `waybar/modules/*.jsonc`; layouts reference them via `include`.

## Scripts (`config/hypr/scripts/`)

The `change_*.sh` scripts all follow the same shape: rofi picker → swap a file → notify/refresh. Keybinds live in `configs/{default,user}/keybinds.lua`; SUPER+H shows the cheatsheet via `keybind_parser.sh`, which reads live `hyprctl binds` (not a file).

- `refresh.sh` — restart waybar/swaync/mako, re-run wallpaper + reload Hyprland (run after config edits that aren't picked up live)
- `trcc.sh` — crops current wallpaper to a 1:1 `square.jpg` (used by lock/idle)
- `claude-usage.sh` — outputs `{"session","weekly"}` usage % for a waybar module (reads OAuth token from `~/.claude/.credentials.json`, 5-min cache)

## quickshell (experimental QML bar)

`config/quickshell/` is an alternative bar written in QML — untracked/experimental, separate from waybar. Two variants: `basic_bar/` (entry `shell.qml`) and `bars/`. Not wired into the Hyprland autostart.
