-- 定义变量
local ipc             = "noctalia-shell ipc call"

local dk              = require("hyprland.scripts.dummy_keys")

-- 工作区切换辅助函数
local num_keycodes    = { 10, 11, 12, 13, 14, 15, 16, 17, 18, 19 }
local numpad_keycodes = { 87, 88, 89, 83, 84, 85, 79, 80, 81, 90 }

local function move_to_ws(n)
    return function()
        local curr = hl.get_active_workspace().id
        local target = math.floor((curr - 1) / 10) * 10 + n
        hl.dispatch(hl.dsp.window.move({ workspace = target, follow = false }))
    end
end

local function focus_ws(n)
    return function()
        local curr = hl.get_active_workspace().id
        local target = math.floor((curr - 1) / 10) * 10 + n
        hl.dispatch(hl.dsp.focus({ workspace = target }))
    end
end

-- 1. 启动器/Shell
hl.bind("SUPER + Super_L", hl.dsp.exec_cmd(ipc .. " launcher toggle"),
    { release = true, description = "[启动器/Shell 1] 启动器" })
hl.bind("SUPER + Super_R", hl.dsp.exec_cmd(ipc .. " launcher toggle"),
    { release = true, description = "[启动器/Shell hidden] 启动器" })
hl.bind("SUPER + V", hl.dsp.exec_cmd(ipc .. " launcher clipboard"),
    { description = "[启动器/Shell hidden] 剪贴板历史 >> 剪贴板" })
hl.bind("SUPER + Period", hl.dsp.exec_cmd(ipc .. " launcher emoji"),
    { description = "[启动器/Shell 3] 表情符号 >> 剪贴板" })
hl.bind("SUPER + A", hl.dsp.exec_cmd(ipc .. " controlCenter toggle"),
    { description = "[启动器/Shell 4] 切换侧边栏" })
hl.bind("SUPER + B", hl.dsp.exec_cmd(ipc .. " controlCenter toggle"),
    { description = "[启动器/Shell hidden] 切换侧边栏" })
hl.bind("SUPER + O", hl.dsp.exec_cmd(ipc .. " controlCenter toggle"),
    { description = "[启动器/Shell hidden] 切换侧边栏" })
hl.bind("SUPER + N", hl.dsp.exec_cmd(ipc .. " controlCenter toggle"),
    { description = "[启动器/Shell hidden] 切换侧边栏" })
hl.bind("SUPER + Slash", hl.dsp.exec_cmd(ipc .. " plugin:keybind-cheatsheet toggle"),
    { description = "[启动器/Shell 5] 切换速查表" })
hl.bind("SUPER + M", hl.dsp.exec_cmd(ipc .. " media toggle"),
    { description = "[启动器/Shell 6] 切换媒体控件" })
hl.bind("CTRL + ALT + Delete", hl.dsp.exec_cmd(ipc .. " sessionMenu toggle"),
    { description = "[启动器/Shell 7] 切换会话菜单" })
hl.bind("SUPER + J", hl.dsp.exec_cmd(ipc .. " bar toggle"),
    { description = "[启动器/Shell 8] 切换顶栏" })
hl.bind("CTRL + ALT + Delete", hl.dsp.exec_cmd(ipc .. " TEST_ALIVE || pkill wlogout || wlogout -p layer-shell"),
    { description = "[启动器/Shell hidden] 会话菜单 (备用)" })

hl.bind("XF86MonBrightnessUp", hl.dsp.exec_cmd(ipc .. " brightness increase"),
    { locked = true, repeating = true, description = "[启动器/Shell hidden] 增加亮度" })
hl.bind("XF86MonBrightnessDown", hl.dsp.exec_cmd(ipc .. " brightness decrease"),
    { locked = true, repeating = true, description = "[启动器/Shell hidden] 减少亮度" })
hl.bind("XF86AudioRaiseVolume", hl.dsp.exec_cmd(ipc .. " volume increase"),
    { locked = true, repeating = true, description = "[启动器/Shell hidden] 增加音量" })
hl.bind("XF86AudioLowerVolume", hl.dsp.exec_cmd(ipc .. " volume decrease"),
    { locked = true, repeating = true, description = "[启动器/Shell hidden] 减少音量" })
hl.bind("SUPER + SHIFT + M", hl.dsp.exec_cmd(ipc .. " volume muteOutput"),
    { locked = true, description = "[启动器/Shell 9] 切换静音" })
hl.bind("XF86AudioMute", hl.dsp.exec_cmd(ipc .. " volume muteOutput"),
    { locked = true, description = "[启动器/Shell hidden] 切换静音" })
