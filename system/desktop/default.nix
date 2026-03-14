{ pkgs, ... }:

{
  programs.hyprland.enable = true;

  services.geoclue2.enable = true;

  fonts.packages = with pkgs; [
    rubik
    nerd-fonts.ubuntu
    nerd-fonts.jetbrains-mono
    maple-mono.NormalNL-NF-CN
  ];

  services.desktopManager.plasma6.enable = true;
  services.displayManager.sddm.enable = true;
  services.displayManager.autoLogin = {
    enable = true;
    user = "Pulsar";
  };
  services.displayManager.defaultSession = "hyprland";

  services.xserver.xkb.layout = "us";

  xdg.portal = {
    enable = true;
    extraPortals = with pkgs; [
      kdePackages.xdg-desktop-portal-kde
      xdg-desktop-portal-gtk
    ];
    config = {
      common = {
        default = "kde";
      };
    };
  };

  services.dbus.packages = with pkgs; [
    kdePackages.xdg-desktop-portal-kde
  ];

  programs.firefox.enable = true;
}
