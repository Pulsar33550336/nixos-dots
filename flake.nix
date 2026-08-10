{
  description = "NixOS flake-configuration with Noctalia";
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    quickshell = {
      url = "github:outfoxxed/quickshell";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    noctalia = {
      url = "github:noctalia-dev/noctalia-shell/legacy-v4";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    lanzaboote = {
      url = "github:nix-community/lanzaboote/0403b4b7e8b2612657f0053a4c315e6c43eee9e6";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    niri-flake = {
      url = "github:sodiboo/niri-flake";
      inputs.nixpkgs.follows = "nixpkgs";
      inputs.niri-unstable.url = "github:Pulsar33550336/niri";
    };
    nix-cachyos-kernel.url = "github:xddxdd/nix-cachyos-kernel/release";
  };

  outputs =
    inputs@{
      nixpkgs,
      ...
    }:
    let
      system = "x86_64-linux";
    in
    {
      nixosConfigurations.NixOS-Pulsar = nixpkgs.lib.nixosSystem {
        inherit system;
        specialArgs = { inherit inputs; };
        modules = [
          # 把配置在 /etc 下存一份
          {
            environment.etc."current-config".source = ./.;
          }
          ./overlays
          ./system
          ./home
        ];

      };
    };
}
