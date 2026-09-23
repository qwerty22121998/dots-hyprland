-----------------------
---- LOOK AND FEEL ----
-----------------------

local colors = require("colors")

hl.config({
    general = {
        gaps_in = 4,
        gaps_out = 8,

        border_size = 2,

        col = {
            active_border = colors.color7,
            inactive_border = colors.color6,
        },

        resize_on_border = true,
        allow_tearing = true,

        layout = "dwindle",
    },

    render = {
        -- advertises wp_fifo_manager_v1; without it Dota 2's SDL3 probes for
        -- fifo-v1, doesn't find it, and forces itself onto XWayland
        new_render_scheduling = true,
    },
})
