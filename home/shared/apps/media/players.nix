{ pkgs, ... }: {
  home.packages = with pkgs; [
    playerctl
    splayer-next
  ];
}
