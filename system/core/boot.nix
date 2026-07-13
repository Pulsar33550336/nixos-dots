{
  lib,
  inputs,
  ...
}:
{
  imports = [
    inputs.lanzaboote.nixosModules.lanzaboote
  ];
  boot = {
    loader = {
      systemd-boot.enable = lib.mkForce false;
      timeout = 0;
      efi = {
        canTouchEfiVariables = true;
        efiSysMountPoint = "/boot";
      };
    };

    initrd = {
      systemd.enable = true;
      # TODO: Host-specific
      availableKernelModules = [ "i915" ];
      verbose = false;
    };

    plymouth.enable = true;

    lanzaboote = {
      enable = true;
      pkiBundle = "/var/lib/sbctl";
    };
  };

}
