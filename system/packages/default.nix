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
  ];

  nixpkgs.config.allowUnfree = true;
}
