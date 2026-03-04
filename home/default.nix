{ config, pkgs, inputs, ... }:

{
  imports = [
    ./programs
    ./dots
  ];

  home.stateVersion = "25.11";
  nixpkgs.config.allowUnfree = true;
}
