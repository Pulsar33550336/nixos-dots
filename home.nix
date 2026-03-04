{
  config,
  pkgs,
  inputs,
  ...
}:

{
  home-manager.extraSpecialArgs = { inherit inputs; };
  home-manager.users.Pulsar =
    { pkgs, ... }:
    {
      nixpkgs.config.allowUnfree = true;

      imports = [
        # inputs.illogical-flake.homeManagerModules.default
        ./vscode.nix
      ];

      home.packages = with pkgs; [
        splayer
        fluent-icon-theme
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
