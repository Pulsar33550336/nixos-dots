{
  config,
  pkgs,
  inputs,
  ...
}:

{
  imports = [
    ./shell/zsh.nix
    ./shell/nh.nix
    ./desktop/hyprland.nix
    ./desktop/noctalia.nix
    ./apps/git.nix
    ./apps/vscode.nix
    ./apps/kitty.nix
    ./apps
  ];
}
