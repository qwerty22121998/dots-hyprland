-- Hyprland Lua config entry point (the ACTIVE config; the old *.conf were removed).
-- Hyprland auto-picks `hyprland.lua` over `hyprland.conf` at startup (not on reload).
-- Old .conf is in git history if you ever need to diff/restore it.
-- require() resolves relative to this dir (~/.config/hypr).

-- default configs
require("configs.default.env")
require("configs.default.autostart")
require("configs.default.permissions")
require("configs.default.input")
require("configs.default.look_n_feel")
require("configs.default.keybinds")
require("configs.default.window_rules")

require("monitors")
require("workspaces")

-- user configs (loaded after defaults so they override)
require("configs.user.env")
require("configs.user.autostart")
require("configs.user.permissions")
require("configs.user.input")
require("configs.user.look_n_feel")
require("configs.user.keybinds")
require("configs.user.window_rules")
require("configs.user.animations")

-- mirrors ~/.config/hypremoji/hypremoji.conf (external, can't be sourced from Lua)
require("configs.user.hypremoji")
