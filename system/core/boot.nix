{
  pkgs,
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

    kernelParams = [
      "quiet"
      "splash"
    ];
    # 导致无法休眠，屏蔽
    blacklistedKernelModules = [ "bitland_mifs_wmi" ];
    consoleLogLevel = 0;
    kernelPackages = pkgs.linuxPackages_latest;

    lanzaboote = {
      enable = true;
      pkiBundle = "/var/lib/sbctl";
    };
  };

}
