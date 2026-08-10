{ pkgs, ... }: {
  home.packages = with pkgs; [
    jq
    pywalfox-native
  ];
}
