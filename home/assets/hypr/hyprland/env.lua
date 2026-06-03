-- Wayland
hl.env("ELECTRON_OZONE_PLATFORM_HINT", "auto")

-- Themes
hl.env("QT_QPA_PLATFORM", "wayland;xcb")
hl.env("QT_QPA_PLATFORMTHEME", "kde")
hl.env("XDG_MENU_PREFIX", "plasma-")

hl.env("LANG", "zh_CN.UTF-8")
hl.env("LC_ALL", "zh_CN.UTF-8")

hl.env("NOCTALIA_PAM_SERVICE", "noctalia-shell")

-- Wayland
-- hl.env("WLR_DRM_NO_ATOMIC", "1")
-- hl.env("WLR_NO_HARDWARE_CURSORS", "1")

-- Terminal application
hl.env("TERMINAL", "kitty")

-- 环境变量
hl.env("XCURSOR_SIZE", "24")
hl.env("QT_IM_MODULE", "fcitx")
hl.env("GDK_DPI_SCALE", "1")
hl.env("QT_AUTO_SCREEN_SCALE_FACTOR", "0")
hl.env("GTK_IM_MODULE", "fcitx")
hl.env("XMODIFIERS", "@im=fcitx")
hl.env("SDL_IM_MODULE", "fcitx")
hl.env("GLFW_IM_MODULE", "fcitx")
