-- ~/.config/hypr/hyprland.lua

-- 显示器
hl.monitor({ output = "", mode = "preferred", position = "auto", scale = 1 })

-- 手势绑定
hl.gesture({ fingers = 3, direction = "swipe", action = "move" })
hl.gesture({ fingers = 3, direction = "pinch", action = "float" })
hl.gesture({ fingers = 4, direction = "horizontal", action = "workspace" })

hl.config({
    gestures = {
        workspace_swipe_distance = 700,
        workspace_swipe_cancel_ratio = 0.2,
        workspace_swipe_min_speed_to_force = 5,
        workspace_swipe_direction_lock = true,
        workspace_swipe_direction_lock_threshold = 10,
        workspace_swipe_create_new = true,
    },
    general = {
        gaps_in = 1.5,
        gaps_out = 3,
        gaps_workspaces = 50,
        border_size = 1,
        ["col.active_border"] = "rgba(0DB7D455)",
        ["col.inactive_border"] = "rgba(31313600)",
        resize_on_border = true,
        no_focus_fallback = true,
        allow_tearing = true,
        snap = {
            enabled = true,
            window_gap = 4,
            monitor_gap = 5,
            respect_gaps = true,
        },
    },
    dwindle = {
        preserve_split = true,
        smart_split = false,
        smart_resizing = false,
    },
    decoration = {
        rounding_power = 2.4,
        rounding = 10,
        blur = {
            enabled = true,
            size = 3,
            passes = 2,
            vibrancy = 0.1696,
        },
        shadow = {
            enabled = true,
            range = 4,
            render_power = 3,
            color = "rgba(1a1a1aee)",
        },
        dim_inactive = true,
        dim_strength = 0.05,
        dim_special = 0.07,
    },
    input = {
        kb_layout = "us",
        numlock_by_default = true,
        repeat_delay = 250,
        repeat_rate = 35,
        follow_mouse = 1,
        off_window_axis_events = 2,
        touchpad = {
            natural_scroll = true,
            disable_while_typing = true,
            clickfinger_behavior = true,
            scroll_factor = 0.5,
        },
    },
    misc = {
        disable_hyprland_logo = true,
        disable_splash_rendering = true,
        vrr = 1,
        mouse_move_enables_dpms = true,
        key_press_enables_dpms = true,
        animate_manual_resizes = false,
        animate_mouse_windowdragging = false,
        enable_swallow = false,
        swallow_regex = "(foot|kitty|allacritty|Alacritty)",
        on_focus_under_fullscreen = 2,
        allow_session_lock_restore = true,
        session_lock_xray = true,
        initial_workspace_tracking = false,
        focus_on_activate = true,
    },
    binds = {
        scroll_event_delay = 0,
        hide_special_on_workspace_change = true,
    },
    cursor = {
        zoom_factor = 1,
        zoom_rigid = false,
        zoom_disable_aa = true,
        hotspot_padding = 1,
    },
})

-- 动画
local curves = {
    expressiveFastSpatial    = { type = "bezier", points = { { 0.42, 1.67 }, { 0.21, 0.90 } } },
    expressiveSlowSpatial    = { type = "bezier", points = { { 0.39, 1.29 }, { 0.35, 0.98 } } },
    expressiveDefaultSpatial = { type = "bezier", points = { { 0.38, 1.21 }, { 0.22, 1.00 } } },
    emphasizedDecel          = { type = "bezier", points = { { 0.05, 0.7 }, { 0.1, 1 } } },
    emphasizedAccel          = { type = "bezier", points = { { 0.3, 0 }, { 0.8, 0.15 } } },
    standardDecel            = { type = "bezier", points = { { 0, 0 }, { 0, 1 } } },
    menu_decel               = { type = "bezier", points = { { 0.1, 1 }, { 0, 1 } } },
    menu_accel               = { type = "bezier", points = { { 0.52, 0.03 }, { 0.72, 0.08 } } },
    stall                    = { type = "bezier", points = { { 1, -0.1 }, { 0.7, 0.85 } } },
}
local animations = {
    { leaf = "windowsIn",           enabled = true, speed = 3,   bezier = "emphasizedDecel", style = "popin 80%" },
    { leaf = "fadeIn",              enabled = true, speed = 3,   bezier = "emphasizedDecel" },
    { leaf = "windowsOut",          enabled = true, speed = 2,   bezier = "emphasizedDecel", style = "popin 90%" },
    { leaf = "fadeOut",             enabled = true, speed = 2,   bezier = "emphasizedDecel" },
    { leaf = "windowsMove",         enabled = true, speed = 3,   bezier = "emphasizedDecel", style = "slide" },
    { leaf = "border",              enabled = true, speed = 10,  bezier = "emphasizedDecel" },
    { leaf = "layersIn",            enabled = true, speed = 2.7, bezier = "emphasizedDecel", style = "popin 93%" },
    { leaf = "layersOut",           enabled = true, speed = 2.4, bezier = "menu_accel",      style = "popin 94%" },
    { leaf = "fadeLayersIn",        enabled = true, speed = 0.5, bezier = "menu_decel" },
    { leaf = "fadeLayersOut",       enabled = true, speed = 2.7, bezier = "stall" },
    { leaf = "workspaces",          enabled = true, speed = 7,   bezier = "menu_decel",      style = "slide" },
    { leaf = "specialWorkspaceIn",  enabled = true, speed = 2.8, bezier = "emphasizedDecel", style = "slidevert" },
    { leaf = "specialWorkspaceOut", enabled = true, speed = 1.2, bezier = "emphasizedAccel", style = "slidevert" },
    { leaf = "zoomFactor",          enabled = true, speed = 3,   bezier = "emphasizedDecel" },
}
for name, curve_def in pairs(curves) do
    hl.curve(name, curve_def)
end
for _, anim in ipairs(animations) do
    hl.animation(anim)
end

-- 输入设备配置
hl.config({
    input = {
        touchpad = {
            natural_scroll = true,
            tap_and_drag = false,
            disable_while_typing = false,
            scroll_factor = 1,
        },
        sensitivity = 0,
        accel_profile = "adaptive",
    },
    xwayland = {
        force_zero_scaling = true,
        use_nearest_neighbor = false,
    },
})

-- 启动时加载 Xresources
hl.on("hyprland.start", function()
    hl.exec_cmd("xrdb ~/.Xresources")
end)

