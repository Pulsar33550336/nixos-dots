hl.on("hyprland.start", function()
    -- Bar, wallpaper
    hl.exec_cmd("sleep 1 && dbus-update-activation-environment --systemd WAYLAND_DISPLAY XDG_CURRENT_DESKTOP") -- Some fix idk

    hl.exec_cmd("noctalia-shell")

    -- Core components
    hl.exec_cmd("gnome-keyring-daemon --start --components=secrets")
    hl.exec_cmd("dbus-update-activation-environment --all")
    hl.exec_cmd("/run/current-system/sw/libexec/pam_kwallet_init")
    hl.exec_cmd("kwalletd6")

    -- Cursor
    hl.exec_cmd("hyprctl setcursor MacOS-hyprcursor 24")

    -- Auto Lock
    hl.exec_cmd("timeout 10 bash -c 'while ! noctalia-shell ipc call lockScreen lock; do sleep 0.1; done'")

    hl.exec_cmd("fcitx5 --replace -d")
    hl.exec_cmd("clash-verge")

    hl.exec_cmd(
        "systemd-inhibit --who='Hyprland config' --why='Handle power key in Hyprland' --what=handle-power-key --mode=block sleep infinity & echo $! > /tmp/.hyprland-systemd-inhibit")
end)

-- Hyprland 退出时清理 systemd-inhibit
hl.on("hyprland.shutdown", function()
    hl.exec_cmd("kill -9 \"$(cat /tmp/.hyprland-systemd-inhibit)\"")
end)

local ipc = "noctalia-shell ipc call"

-- 电源键绑定（确保 $ipc 已定义，例如 local ipc = \"noctalia-shell ipc call\"）
hl.bind("XF86PowerOff", hl.dsp.exec_cmd(ipc .. " sessionMenu toggle"),
{ locked = true, description = "[会话 hidden] 切换会话菜单" })

hl.exec_cmd("pkill kded6")