hl.bind("ALT + XF86AudioMute", hl.dsp.exec_cmd(ipc .. " volume muteOutput"),
    { locked = true, description = "[启动器/Shell hidden] 切换静音" })
hl.bind("XF86AudioMicMute", hl.dsp.exec_cmd(ipc .. " volume muteOutput"),
    { locked = true, description = "[启动器/Shell hidden] 切换静音" })
hl.bind("SUPER + ALT + M", hl.dsp.exec_cmd(ipc .. " volume muteInput"),
    { locked = true, description = "[启动器/Shell 10] 切换麦克风" })

hl.bind("CTRL + SUPER + T", hl.dsp.exec_cmd(ipc .. " wallpaper toggle"),
    { description = "[启动器/Shell 11] 壁纸选择器" })
hl.bind("CTRL + SUPER + ALT + T", hl.dsp.exec_cmd(ipc .. " wallpaper random"),
    { description = "[启动器/Shell 12] 随机壁纸" })
hl.bind("CTRL + SUPER + R", hl.dsp.exec_cmd("pkill quickshell; noctalia-shell --allow-duplicate &"),
    { description = "[启动器/Shell 13] 重启 Noctalia Shell" })

-- 2. 实用工具
-- 截图、录屏、OCR、取色器、剪贴板历史
hl.bind("SUPER + SHIFT + S", hl.dsp.exec_cmd(ipc .. " plugin:screen-shot-and-record screenshot"),
    { description = "[实用工具 1] 区域截图" })
hl.bind("SUPER + SHIFT + A", hl.dsp.exec_cmd(ipc .. " plugin:screen-shot-and-record search"),
    { description = "[实用工具 2] 以图搜图 (Google Lens)" })
-- OCR
hl.bind("SUPER + SHIFT + X", hl.dsp.exec_cmd(ipc .. " plugin:screen-shot-and-record ocr"),
    { description = "[实用工具 3] 文字识别 >> 剪贴板" })
hl.bind("SUPER + SHIFT + T", hl.dsp.exec_cmd(ipc .. " plugin:screen-shot-and-record ocr"),
    { description = "[实用工具 hidden] 文字识别 >> 剪贴板" })
-- 取色器
hl.bind("SUPER + SHIFT + C", hl.dsp.exec_cmd("hyprpicker -a"),
    { description = "[实用工具 4] 取色器(十六进制) >> 剪贴板" })
-- 全屏截图
hl.bind("Print", hl.dsp.exec_cmd("grim - | wl-copy"),
    { locked = true, description = "[实用工具 5] 截图 >> 剪贴板" })
hl.bind("CTRL + Print",
    hl.dsp.exec_cmd(
        "mkdir -p $(xdg-user-dir PICTURES)/Screenshots && grim $(xdg-user-dir PICTURES)/Screenshots/Screenshot_\"$(date '+%Y-%m-%d_%H.%M.%S')\".png"),
    { locked = true, description = "[实用工具 6] 截图 >> 剪贴板 & 文件(图片)" })
hl.bind("CTRL + Print", hl.dsp.exec_cmd("grim - | wl-copy"),
    { locked = true, description = "[实用工具 hidden] 截图 >> 剪贴板" })
-- 录屏相关
hl.bind("SUPER + SHIFT + R", hl.dsp.exec_cmd(ipc .. " plugin:screen-shot-and-record record"),
    { locked = true, description = "[实用工具 7] 录制区域 (无声音)" })
hl.bind("SUPER + ALT + R", hl.dsp.exec_cmd(ipc .. " plugin:screen-shot-and-record record"),
    { locked = true, description = "[实用工具 hidden] 录制区域 (无声音)" })
hl.bind("CTRL + ALT + R", hl.dsp.exec_cmd("~/.config/hypr/hyprland/scripts/record.sh --fullscreen"),
    { locked = true, description = "[实用工具 hidden] 录制区域 (无声音)" })
hl.bind("SUPER + SHIFT + ALT + R", hl.dsp.exec_cmd("~/.config/hypr/hyprland/scripts/record.sh --fullscreen --sound"),
    { locked = true, description = "[实用工具 8] 录制全屏 (有声音)" })

-- 3. 窗口
-- 聚焦
hl.bind("SUPER + mouse:272", hl.dsp.window.drag(), { mouse = true, description = "[窗口 1] 移动" })
hl.bind("SUPER + mouse:274", hl.dsp.window.drag(), { mouse = true, description = "[窗口 hidden] 移动" })
hl.bind("SUPER + mouse:273", hl.dsp.window.resize(), { mouse = true, description = "[窗口 2] 调整大小" })

