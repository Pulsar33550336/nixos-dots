{ ... }:

{
  networking = {
    hostName = "NixOS-Pulsar";
    networkmanager.enable = true;
    firewall.enable = false;
  };
}
