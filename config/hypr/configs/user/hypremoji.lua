-- Mirror of ~/.config/hypremoji/hypremoji.conf (external file, sourced last in
-- hyprland.conf). Lua config can't source .conf, so it's inlined here. Keep in
-- sync if hypremoji regenerates its config.

hl.bind("SUPER + period", hl.dsp.exec_cmd("hypremoji"), { description = "emoji picker" })

hl.window_rule({ match = { title = "^(HyprEmoji)$" }, float = true })
hl.window_rule({ match = { title = "^(HyprEmoji)$" }, move = "(cursor_x-(window_w*0.5)) (cursor_y-(window_h*0.95))" })
hl.window_rule({ match = { title = "^(HyprEmoji)$" }, size = "334 340" })
