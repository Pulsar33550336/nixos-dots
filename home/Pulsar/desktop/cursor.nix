# 这可不是 code-cursor ^_^
{ pkgs, ... }:
{
  home.packages = with pkgs; [
    apple-cursor
  ];
  home.file.".local/share/icons/macOS".source = "${pkgs.apple-cursor}/share/icons/macOS";
  # BenBen 指针主题本身收编进 Nix；GTK/KDE 里指向它的配置保持原样，不在本文件处理
  home.file.".local/share/icons/BenBen".source = "${pkgs.benben-cursor}/share/icons/BenBen";
}
