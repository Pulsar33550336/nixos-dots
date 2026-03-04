{
  description = "NixOS flake-configuration with Noctalia";
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    quickshell = {
      url = "github:outfoxxed/quickshell";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    noctalia = {
      url = "github:noctalia-dev/noctalia-shell";
      inputs.nixpkgs.follows = "nixpkgs";
      # inputs.quickshell.follows = "quickshell";
    };
    # niri.url = "github:sodiboo/niri-flake";
    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
    nix-vscode-extensions = {
      url = "github:nix-community/nix-vscode-extensions";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    # dotfiles = {
    #   url = "path:./dots-hyprland";
    #   flake = false;
    # };
    # illogical-flake = {
    #   url = "path:./illogical-flake";
    #   inputs.nixpkgs.follows = "nixpkgs";
    #   inputs.dotfiles.follows = "dotfiles";
    # };
  };

  outputs =
    inputs@{
      self,
      nixpkgs,
      home-manager,
      # illogical-flake,
      ...
    }:
    {
      nixosConfigurations.NixOS-Pulsar = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        specialArgs = { inherit inputs; };
        pkgs = import nixpkgs {
          system = "x86_64-linux";
          config.allowUnfree = true;
        };
        modules = [
          ./configuration.nix
          ./noctalia.nix
          ./chinese.nix
          # ./niri.nix
          ./zsh.nix
          ./home.nix
          ./hypr.nix
          inputs.home-manager.nixosModules.home-manager
          {
            home-manager = {
              # 关键修复点：
              useGlobalPkgs = true; # 使用全局 pkgs 实例（已带 allowUnfree）
              useUserPackages = true; # 使用全局包管理
              extraSpecialArgs = { inherit inputs; }; # 确保 inputs 传给子模块

              users.Pulsar =
                {
                  pkgs,
                  lib,
                  config,
                  ...
                }:
                {
                  home.stateVersion = "25.11";
                  imports = [
                    ./vscode.nix
                    (import (builtins.fetchurl {
                      url = "https://gist.githubusercontent.com/piousdeer/b29c272eaeba398b864da6abf6cb5daa/raw/41e569ba110eb6ebbb463a6b1f5d9fe4f9e82375/mutability.nix";
                      sha256 = "4b5ca670c1ac865927e98ac5bf5c131eca46cc20abf0bd0612db955bfc979de8";
                    }) { inherit config lib; })
                    (import (builtins.fetchurl {
                      url = "https://gist.githubusercontent.com/piousdeer/b29c272eaeba398b864da6abf6cb5daa/raw/41e569ba110eb6ebbb463a6b1f5d9fe4f9e82375/vscode.nix";
                      sha256 = "fed877fa1eefd94bc4806641cea87138df78a47af89c7818ac5e76ebacbd025f";
                    }) { inherit config lib pkgs; })
                  ]; # 建议在这里 import，而不是在 modules 列表
                };
            };
          }
          #{
          #  nixpkgs.config.allowUnfree = true;
          #  nixpkgs.config.allowUnfreePredicate = (pkg: true);
          #}
        ];
      };

    };
}
