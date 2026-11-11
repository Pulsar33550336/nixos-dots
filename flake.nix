{
  description = "NixOS flake-configuration with Noctalia";
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    quickshell = {
      url = "github:outfoxxed/quickshell";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    pulsar-plugins = {
      url = "github:Pulsar33550336/pulsar-ns-plugins";
      flake = false;
    };
    noctalia = {
      url = "github:noctalia-dev/noctalia/cachix";
      # 故意不 follows nixpkgs：一旦跟随，derivation 哈希就变了，官方缓存全部 miss。
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
      url = "github:epireyn/niri-flake";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nix-cachyos-kernel.url = "github:xddxdd/nix-cachyos-kernel/release";
    pinentry-kwallet = {
      url = "github:Pulsar33550336/pinentry-kwallet";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    dsh = {
      url = "github:moraxyc/deepseek-harness.nix";
    };
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