dk.bind("SUPER + ←/↑/→/↓", "[窗口 3] 按方向聚焦")
hl.bind("SUPER + Left", hl.dsp.focus({ direction = "l" }), { description = "[窗口 hidden]" })
hl.bind("SUPER + Right", hl.dsp.focus({ direction = "r" }), { description = "[窗口 hidden]" })
hl.bind("SUPER + Up", hl.dsp.focus({ direction = "u" }), { description = "[窗口 hidden]" })
hl.bind("SUPER + Down", hl.dsp.focus({ direction = "d" }), { description = "[窗口 hidden]" })
hl.bind("SUPER + BracketLeft", hl.dsp.focus({ direction = "l" }), { description = "[窗口 hidden]" })
hl.bind("SUPER + BracketRight", hl.dsp.focus({ direction = "r" }), { description = "[窗口 hidden]" })

dk.bind("SUPER + SHIFT + ←/↑/→/↓", "[窗口 4] 按方向移动")
hl.bind("SUPER + SHIFT + Left", hl.dsp.window.move({ direction = "l" }), { description = "[窗口 hidden]" })
hl.bind("SUPER + SHIFT + Right", hl.dsp.window.move({ direction = "r" }), { description = "[窗口 hidden]" })
hl.bind("SUPER + SHIFT + Up", hl.dsp.window.move({ direction = "u" }), { description = "[窗口 hidden]" })
hl.bind("SUPER + SHIFT + Down", hl.dsp.window.move({ direction = "d" }), { description = "[窗口 hidden]" })

hl.bind("ALT + F4", hl.dsp.window.close(), { description = "[窗口 hidden] 关闭 (Windows方式)" })
hl.bind("SUPER + Q", hl.dsp.window.close(), { description = "[窗口 5] 关闭窗口" })
hl.bind("SUPER + SHIFT + ALT + Q", hl.dsp.exec_cmd("hyprctl kill"), { description = "[窗口 6] 强制关闭窗口" })

-- 窗口分割比例
dk.bind("SUPER + ;/'", "[窗口 7] 调整分割比例")
hl.bind("SUPER + Semicolon", hl.dsp.layout("splitratio -0.1"), { description = "[窗口 hidden]" })
hl.bind("SUPER + Apostrophe", hl.dsp.layout("splitratio 0.1"), { description = "[窗口 hidden]" })

-- 位置模式
hl.bind("SUPER + ALT + Space", hl.dsp.window.float({ action = "toggle" }), { description = "[窗口 8] 浮动/平铺" })
hl.bind("SUPER + D", hl.dsp.window.fullscreen({ mode = "maximized" }), { description = "[窗口 9] 最大化" })
hl.bind("SUPER + F", hl.dsp.window.fullscreen({ mode = "fullscreen" }), { description = "[窗口 10] 全屏" })
hl.bind("SUPER + ALT + F", hl.dsp.window.fullscreen_state({ internal = 0, client = 3 }),
    { description = "[窗口 11] 伪全屏" })
hl.bind("SUPER + P", hl.dsp.window.pin(), { description = "[窗口 12] 置顶" })

-- 我们使用原始键码，因为一些键盘布局会将数字键注册为不同的字符。可以通过 `wev` 验证键码
dk.bind("SUPER + ALT + 0-9", "[窗口 13] 发送到工作区 0 ~ 9")
for i, code in ipairs(num_keycodes) do
    hl.bind("SUPER + ALT + code:" .. code, move_to_ws(i), { description = "[窗口 hidden]" })
end
-- 小键盘数字键
for i, code in ipairs(numpad_keycodes) do
    hl.bind("SUPER + ALT + code:" .. code, move_to_ws(i), { description = "[窗口 hidden]" })
end

dk.bind("SUPER + SHIFT + Scroll ↑/↓", "[窗口 14] 发送到左/右工作区")
hl.bind("SUPER + SHIFT + mouse_down", hl.dsp.window.move({ workspace = "r-1" }), { description = "[窗口 hidden]" })
hl.bind("SUPER + SHIFT + mouse_up", hl.dsp.window.move({ workspace = "r+1" }), { description = "[窗口 hidden]" })
hl.bind("SUPER + ALT + mouse_down", hl.dsp.window.move({ workspace = "-1" }), { description = "[窗口 hidden]" })
hl.bind("SUPER + ALT + mouse_up", hl.dsp.window.move({ workspace = "+1" }), { description = "[窗口 hidden]" })

