-------------------
---- AUTOSTART ----
-------------------

hl.on("hyprland.start", function()
    hl.exec_cmd('hyprctl setcursor capitaine-cursors-light 24')
    hl.exec_cmd("udiskie --smart-tray")
end)
