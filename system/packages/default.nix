{ ... }:

{
  imports = [
    ./shell.nix
    ./cpp.nix
    ./rust.nix
    ./python.nix
    ./desktop.nix
    ./network.nix
  ];

  nixpkgs.config.allowUnfree = true;
}
