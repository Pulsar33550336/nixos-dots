{
  pkgs,
  lib,
  ...
}:
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
  systemd.services = {
    drkonqi = lib.mkForce { enable = false; };
    "drkonqi-coredump-processor@".wantedBy = lib.mkForce [ ];
  };
  services.displayManager = {
    sddm.enable = true;
    autoLogin = {
      enable = true;
      user = "Pulsar";
    };
    defaultSession = "hyprland";
  };

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

  programs.thunderbird = {
    enable = true;
    package = pkgs.thunderbird-bin;
  };

  services.printing.enable = true;

  services.avahi = {
    enable = true;
    nssmdns4 = true;
    openFirewall = true;
  };

  services.flatpak.enable = true;
}
