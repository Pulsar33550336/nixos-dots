{ config, pkgs, ... }:

{
  networking.hostName = "NixOS-Pulsar";
  networking.networkmanager.enable = true;
  networking.firewall.enable = false;

  hardware.bluetooth.enable = true;

  programs.clash-verge.enable = true;
  programs.clash-verge.tunMode = true;
  programs.clash-verge.serviceMode = true;
}
