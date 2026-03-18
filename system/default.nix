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

  services.flatpak.enable = true;
}
