{ pkgs, ... }:
{
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
}
