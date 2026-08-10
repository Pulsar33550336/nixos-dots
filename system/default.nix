{ lib, ... }: {
  imports = [
    ./boot
    ./core
    ./DE
    ./desktop
    ./hardware
    ./network
    ./users
  ] ++ (import ../lib/scan-modules.nix { inherit lib; }).scanModules ./packages;

  nixpkgs.config.allowUnfree = true;
  system.stateVersion = "25.11";
}
