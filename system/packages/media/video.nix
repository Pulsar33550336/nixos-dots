{ pkgs, ... }: {
  environment.systemPackages = with pkgs; [
    pipewire
    vlc
  ];
}
