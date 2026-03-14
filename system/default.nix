{ ... }:

{
  imports = [
    ./core
    ./network
    ./hardware
    ./desktop
    ./i18n
    ./users
    ./packages
  ];

  services.openssh.enable = true;
  services.flatpak.enable = true;
}
