{ pkgs, inputs, ... }:
{
  nixpkgs.overlays = [
    inputs.niri-flake.overlays.niri
    (final: prev: {
      niri = prev.niri-unstable;
    })
  ];

  environment.systemPackages = with pkgs; [
    niri
  ];

  services = {
    displayManager.sessionPackages = [ pkgs.niri ];

    # NO Default Gnome Keyring
  };

  systemd.packages = [ pkgs.niri ];

  # Restarting the compositor kills the graphical session; same
  # treatment as the display-manager modules.
  systemd.user.services.niri = {
    restartIfChanged = false;
    # Defining the unit here generates a drop-in; without this it
    # would carry the NixOS default Environment="PATH=coreutils:…",
    # clobbering the PATH that niri-session imported into the user
    # manager and breaking spawn actions that rely on it.
    enableDefaultPath = false;
  };

  xdg.portal = {
    enable = true;

    # KDE 门户在其他地方安装

    # NOTE: `configPackages` is ignored when `xdg.portal.config.niri` is defined.
    config.niri = {
      default = [
        "kde"
      ];
      "org.freedesktop.impl.portal.Access" = "kde";
      "org.freedesktop.impl.portal.FileChooser" = "kde";
      "org.freedesktop.impl.portal.Notification" = "kde";
      "org.freedesktop.impl.portal.Secret" = "kwallet";
    };
  };
}
