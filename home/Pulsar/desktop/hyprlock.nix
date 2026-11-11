{
  lib,
  ...
}:
{
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
