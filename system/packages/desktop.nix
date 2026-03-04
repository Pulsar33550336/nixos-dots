{ pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    kitty
    qq
    vlc
    pipewire
    xwayland-satellite
    kdePackages.kirigami
    kdePackages.kirigami-addons
    kdePackages.qt6ct
    kdePackages.kpipewire
    libsForQt5.kirigami2
    libsForQt5.kirigami-addons
  ];
}
