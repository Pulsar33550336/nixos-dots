-- ======== Window rules ========

-- Disable blur for xwayland context menus
hl.window_rule({
    match = { class = "^()$", title = "^()$" },
    no_blur = true
})

-- Disable blur for every window (commented)
-- hl.window_rule({
--   match = { class = ".*" },
--   no_blur = true
-- })

-- Floating dialogs - by title patterns
local float_dialog_titles = {
    "^(Open File)(.*)$",
    "^(Select a File)(.*)$",
    "^(Choose wallpaper)(.*)$",
    "^(Open Folder)(.*)$",
    "^(Save As)(.*)$",
    "^(Library)(.*)$",
    "^(File Upload)(.*)$",
    "^(.*)(wants to save)$",
    "^(.*)(wants to open)$"
}

for _, title_pattern in ipairs(float_dialog_titles) do
    hl.window_rule({
        match = { title = title_pattern },
        center = true,
        float = true
    })
end

-- Choose wallpaper special size rule
hl.window_rule({
    match = { title = "^(Choose wallpaper)(.*)$" },
    center = true,
    float = true,
    size = { "monitor_w*.60", "monitor_h*.65" }
})

-- blueberry.py
hl.window_rule({
    match = { class = "^(blueberry%.py)$" },
    float = true
})

-- guifetch
hl.window_rule({
    match = { class = "^(guifetch)$" },
    float = true
})

-- pavucontrol (both variants)
for _, class_name in ipairs({ "^(pavucontrol)$", "^(org.pulseaudio.pavucontrol)$", "^(pavucontrol-qt)$" }) do
    hl.window_rule({
        match = { class = class_name },
        float = true,
        size = { "monitor_w*.45", "monitor_h*.45" },
        center = true
    })
end

-- nm-connection-editor
hl.window_rule({
    match = { class = "^(nm-connection-editor)$" },
    float = true,
    size = { "monitor_w*.45", "monitor_h*.45" },
    center = true
})

-- plasma windowed
hl.window_rule({
    match = { class = ".*plasmawindowed.*" },
    float = true
})

-- kcm_* (KDE config modules)
hl.window_rule({
    match = { class = "kcm_.*" },
    float = true
})

-- bluedevilwizard
hl.window_rule({
    match = { class = ".*bluedevilwizard" },
    float = true
})

-- Welcome window
hl.window_rule({
    match = { title = ".*Welcome" },
    float = true
})

-- Shell conflicts
hl.window_rule({
    match = { title = ".*Shell conflicts.*" },
    float = true
})

-- KDE portal
hl.window_rule({
    match = { class = "org.freedesktop.impl.portal.desktop.kde" },
    float = true,
    center = true,
    size = { "monitor_w*.60", "monitor_h*.65" }
})

-- Zotero
hl.window_rule({
    match = { class = "^(Zotero)$" },
    float = true,
    size = { "monitor_w*.45", "monitor_h*.45" }
})

-- Move rules
-- plasma-changeicons: move off-screen
hl.window_rule({
    match = { class = "^(plasma-changeicons)$" },
    float = true,
    no_initial_focus = true,
    move = { 999999, 999999 }
})

-- Dolphin copy dialog
hl.window_rule({
    match = { title = "^(Copying — Dolphin)$" },
    move = { 40, 80 }
})

-- Tiling
hl.window_rule({
    match = { class = "^dev%.warp%.Warp$" },
    tile = true
})

-- Picture-in-Picture
hl.window_rule({
    match = { title = "^([Pp]icture[%-s]?[Ii]n[%-s]?[Pp]icture)(.*)$" },
    float = true,
    keep_aspect_ratio = true,
    move = { "monitor_w * .73", "monitor_h * .72" },
    size = { "monitor_w * .25", "monitor_h * .25" },
    pin = true
})

-- Tearing (immediate mode for performance)
local immediate_patterns = { ".*%.exe", ".*minecraft.*", "^(steam_app).*" }
for _, pattern in ipairs(immediate_patterns) do
    hl.window_rule({
        match = { title = pattern },
        immediate = true
    })
end

-- Fix JetBrains IDEs focus/rerendering problem
hl.window_rule({
    match = { class = "^jetbrains-.*$", float = 1, title = "^$|^%s$|^win%d+$" },
    no_initial_focus = true
})

-- No shadow for tiled windows (non-floating)
hl.window_rule({
    match = { float = 0 },
    no_shadow = true
})

-- ======== Workspace rules ========
hl.workspace_rule({
    workspace = "special:special",
    gaps_out = 30
})

-- ======== Layer rules ========
-- xray on for all layer surfaces
hl.layer_rule({
    match = { namespace = ".*" },
    xray = true
})

-- No animations for specific namespaces
local no_anim_namespaces = {
    "walker", "selection", "overview", "anyrun",
    "indicator.*", "osk", "hyprpicker", "noanim",
    "logout_dialog", "gtk4-layer-shell", "noctalia-shell:regionSelector"
}
for _, ns in ipairs(no_anim_namespaces) do
    hl.layer_rule({
        match = { namespace = ns },
        no_anim = true
    })
end

-- Blur rules for layer surfaces
hl.layer_rule({
    match = { namespace = "gtk-layer-shell" },
    blur = true,
    ignore_alpha = 0
})

hl.layer_rule({
    match = { namespace = "launcher" },
    blur = true,
    ignore_alpha = 0.5
})

hl.layer_rule({
    match = { namespace = "notifications" },
    blur = true,
    ignore_alpha = 0.69
})

-- 全局透明（所有窗口）
hl.window_rule({
    match = { class = ".*" },
    opacity = "0.97 override 0.97 override",
})

-- XWayland 窗口强制不透明
hl.window_rule({
    match = { xwayland = true },
    opacity = "1.0 override 1.0 override 1.0 override",
})