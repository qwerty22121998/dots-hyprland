---------------------
---- KEYBINDINGS ----
---------------------

local mainMod = "SUPER"
local scriptsDir = "$HOME/.config/hypr/scripts"

hl.bind(mainMod .. " + SHIFT + E", hl.dsp.exec_cmd("hypremoji"), { description = "emoji picker" })

-- screenshot
hl.bind(mainMod .. " + SHIFT + S", hl.dsp.exec_cmd(scriptsDir .. "/screenshot.sh"), { description = "screenshot" })
hl.bind(mainMod .. " + SHIFT + CTRL + S", hl.dsp.exec_cmd(scriptsDir .. "/screenshot.sh save"), { description = "screenshot save" })
