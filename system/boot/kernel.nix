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
    # 2026-10-24 缓存被入侵后重建，换了新地址和新签名公钥
    # https://github.com/xddxdd/nix-cachyos-kernel/issues/110
    substituters = lib.mkBefore [ "https://cache.lantian.pub/lantian" ];
    trusted-public-keys = lib.mkBefore [
      "lantian:WVGO7vsRMSEN+h7Lp7kv6SAmrkEXgUGbbXm7jMDjBuQ="
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
    ];
    extraModulePackages = [ pkgs.cachyosKernels.linuxPackages-cachyos-bore-lto-x86_64-v3.acpi_call ];
    consoleLogLevel = 0;
  };
}
