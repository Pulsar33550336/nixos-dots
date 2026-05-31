{
  pkgs,
  lib,
  ...
}:

{
  boot = {
    loader = {
      systemd-boot = {
        enable = lib.mkForce false;
        # efiShell = true;
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

  boot.lanzaboote = {
    enable = true;
    pkiBundle = "/var/lib/sbctl";
  };

  distro-grub-themes = {
    enable = true;
    theme = "nixos";
  };

  time.timeZone = "Asia/Shanghai";

  nix = {
    settings = {
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
    distributedBuilds = false;
    buildMachines = [
      {
        hostName = "server";
        sshUser = "Pulsar";
        system = "x86_64-linux"; # 根据远程机器架构调整
        maxJobs = 24; # 远程机器最大并发数
        supportedFeatures = [
          "nixos-test"
          "benchmark"
          "big-parallel"
          "kvm"
        ];
      }
    ];
  };

  programs.ssh.extraConfig = ''
    Host server
      HostName fd7a:115c:a1e0::2101:f7b1
      Port 2222
  '';

  security.sudo = {
    enable = true;
    extraConfig = ''
      Defaults pwfeedback
    '';
  };

  system.stateVersion = "25.11";
}
