{ config, pkgs, ... }:

{
  users.users.Pulsar = {
    isNormalUser = true;
    description = "Pulsar";
    extraGroups = [
      "networkmanager"
      "wheel"
    ];
    shell = pkgs.zsh;
  };

  environment.shells = with pkgs; [
    bash
    zsh
  ];
  users.defaultUserShell = pkgs.zsh;
  programs.zsh.enable = true;
}
