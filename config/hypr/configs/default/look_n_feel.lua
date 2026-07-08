-----------------------
---- LOOK AND FEEL ----
-----------------------

hl.config({
    general = {
        resize_on_border = true,
        allow_tearing = false,
        layout = "dwindle",
    },

    decoration = {
        rounding = 8,
        rounding_power = 2,

        active_opacity = 1.0,
        inactive_opacity = 0.9,
        fullscreen_opacity = 1.0,

        dim_inactive = false,
        dim_strength = 0.1,
        dim_special = 0.8,

        shadow = {
            enabled = false,
            range = 2,
            render_power = 1,
            color = "rgba(1a1a1aee)",
            color_inactive = "rgba(1a1a1aee)",
        },

        blur = {
            enabled = true,
            size = 5,
            passes = 0,
            new_optimizations = true,
            xray = true,
            ignore_opacity = true,
            special = true,
            popups = true,
        },
    },

    dwindle = {
        preserve_split = true,
    },

    master = {
        new_status = "master",
    },

    misc = {
        force_default_wallpaper = -1,
        disable_hyprland_logo = true,
        disable_splash_rendering = true,
    },
})
