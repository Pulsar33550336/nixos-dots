{ ... }:

{
  imports = [
    ./shell.nix
    ./cpp.nix
    ./rust.nix
    ./python.nix
    ./desktop.nix
    ./clash-verge.nix
    ./distrobox.nix
    ./tailscale.nix
    ./sbctl.nix
    ./firefox.nix
    ./thunderbird.nix
  ];

  nixpkgs.config.allowUnfree = true;
}
