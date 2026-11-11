{
  lib,
  ...
}:
{
  # hyprlock 仍然用在 niri 里（Ctrl+Mod+Alt+R），但 Hyprland 本身已经移除，
  # 所以只把 hyprlock 需要的那两个路径交给 HM 管。
  xdg.configFile."hypr/hyprlock.conf".source = ../assets/hyprlock/hyprlock.conf;
  xdg.configFile."hypr/hyprlock".source = ../assets/hyprlock/hyprlock;

  # hyprlock 会调用 hyprlock/ 下的脚本（状态、CapsLock 提示），需要可执行位；
  # HM 链接到 store 后权限是只读的，这里补一次。
  home.activation.makeHyprScriptsExecutable = lib.hm.dag.entryAfter [ "writeBoundary" ] ''
    if [ -d "$HOME/.config/hypr" ]; then
      find "$HOME/.config/hypr" -name "*.sh" -exec chmod +x {} \; 2>/dev/null || true
    fi
  '';
}
