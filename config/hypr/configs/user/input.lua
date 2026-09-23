---------------
---- INPUT ----
---------------

hl.config({
    cursor = {
        sync_gsettings_theme = true,
        no_hardware_cursors = 1, -- software cursor: HW cursor plane vanishes in fullscreen games (dota2) on amdgpu+VRR. back to 2 (auto) if that stops happening
        enable_hyprcursor = true,
        warp_on_change_workspace = 1, -- 2 = force, overrides no_warps below and jumps the cursor on monitor unplug
        no_warps = true,
    },
})
