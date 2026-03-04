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
    niri.url = "github:sodiboo/niri-flake";
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
        modules = [
          ./configuration.nix
          ./noctalia.nix
          ./chinese.nix
          ./niri.nix
          ./zsh.nix
          ./home.nix
          ./hypr.nix
          # ./vscode.nix
          inputs.home-manager.nixosModules.home-manager
          {
            home-manager = {
              users.Pulsar =
                { pkgs, ... }:
                {
                  home.stateVersion = "25.11";
                  home.packages = [ ];
                };
            };
          }
          {
            # 强制所有求值过程都允许 unfree
            nixpkgs.config.allowUnfree = true;
            nixpkgs.config.allowUnfreePredicate = (pkg: true);
          }
        ];
      };

    };
}
