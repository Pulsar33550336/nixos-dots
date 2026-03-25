{ ... }:
let
  clash-verge-rev-fixed =
    (import (fetchTarball {
      url = "https://github.com/NixOS/nixpkgs/archive/6da45c9.tar.gz";
      sha256 = "0lyzaz18nammhwxg462qdkchg02m7qxncnpxyv7c37yv70hqvsm7";
    }) { system = "x86_64-linux"; }).clash-verge-rev;
in
{
  programs.clash-verge.package = clash-verge-rev-fixed;
  programs.clash-verge.enable = true;
  programs.clash-verge.tunMode = true;
  programs.clash-verge.serviceMode = true;
}
