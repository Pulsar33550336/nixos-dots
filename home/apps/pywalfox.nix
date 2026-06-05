{ pkgs, ... }:

{
  home.packages = with pkgs; [
    pywalfox-native
  ];
}
