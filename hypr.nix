# hypr.nix - Hyprland 窗口管理器配置
{
  config,
  pkgs,
  lib,
  ...
}:

let
  # 定义配置源目录路径
  configDir = ./hypr;
in
{
  # 启用 Hyprland
  programs.hyprland = {
    enable = true;
    xwayland.enable = true;
  };

  # Home Manager 配置
  home-manager.users.Pulsar =
    {
      config,
      pkgs,
      lib,
      ...
    }:
    {
      # 直接软链接整个 hypr 目录
      xdg.configFile."hypr".source = configDir;

      home.file.".local/share/icons/MacOS-hyprcursor".source = ./MacOS-hyprcursor;

      # 设置脚本可执行权限
      home.activation = {
        makeScriptsExecutable = lib.hm.dag.entryAfter [ "writeBoundary" ] ''
          if [ -d "$HOME/.config/hypr" ]; then
            find "$HOME/.config/hypr" -name "*.sh" -exec chmod +x {} \; 2>/dev/null || true
          fi
        '';
      };

      # 确保必要的包已安装
      home.packages = with pkgs; [
        hyprpaper
        hyprlock
        hypridle
        wl-clipboard
        grim
        slurp
        swappy
        fuzzel
        playerctl
        hyprpicker
      ];

      # Hyprland 配置
      # wayland.windowManager.hyprland.enable = true;
    };
}
