{
  config,
  lib,
  pkgs,
  ...
}:

{
  home.packages = with pkgs; [
    splayer
    fluent-icon-theme
    nixfmt
    obsidian
  ];

  xdg.dataFile."applications/qq.desktop".text = ''
    [Desktop Entry]
    Name=QQ
    Exec=qq --ozone-platform=wayland --enable-wayland-ime --wayland-text-input-version=3 %U
    Terminal=false
    Type=Application
    Icon=${pkgs.qq}/share/icons/hicolor/512x512/apps/qq.png
    StartupWMClass=QQ
    Categories=Network;
    Comment=QQ
  '';
}
