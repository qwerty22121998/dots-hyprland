
-----------------------------
--- ENVIRONMENT VARIABLES ---
-----------------------------

hl.env("XCURSOR_THEME", "capitaine-cursors-light")
hl.env("XCURSOR_SIZE", "24")
hl.env("HYPRCURSOR_SIZE", "24")

--- Toolkit Backend Variables ---
hl.env("GDK_BACKEND", "wayland,x11,*")
hl.env("CLUTTER_BACKEND", "wayland")


--- XDG Specifications ---
hl.env("XDG_CURRENT_DESKTOP", "Hyprland")
hl.env("XDG_SESSION_DESKTOP", "Hyprland")
hl.env("XDG_SESSION_TYPE", "wayland")

--- QT Variables ---
hl.env("QT_AUTO_SCREEN_SCALE_FACTOR", "1")
hl.env("QT_QPA_PLATFORM", "wayland;xcb")
hl.env("QT_WAYLAND_DISABLE_WINDOWDECORATION", "1")
hl.env("QT_QPA_PLATFORMTHEME", "qt6ct")

--- hyprland-qt-support ---
hl.env("QT_QUICK_CONTROLS_STYLE", "org.hyprland.style")
