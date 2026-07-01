{ pkgs, ... }:
let
  kdl-lsp = pkgs.callPackage ../pkgs/kdl-lsp.nix { };
in
{
  nixpkgs.overlays = [
    (final: prev: {
      inherit kdl-lsp;
    })
  ];
}
