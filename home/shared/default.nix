{ lib, ... }: {
  imports = [
    ./shell
    ./desktop
  ]
  ++ (import ../../lib/scan-modules.nix { inherit lib; }).scanModules ./apps;
  home.stateVersion = "25.11";
}
