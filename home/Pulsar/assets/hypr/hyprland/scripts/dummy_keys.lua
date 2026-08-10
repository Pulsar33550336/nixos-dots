-- hypr-dummy.lua
---@class hypr_dummy
local M = {}

---@type table<string, number> 修饰键名称到掩码的映射
local mod_map = {
    SHIFT   = 1,
    CAPS    = 2,
    CTRL    = 4,
    ALT     = 8,
    MOD2    = 16,
    MOD3    = 32,
    SUPER   = 64,
    MOD5    = 128,
    CONTROL = 4,
    MOD1    = 8,
    WIN     = 64,
    LOGO    = 64,
    MOD4    = 64,
}

---@class dummy_entry
---@field key string 纯净键名（无修饰键）
---@field modmask integer 修饰键掩码
---@field des string 描述文本

---@type dummy_entry[] 存储所有假绑定条目
local _dummy_entries = {}

---解析修饰键，提取掩码和纯净键名
---@param key_str string 原始键字符串，如 "SUPER + Return"
---@return integer modmask 修饰键掩码
---@return string pure_key 纯净键名
local function parse_modifiers(key_str)
    local modmask = 0
    local pure_key = key_str

    for mod, mask in pairs(mod_map) do
        if key_str:find(mod) then
            modmask = modmask + mask
            pure_key = pure_key:gsub(mod .. "%s*%+%s*", "")
        end
    end

    pure_key = pure_key:gsub("^%s*(.-)%s*$", "%1")
    return modmask, pure_key
end

---转义 JSON 字符串中的特殊字符
---@param str string
---@return string
local function escape_json(str)
    return (str:gsub('[\\"]', { ['\\'] = '\\\\', ['"'] = '\\"' }))
end

---添加一个假绑定（仅用于速查表显示）
---@param key_str string 键名，可包含修饰键，如 "SUPER + Return"
---@param desc string 描述文本
function M.bind(key_str, desc)
    local modmask, pure_key = parse_modifiers(key_str)

    table.insert(_dummy_entries, {
        key = pure_key,
        modmask = modmask,
        des = desc,
    })
end

---将所有假绑定写入缓存文件
---@return boolean 是否写入成功
function M.flush()
    local parts = {}
    for i, e in ipairs(_dummy_entries) do
        local key = escape_json(e.key)
        local des = escape_json(e.des)

        local obj
        if e.modmask and e.modmask ~= 0 then
            obj = string.format('{"key":"%s","modmask":%d,"des":"%s"}', key, e.modmask, des)
        else
            obj = string.format('{"key":"%s","des":"%s"}', key, des)
        end
        parts[i] = obj
    end

    local json = "[" .. table.concat(parts, ",") .. "]\n"

    local cache_path = os.getenv("HOME") .. "/.cache/hypr_dummy.json"
    local f = io.open(cache_path, "w")
    if f then
        f:write(json)
        f:close()
        return true
    end
    return false
end

return M
