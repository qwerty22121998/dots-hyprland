#!/bin/bash
set -euo pipefail
shopt -s nullglob

CONFIG_DIR="$HOME/.config"
DOT_CONFIG_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/config" && pwd)"

DRY_RUN=0
if [ "${1:-}" = "--dry-run" ]; then DRY_RUN=1; fi

run() {
    if [ "$DRY_RUN" = 1 ]; then
        echo "        would: $*"
    else
        "$@"
    fi
}

install_config() {
    local name="$1"
    local src="$DOT_CONFIG_DIR/$name"
    local target="$CONFIG_DIR/$name"

    if [ "$(readlink -f "$target" 2>/dev/null)" = "$(readlink -f "$src")" ]; then
        echo "ok      $name"
        return
    fi

    # ponytail: back up instead of rm -rf, one bad run shouldn't eat a config.
    # Single .bak per config, overwritten each install.
    if [ -e "$target" ] || [ -L "$target" ]; then
        local backup="$target.bak"
        echo "backup  $name -> $name.bak"
        run rm -rf "$backup"
        run mv "$target" "$backup"
    fi

    echo "link    $name"
    run ln -snf "$src" "$target"
}

if [ "$DRY_RUN" = 1 ]; then echo "(dry run, nothing will change)"; fi
echo "Installing configurations..."

run mkdir -p "$CONFIG_DIR"
for config in "$DOT_CONFIG_DIR"/*; do
    install_config "$(basename "$config")"
done

echo "Installation complete. Please restart your session to apply changes."
