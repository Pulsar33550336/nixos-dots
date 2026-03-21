{
  pkgs,
  ...
}:

{
  boot = {
    loader = {
      grub = {
        enable = true;
        efiSupport = true;
        device = "nodev";
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

  distro-grub-themes = {
    enable = true;
    theme = "nixos";
  };

  time.timeZone = "Asia/Shanghai";

  nix.settings = {
    substituters = [
      "https://mirrors.ustc.edu.cn/nix-channels/store"
      "https://mirrors.tuna.tsinghua.edu.cn/nix-channels/store"
      "https://cache.nixos.org"
    ];
    experimental-features = [
      "nix-command"
      "flakes"
    ];
  };

  security.sudo = {
    enable = true;
    extraConfig = ''
      Defaults pwfeedback
    '';
  };

  system.stateVersion = "25.11";
}
