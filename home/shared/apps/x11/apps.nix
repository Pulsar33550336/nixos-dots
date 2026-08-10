{ pkgs, ... }: {
  home.packages = with pkgs; [ xrdb ];
}
