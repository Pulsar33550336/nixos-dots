-- ~/.config/hypr/hyprland.lua

-- 定义变量
local qsConfig = "noctalia-shell"
local ipc = "noctalia-shell ipc call"


-- debug 配置（如需启用请取消注释）
-- hl.config({
--     debug = {
--         disable_logs = false,
--         enable_stdout_logs = true,
--     },
-- })

-- 加载其他模块
require("hyprland/env")
require("hyprland/execs")
require("hyprland/general")
require("hyprland/rules")
require("hyprland/keybinds")

-- 加载颜色配置（如果已迁移为 Lua）
-- require("~/cache/hypr/hyprland-colors")
local path = os.getenv("HOME") .. "/.cache/hypr/hyprland-colors.lua"
local colors = io.open(path, "r") and dofile(path) or nil

-- 加载显示器配置
require("monitors")
