{ config, pkgs, ... }:

{
  networking.hostName = "NixOS-Pulsar";
  networking.networkmanager.enable = true;
  networking.firewall.enable = false;

  hardware.bluetooth.enable = true;
}
