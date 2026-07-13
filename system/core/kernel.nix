{
  pkgs,
  inputs,
  lib,
  ...
}:
{
  nixpkgs.overlays = [
    inputs.nix-cachyos-kernel.overlays.pinned
  ];

  nix.settings = {
    substituters = lib.mkBefore [ "https://attic.xuyh0120.win/lantian" ];
    trusted-public-keys = lib.mkBefore [
      "lantian:EeAUQ+W+6r7EtwnmYjeVwx5kOGEBpjlBfPlzGlTNvHc="
    ];
  };

  boot = {
    kernelPackages = pkgs.cachyosKernels.linuxPackages-cachyos-bore-lto-x86_64-v3;
    # kernelPackages = pkgs.linuxPackages_latest;
    # 导致无法休眠，屏蔽
    blacklistedKernelModules = [ "bitland_mifs_wmi" ];
    kernelParams = [
      "quiet"
      "splash"
      "i915.fastboot=1"
    ];
    consoleLogLevel = 0;
  };
}
