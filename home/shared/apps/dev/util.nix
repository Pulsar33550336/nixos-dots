{ pkgs, inputs, ... }:

let
  inherit (pkgs.stdenv.hostPlatform) system;
in
{
  home.packages = with pkgs; [
    just-lsp
    opencode
    lua-language-server
  ] ++ [
    inputs.dsh.packages.${system}.dsh
  ];
}
