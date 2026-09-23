---------------------
---- KEYBINDINGS ----
---------------------

local mainMod = "SUPER"
local scriptsDir = "$HOME/.config/hypr/scripts"

hl.bind(mainMod .. " + SHIFT + E", hl.dsp.exec_cmd("hypremoji"), { description = "emoji picker" })

-- screenshot
hl.bind(mainMod .. " + SHIFT + S", hl.dsp.exec_cmd(scriptsDir .. "/screenshot.sh"), { description = "screenshot" })
hl.bind(mainMod .. " + SHIFT + CTRL + S", hl.dsp.exec_cmd(scriptsDir .. "/screenshot.sh save"), { description = "screenshot save" })

-- waybar: SUPER+T switches docked <-> overlay peek (bar hidden, shows over windows while SUPER held)
hl.bind(mainMod .. " + T", hl.dsp.exec_cmd(scriptsDir .. "/waybar_mode.sh toggle"), { description = "toggle waybar overlay mode" })
-- bare SUPER_L: at press time the SUPER modmask is not set yet, so no mainMod prefix
hl.bind("SUPER_L", hl.dsp.exec_cmd(scriptsDir .. "/waybar_mode.sh show"), { description = "peek waybar", non_consuming = true, ignore_mods = true })
hl.bind("SUPER_L", hl.dsp.exec_cmd(scriptsDir .. "/waybar_mode.sh hide"), { description = "unpeek waybar", release = true, non_consuming = true, ignore_mods = true })
