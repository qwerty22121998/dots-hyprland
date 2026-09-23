-------------------
---- AUTOSTART ----
-------------------

hl.on("hyprland.start", function()
    hl.exec_cmd('hyprctl setcursor "Capitaine Cursors - White" 30')
    hl.exec_cmd("udiskie --smart-tray")
end)
