-------------------
---- AUTOSTART ----
-------------------

hl.on("hyprland.start", function()
    hl.exec_cmd("dbus-update-activation-environment --systemd WAYLAND_DISPLAY XDG_CURRENT_DESKTOP")
    hl.exec_cmd("systemctl --user import-environment WAYLAND_DISPLAY XDG_CURRENT_DESKTOP")
    hl.exec_cmd("systemctl --user start hyprpolkitagent")
    hl.exec_cmd("awww-daemon")
    hl.exec_cmd("swaync")
    hl.exec_cmd("wl-paste --type text --watch cliphist store")
    hl.exec_cmd("wl-paste --type image --watch cliphist store")
    -- always docked at login: waybar_mode.sh's state files in /tmp outlive a logout
    hl.exec_cmd("rm -f /tmp/waybar-overlay-mode /tmp/waybar-peek-shown; waybar")
    hl.exec_cmd("hypridle")
    hl.exec_cmd("nm-applet --indicator")
end)
