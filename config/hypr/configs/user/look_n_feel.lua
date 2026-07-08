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
})
