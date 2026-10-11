# DOTFILE

# Prerequisites
Everything pacman / the AUR can provide is listed in `packages.txt`:

```bash
paru -S --needed - < packages.txt
```

- hyprland: Wayland compositor (0.55+, Lua config)
- hyprlock, hypridle: Lock screen, idle daemon
- hyprpolkitagent: Polkit authentication agent
- waybar: Status bar (the cava module needs a cava-enabled build: `waybar-cava-git`, AUR)
- swaync: Notification daemon + notification center
- rofi: App launcher, dmenu
- awww: Wallpaper daemon
- wallust: Color scheme generator (`wallust-git`, AUR)
- cava: Audio visualizer
- wlogout: Logout menu
- grim, slurp: Screenshot tools
- cliphist, wl-clipboard: Clipboard history
- pamixer, playerctl: Volume control, media keys
- hyprpwcenter: Audio control panel
- libpulse, sound-theme-freedesktop: `paplay` and the notification / volume sounds
- libnotify: `notify-send`
- jq, curl: Used by the scripts
- kitty: Terminal emulator
- zsh: Shell
- starship: Prompt
- yazi: TUI file manager
- thunar: File manager
- fastfetch: System information display
- btop, nvtop: TUI system / GPU monitors
- nwg-look: GTK settings
- nwg-displays: Display/Workspace manager
- qt6ct: Qt settings
- network-manager-applet, networkmanager: Network tray, wifi toggle
- blueman, bluez-utils: Bluetooth manager, bluetooth toggle
- udiskie: Automount removable drives
- power-profiles-daemon: Power profile switcher
- fcitx5: Input method
- hypremoji: Emoji picker (AUR)
- ttf-jetbrains-mono-nerd, otf-commit-mono-nerd: Fonts
- capitaine-cursors: Cursor theme

Not packaged, install by hand:
- Pixelon font: hyprlock and wlogout
- gpu-usage-waybar: `cargo install gpu-usage-waybar`, feeds the GPU bar module


# Included scripts
- Show keybindings: SUPER + H
- Reload appearance
- Change hyprland animation
- Change waybar theme
- Change wallpaper
- Screenshot

# References
- Thanks JaKooLit for the inspiration.
