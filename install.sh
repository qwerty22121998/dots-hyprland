#!/bin/bash

CONFIG_DIR="$HOME/.config"
DOT_CONFIG_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/config" && pwd)"


rm_config_if_exists() {
    local target="$CONFIG_DIR/$1"
    if [ -e "$target" ] || [ -L "$target" ]; then
        echo "Removing existing $target"
        rm -rf "$target"
    fi
}

install_config() {
    rm_config_if_exists "$1"
    local target="$CONFIG_DIR/$1"
    echo "Linking $target to $DOT_CONFIG_DIR/$1"
    ln -snf "$DOT_CONFIG_DIR/$1" "$target"
}

echo "Installing configurations..."

mkdir -p "$CONFIG_DIR"
for config in "$DOT_CONFIG_DIR"/*; do
    install_config "$(basename "$config")"
done

echo "Installation complete. Please restart your session to apply changes."
