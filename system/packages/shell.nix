{ pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    vim
    wget
    git
    perl
    killall
    file
    fastfetch
    bison
    gnum4
    gnumake
    tree
  ];
}