dk.bind("SUPER + SHIFT + Page_↑/↓", "[窗口 15] 发送到左/右工作区")
hl.bind("SUPER + ALT + Page_Down", hl.dsp.window.move({ workspace = "+1" }), { description = "[窗口 hidden]" })
hl.bind("SUPER + ALT + Page_Up", hl.dsp.window.move({ workspace = "-1" }), { description = "[窗口 hidden]" })
hl.bind("SUPER + SHIFT + Page_Down", hl.dsp.window.move({ workspace = "r+1" }), { description = "[窗口 hidden]" })
hl.bind("SUPER + SHIFT + Page_Up", hl.dsp.window.move({ workspace = "r-1" }), { description = "[窗口 hidden]" })
hl.bind("CTRL + SUPER + SHIFT + Right", hl.dsp.window.move({ workspace = "r+1" }), { description = "[窗口 hidden]" })
hl.bind("CTRL + SUPER + SHIFT + Left", hl.dsp.window.move({ workspace = "r-1" }), { description = "[窗口 hidden]" })

hl.bind("SUPER + ALT + S", hl.dsp.window.move({ workspace = "special" }),
    { description = "[窗口 16] 发送到便笺工作区" })
hl.bind("CTRL + SUPER + S", hl.dsp.workspace.toggle_special(), { description = "[窗口 hidden] 切换便笺工作区" })

-- 4. 工作区
-- 切换
-- 我们使用原始键码，因为一些键盘布局会将数字键注册为不同的字符。可以通过 `wev` 验证键码
dk.bind("SUPER + 0-9", "[工作区 1] 聚焦工作区 0~9")
for i, code in ipairs(num_keycodes) do
    hl.bind("SUPER + code:" .. code, focus_ws(i), { description = "[工作区 hidden]" })
end
-- 小键盘数字键
for i, code in ipairs(numpad_keycodes) do
    hl.bind("SUPER + code:" .. code, focus_ws(i), { description = "[工作区 hidden]" })
end

dk.bind("CTRL + SUPER + ←/→", "[工作区 2] 聚焦左/右")
hl.bind("CTRL + SUPER + Right", hl.dsp.focus({ workspace = "r+1" }), { description = "[工作区 hidden]" })
hl.bind("CTRL + SUPER + Left", hl.dsp.focus({ workspace = "r-1" }), { description = "[工作区 hidden]" })

dk.bind("CTRL + SUPER + ALT + ←/→", "[工作区 3] 聚焦有窗口的左/右")
hl.bind("CTRL + SUPER + ALT + Right", hl.dsp.focus({ workspace = "m+1" }), { description = "[工作区 hidden]" })
hl.bind("CTRL + SUPER + ALT + Left", hl.dsp.focus({ workspace = "m-1" }), { description = "[工作区 hidden]" })

dk.bind("SUPER + Page_↑/↓", "[工作区 3] 聚焦左/右")
hl.bind("SUPER + Page_Down", hl.dsp.focus({ workspace = "+1" }), { description = "[工作区 hidden]" })
hl.bind("SUPER + Page_Up", hl.dsp.focus({ workspace = "-1" }), { description = "[工作区 hidden]" })
hl.bind("CTRL + SUPER + Page_Down", hl.dsp.focus({ workspace = "r+1" }), { description = "[工作区 hidden]" })
hl.bind("CTRL + SUPER + Page_Up", hl.dsp.focus({ workspace = "r-1" }), { description = "[工作区 hidden]" })

dk.bind("SUPER + Scroll ↑/↓", "[工作区 4] 聚焦左/右")
hl.bind("SUPER + mouse_up", hl.dsp.focus({ workspace = "+1" }), { description = "[工作区 hidden]" })
hl.bind("SUPER + mouse_down", hl.dsp.focus({ workspace = "-1" }), { description = "[工作区 hidden]" })
hl.bind("CTRL + SUPER + mouse_up", hl.dsp.focus({ workspace = "r+1" }), { description = "[工作区 hidden]" })
hl.bind("CTRL + SUPER + mouse_down", hl.dsp.focus({ workspace = "r-1" }), { description = "[工作区 hidden]" })

