{ ... }:
{
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
}
