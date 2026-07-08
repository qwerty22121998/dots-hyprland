--- fcitx ---
hl.env("XMODIFIERS", "@im=fcitx")
hl.env("SDL_IM_MODULE", "fcitx")
hl.env("GLFW_IM_MODULE", "fcitx")

--- electron app ---
hl.env("ELECTRON_OZONE_PLATFORM_HINT", "auto")

--- AMD ---
hl.env("PROTON_FSR4_UPGRADE", "1")
hl.env("ENABLE_LAYER_MESA_ANTI_LAG", "1")
hl.env("PROTON_FSR4_RDNA3_UPGRADE", "1")
hl.env("PROTON_XESS_UPGRADE", "1")

--- proton ---
hl.env("PROTON_USE_NTSYNC", "1")
hl.env("PROTON_ENABLE_WAYLAND", "1")
hl.env("PROTON_NO_WM_DECORATION", "1")
hl.env("PROTON_ENABLE_HDR", "1")
hl.env("DXVK_HDR", "1")
