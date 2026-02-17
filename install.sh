#!/bin/bash

CONFIG_DIR="$HOME/.config"
DOT_CONFIG_DIR="$PWD/.config"


rm_config_if_exists() {
    local r target="$CONFIG_DIR/$1"
    if [ -e "$target" ] || [ -L "$target" ]; then
        echo "Removing existing $target"
        rm -rf "$target"
    fi
}

install_config() {
    rm_config_if_exists "$1"
    local r target="$CONFIG_DIR/$1"
    echo "Linking $target to $DOT_CONFIG_DIR/$1"
    ln -snf "$DOT_CONFIG_DIR/$1" "$target"
}

configs=$(ls $DOT_CONFIG_DIR)

echo "Installing configurations..."

for config in $configs; do
    install_config "$config"
done

echo "Installation complete. Please restart your session to apply changes."
