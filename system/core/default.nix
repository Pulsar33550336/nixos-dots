{ config, pkgs, ... }:

{
  boot = {
    loader = {
      grub = {
        enable = true;
        efiSupport = true;
        device = "nodev";
        splashImage = null;
        timeoutStyle = "hidden";
      };
      timeout = 0;
      efi = {
        canTouchEfiVariables = true;
        efiSysMountPoint = "/boot";
      };
    };

    initrd.systemd.enable = true;
    initrd.availableKernelModules = [ "i915" ];
    plymouth.enable = true;

    kernelParams = [
      "quiet"
      "splash"
    ];
    initrd.verbose = false;
    consoleLogLevel = 0;
    kernelPackages = pkgs.linuxPackages_latest;
  };

  time.timeZone = "Asia/Shanghai";

  nix.settings = {
    substituters = [
      "https://mirrors.tuna.tsinghua.edu.cn/nix-channels/store?priority=10"
      "https://mirrors.ustc.edu.cn/nix-channels/store?priority=5"
      "https://cache.nixos.org"
    ];
    experimental-features = [
      "nix-command"
      "flakes"
    ];
  };

  # services.cron.enable = true;

  security.sudo = {
    enable = true;
    extraConfig = ''
      Defaults pwfeedback
    '';
  };

  system.stateVersion = "25.11";
}
