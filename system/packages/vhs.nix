# VHS 是一个终端录屏脚本程序，尤其适用于想制作视频的人。
{ pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    vhs
  ];
}
