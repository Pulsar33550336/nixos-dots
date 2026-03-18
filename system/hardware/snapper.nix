{ pkgs, ... }:

{
  services.snapper = {
    snapshotInterval = "hourly";
    cleanupInterval = "1d";

    configs = {
      home = {
        SUBVOLUME = "/home";
        FSTYPE = "btrfs";
        ALLOW_USERS = [ "Pulsar" ];

        TIMELINE_CREATE = true;
        TIMELINE_CLEANUP = true;

        TIMELINE_LIMIT_DAILY = "3";
        TIMELINE_LIMIT_WEEKLY = "1";
        TIMELINE_LIMIT_MONTHLY = "1";
        TIMELINE_LIMIT_HOURLY = "0";
        TIMELINE_LIMIT_QUARTERLY = "0";
        TIMELINE_LIMIT_YEARLY = "0";

        SPACE_LIMIT = "0.5"; # 快照占用空间限制（50%）
        FREE_LIMIT = "0.2"; # 保留 20% 空闲空间
        NUMBER_LIMIT = "5"; # 额外保留 5 个手动快照
        NUMBER_CLEANUP = true; # 清理数量限制的快照
      };
    };

    # 是否在启动时快照根目录（可选）
    snapshotRootOnBoot = false;

    # 让定时器在错过执行时间后立即执行
    persistentTimer = true;
  };

  # 安装 GUI
  environment.systemPackages = with pkgs; [
    snapper-gui
  ];
}
