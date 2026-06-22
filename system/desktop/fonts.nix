{ pkgs, ... }:
{
  fonts.packages = with pkgs; [
    rubik
    nerd-fonts.ubuntu
    nerd-fonts.jetbrains-mono
    maple-mono.NormalNL-NF-CN
    # (fira-code.override { useVariableFont = false; })
    # julia-mono
  ];
}
