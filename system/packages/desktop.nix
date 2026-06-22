{ pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    qq
    vlc
    pipewire
    xwayland-satellite
    kdePackages.kirigami
    kdePackages.kirigami-addons
    kdePackages.qt6ct
    kdePackages.kpipewire
  ];
}