-- 特殊
hl.bind("SUPER + S", hl.dsp.workspace.toggle_special(), { description = "[工作区 5] 切换便笺工作区" })
hl.bind("SUPER + mouse:275", hl.dsp.workspace.toggle_special(), { description = "[工作区 hidden] 切换便笺工作区" })
hl.bind("CTRL + SUPER + BracketLeft", hl.dsp.focus({ workspace = "-1" }), { description = "[工作区 hidden]" })
hl.bind("CTRL + SUPER + BracketRight", hl.dsp.focus({ workspace = "+1" }), { description = "[工作区 hidden]" })
hl.bind("CTRL + SUPER + Up", hl.dsp.focus({ workspace = "r-5" }), { description = "[工作区 hidden]" })
hl.bind("CTRL + SUPER + Down", hl.dsp.focus({ workspace = "r+5" }), { description = "[工作区 hidden]" })

-- 5. 虚拟机
hl.bind("SUPER + ALT + F1", function()
    hl.dispatch(hl.dsp.exec_cmd("notify-send '进入虚拟机子映射' '按键绑定已禁用。按 Super+Alt+F2 退出' -a 'Hyprland'"))
    hl.dispatch(hl.dsp.submap("virtual-machine"))
end, { description = "[工作区 6] 禁用按键绑定" })

hl.define_submap("virtual-machine", function()
    hl.bind("SUPER + ALT + F2", function()
        hl.dispatch(hl.dsp.exec_cmd("notify-send '退出虚拟机子映射' '按键绑定已重新启用' -a 'Hyprland'"))
        hl.dispatch(hl.dsp.submap("reset"))
    end, { description = "[工作区 hidden] 启用按键绑定" })
end)

-- 6. 会话
hl.bind("SUPER + L", hl.dsp.exec_cmd(ipc .. " lockScreen lock"),
    { description = "[会话 1] 锁定" })
hl.bind("SUPER + SHIFT + L",
    hl.dsp.exec_cmd(ipc .. " lockScreen lock; systemctl suspend || loginctl suspend"),
    { locked = true, description = "[会话 2] 睡眠" })
-- 笔记本电脑合盖时挂起，如果默认行为不是这样，请取消注释下一行
hl.bind("switch:on:Lid Switch",
    hl.dsp.exec_cmd(ipc .. " lockScreen lock; systemctl suspend || loginctl suspend"),
    { locked = true, description = "[会话 hidden] 笔记本电脑合盖挂起" })
hl.bind("CTRL + SHIFT + ALT + SUPER + Delete",
    hl.dsp.exec_cmd("systemctl poweroff || loginctl poweroff"),
    { description = "[会话 hidden] 关机" })

-- 7. 屏幕
-- 缩放
hl.bind("SUPER + Minus", hl.dsp.exec_cmd("~/.config/hypr/hyprland/scripts/zoom.sh decrease 0.3"),
    { repeating = true, description = "[屏幕 1] 缩小" })
hl.bind("SUPER + Equal", hl.dsp.exec_cmd("~/.config/hypr/hyprland/scripts/zoom.sh increase 0.3"),
    { repeating = true, description = "[屏幕 2] 放大" })
-- 小键盘缩放
hl.bind("SUPER + code:82", hl.dsp.exec_cmd("~/.config/hypr/hyprland/scripts/zoom.sh decrease 0.1"),
    { repeating = true, description = "[屏幕 hidden] 缩小" })
hl.bind("SUPER + code:86", hl.dsp.exec_cmd("~/.config/hypr/hyprland/scripts/zoom.sh increase 0.1"),
    { repeating = true, description = "[屏幕 hidden] 放大" })

-- 8. 媒体
hl.bind("SUPER + SHIFT + N",
    hl.dsp.exec_cmd(
        "playerctl next || playerctl position `bc <<< \"100 * $(playerctl metadata mpris:length) / 1000000 / 100\"`"),
    { locked = true, description = "[媒体 1] 下一曲" })
hl.bind("XF86AudioNext",
    hl.dsp.exec_cmd(
        "playerctl next || playerctl position `bc <<< \"100 * $(playerctl metadata mpris:length) / 1000000 / 100\"`"),
    { locked = true, description = "[媒体 hidden] 下一曲" })
hl.bind("XF86AudioPrev", hl.dsp.exec_cmd("playerctl previous"),
    { locked = true, description = "[媒体 hidden] 上一曲" })
hl.bind("SUPER + SHIFT + ALT + mouse:275", hl.dsp.exec_cmd("playerctl previous"),
    { description = "[媒体 hidden] 上一曲" })
hl.bind("SUPER + SHIFT + ALT + mouse:276",
    hl.dsp.exec_cmd(
        "playerctl next || playerctl position `bc <<< \"100 * $(playerctl metadata mpris:length) / 1000000 / 100\"`"),
    { description = "[媒体 hidden] 下一曲" })
