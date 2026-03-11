{ pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    timeshift
  ];

  systemd.services.timeshift-check = {
    description = "Timeshift Snapshot Check";

    startAt = "hourly";

    script = ''
      # 设置 PATH，确保命令可以找到
      export PATH=/run/current-system/sw/bin:$PATH

      # 执行 timeshift 检查
      timeshift --check --scripted
    '';

    serviceConfig = {
      Type = "oneshot";
      User = "root";
      # 可选：限制资源使用
      # MemoryMax = "256M";
      # CPUQuota = "50%";
    };
  };
}
