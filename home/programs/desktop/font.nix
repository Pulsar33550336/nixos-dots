{ lib, ... }:
{
  # 不使用 Home Manager 管理
  fonts.fontconfig.enable = lib.mkForce false;
}
