{ lib, ... }:
{
  services.desktopManager.plasma6.enable = true;
  systemd.services = {
    drkonqi = lib.mkForce { enable = false; };
    "drkonqi-coredump-processor@".wantedBy = lib.mkForce [ ];
  };

  services.displayManager = {
    sddm.enable = true;
  };
}
