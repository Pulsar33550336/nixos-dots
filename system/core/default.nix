{
  pkgs,
  lib,
  ...
}:

{
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
      availableKernelModules = [ "i915" ];
      verbose = false;
    };

    plymouth.enable = true;

    kernelParams = [
      "quiet"
      "splash"
    ];
    consoleLogLevel = 0;
    kernelPackages = pkgs.linuxPackages_latest;

    lanzaboote = {
      enable = true;
      pkiBundle = "/var/lib/sbctl";
    };
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
