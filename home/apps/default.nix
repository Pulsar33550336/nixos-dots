{
  pkgs,
  ...
}:
{
  imports = [
    ./git.nix
    ./gpg.nix
    ./vscode.nix
    ./ghostty.nix
    ./libreoffice.nix
    ./pywalfox.nix
    ./nh.nix
  ];

  home.packages = with pkgs; [
    splayer
    fluent-icon-theme
    nixfmt
    obsidian
    neovim
    wl-clipboard
    grim
    slurp
    swappy
    fuzzel
    playerctl
    wlsunset
    wf-recorder
    imagemagick
    libnotify
    xrdb
    jq
    tesseract
    opencode
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
