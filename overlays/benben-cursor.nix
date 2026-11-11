{ ... }: {
  nixpkgs.overlays = [
    (final: prev: {
      benben-cursor = prev.callPackage ../pkgs/benben-cursor { };
    })
  ];
}
