{ ... }:
{
  nix = {
    settings = {
      substituters = [
        "https://mirrors.ustc.edu.cn/nix-channels/store"
        "https://mirrors.tuna.tsinghua.edu.cn/nix-channels/store"
        "https://cache.nixos.org"
      ];
      # dsh 官方二进制缓存（见 github:moraxyc/deepseek-harness.nix 的 nixConfig）
      extra-substituters = [
        "https://deepseek-harness-nix.cachix.org"
      ];
      extra-trusted-public-keys = [
        "deepseek-harness-nix.cachix.org-1:5NrkwLN9veNMhiINtU5ZeV4isXFhFsOwn6Ms7J1M+TA="
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