hl.bind("SUPER + SHIFT + B", hl.dsp.exec_cmd("playerctl previous"),
    { locked = true, description = "[媒体 2] 上一曲" })
hl.bind("SUPER + SHIFT + P", hl.dsp.exec_cmd("playerctl play-pause"),
    { locked = true, description = "[媒体 3] 播放/暂停媒体" })
hl.bind("XF86AudioPlay", hl.dsp.exec_cmd("playerctl play-pause"),
    { locked = true, description = "[媒体 hidden] 播放/暂停媒体" })
hl.bind("XF86AudioPause", hl.dsp.exec_cmd("playerctl play-pause"),
    { locked = true, description = "[媒体 hidden] 播放/暂停媒体" })

local function launch_first_available(...)
    for _, cmd in ipairs({ ... }) do
        if cmd == "" then goto continue end
        local bin = cmd:match("^(%S+)")
        local handle = io.popen("bash -c \"command -v " .. bin .. "\" 2>&1")
        if not handle then goto continue end
        local output = handle:read("*a")
        handle:close()
        if output and output ~= "" then
            hl.dispatch(hl.dsp.exec_cmd(cmd))
            return
        end
        ::continue::
    end
end

-- 9. 应用
hl.bind("SUPER + Return",
    function()
        launch_first_available("kitty -1", "foot", "alacritty", "wezterm", "konsole", "kgx",
            "uxterm", "xterm")
    end,
    { description = "[应用 1] 终端" })

hl.bind("SUPER + T",
    function()
        launch_first_available(os.getenv("TERMINAL") or "", "kitty -1", "foot", "alacritty", "wezterm",
            "konsole", "kgx", "uxterm", "xterm")
    end,
    { description = "[应用 hidden] 终端" })

hl.bind("CTRL + ALT + T",
    function()
        launch_first_available(os.getenv("TERMINAL") or "", "kitty -1", "foot", "alacritty", "wezterm",
            "konsole", "kgx", "uxterm", "xterm")
    end,
    { description = "[应用 hidden] 终端 (Ubuntu)" })

hl.bind("SUPER + E",
    function()
        launch_first_available("dolphin", "nautilus", "nemo", "thunar",
            os.getenv("TERMINAL") or "", "kitty -1 fish -c yazi")
    end,
    { description = "[应用 2] 文件管理器" })

hl.bind("SUPER + W",
    function()
        launch_first_available("google-chrome-stable", "zen-browser", "firefox", "brave", "chromium",
            "microsoft-edge-stable", "opera", "librewolf")
    end,
    { description = "[应用 3] 浏览器" })

hl.bind("SUPER + C",
    function()
        launch_first_available("code", "codium", "cursor", "zed", "zedit", "zeditor", "kate",
            "gnome-text-editor", "emacs", "kitty -1 nvim", "kitty -1 micro")
    end,
    { description = "[应用 4] 代码编辑器" })

hl.bind("CTRL + SUPER + SHIFT + ALT + W",
    function()
        launch_first_available("wps", "onlyoffice-desktopeditors", "libreoffice")
    end,
    { description = "[应用 5] 办公软件" })

hl.bind("SUPER + X",
    function()
        launch_first_available("kwrite", "kate", "gnome-text-editor", "emacs")
    end,
    { description = "[应用 6] 文本编辑器" })

hl.bind("CTRL + SUPER + V",
    function()
        launch_first_available("pavucontrol-qt", "pavucontrol")
    end,
    { description = "[应用 7] 音量合成器" })

hl.bind("SUPER + I",
    function()
        -- 注意：这里保留了 XDG_CURRENT_DESKTOP 环境变量设置
        -- 如果 launch_first_available 不支持环境变量，可能需要调整
        launch_first_available("systemsettings", "gnome-control-center", "better-control")
    end,
    { description = "[应用 8] 设置应用" })

hl.bind("CTRL + SHIFT + Escape",
    function()
        launch_first_available("gnome-system-monitor", "plasma-systemmonitor --page-name Processes",
            "kitty -1 fish -c btop")
    end,
    { description = "[应用 9] 任务管理器" })

-- 奇怪的东西
-- 让窗口不要那么大
hl.bind("CTRL + SUPER + Backslash", hl.dsp.window.resize({ x = 640, y = 480 }),
    { description = "[奇怪的东西 hidden] 让窗口不要那么大" })

dk.flush()
