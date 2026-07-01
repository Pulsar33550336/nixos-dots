# 这可不是 code-cursor ^_^
{ pkgs, ... }:
{
  home.packages = with pkgs; [
    apple-cursor
  ];
  home.file.".local/share/icons/macOS".source = "${pkgs.apple-cursor}/share/icons/macOS";
}
