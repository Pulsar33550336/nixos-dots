{ ... }: {
  # nixpkgs.overlays = [
  #   (final: prev: {
  #     mihomo =
  #       (import (fetchTarball {
  #         url = "https://github.com/NixOS/nixpkgs/archive/b6bbdd5802b287452684470599966c968dde6a24.tar.gz";
  #         sha256 = "18sdwhz7584v4nkcfba9vzampqsncmwh955zaq5g532d1i1yczvv";
  #       }) { system = prev.stdenv.hostPlatform.system; }).mihomo;
  #   })
  # ];
}
