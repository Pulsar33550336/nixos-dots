{
  config,
  pkgs,
  inputs,
  ...
}:

{
  #home-manager.extraSpecialArgs = { inherit inputs; };
  home-manager.users.Pulsar =
    { pkgs, ... }:
    {

      programs.git = {
        enable = true;

        # 用户信息
        userName = "Pulsar33550336";
        userEmail = "pulsar33550336@163.com";

        # 签名密钥
        signing = {
          key = "2B867C4832784EE0";
          signByDefault = true; # 对应 commit.gpgsign = true
        };

        # 额外配置（对应其他设置）
        extraConfig = {
          # safe.directory 配置（多个目录）
          # safe = {
          #   directory = [
          #     "/home/gary/Linux_Dynamic_Wallpapers"
          #     "/mnt/etc/nixos"
          #   ];
          # };

          # core 配置
          core = {
            autocrlf = "input";
          };

          # init 配置
          init = {
            defaultBranch = "master"; # 虽然现在主流是 main，但你的配置是 master
          };

          # tag 签名配置
          tag = {
            gpgSign = false;
          };
        };
      };

      # 如果你也需要 gpg 相关配置
      programs.gpg = {
        enable = true;
      };

      # programs.gpg.agent = {
      #   enable = true;
      #   # 如果你在 KDE Plasma 桌面，用 pinentry-qt 体验最好
      #   # 如果你在终端里操作（没有桌面），用 pinentry-curses 或 pinentry-tty
      #   pinentryPackage = pkgs.pinentry-qt;
      # };
      services.gpg-agent = {
        enable = true;
        pinentryPackage = pkgs.pinentry-gtk2;
        # 缓存时间设置（可选）
        # defaultCacheTtl = 3600;
        # maxCacheTtl = 86400;
        # 如果需要 SSH 支持
        # enableSshSupport = true;
      };

      nixpkgs.config.allowUnfree = true;

      #imports = [
      #  # inputs.illogical-flake.homeManagerModules.default
      #  ./vscode.nix
      #];

      home.packages = with pkgs; [
        splayer
        fluent-icon-theme
        nixfmt
        obsidian
      ];

      # 启用 illogical-impulse
      # programs.illogical-impulse.enable = true;

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
    };
}
