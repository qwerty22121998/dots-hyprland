------------------------------
---- WINDOWS AND WORKSPACES --
------------------------------

hl.window_rule({
    name = "jetbrain pop up",
    match = { initial_class = "^jetbrains-.+", float = true },
    center = true,
    focus_on_activate = true,
})

hl.window_rule({
    name = "steam friend list",
    match = { initial_class = "steam", title = "Friends List" },
    float = true,
})

hl.window_rule({ match = { class = "^(dota2)$" }, tag = "+games", content = "game" })
hl.window_rule({ match = { class = "^steam_app_.+" }, tag = "+games", content = "game" })

-- POE
hl.window_rule({
    name = "Awakened POE Trade",
    match = { class = "^(awakened-poe-trade)$" },
    float = true,
    no_blur = true,
    no_shadow = true,
    border_size = 0,
})
hl.bind("CTRL + ALT + D", hl.dsp.pass({ window = "class:awakened-poe-trade" }))

hl.window_rule({
    name = "exiled-exchange",
    match = { class = "^(exiled-exchange-2)$" },
    no_blur = true,
})
hl.bind("CTRL + d", hl.dsp.pass({ window = "class:^(exiled-exchange-2)$" }))

-- Window rules for HyprEmoji
hl.window_rule({ match = { title = "^(HyprEmoji)$" }, float = true })
hl.window_rule({ match = { title = "^(HyprEmoji)$" }, move = "(cursor_x-(window_w*0.5)) (cursor_y-(window_h*0.05))" })

-- kicad (disabled in the original config)
-- hl.window_rule({ match = { class = "^KiCad$", float = true }, tag = "+work", content = "kicad", center = true })

hl.window_rule({ match = { class = "steam_app_1774580" }, no_vrr = 1 })
hl.window_rule({ match = { class = "steam_app_1044720" }, no_vrr = 1 })
