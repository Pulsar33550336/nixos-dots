{
  pkgs,
  ...
}:

{
  imports = [
    ./instant.nix
    ./p10k.nix
    ./aliases.nix
    ./vscode.nix
    ./qrcode.nix
  ];

  home.packages = with pkgs; [
    zsh-powerlevel10k
    safe-rm
    direnv
  ];

  programs.zsh = {
    enable = true;
    autosuggestion.enable = true;
    syntaxHighlighting.enable = true;
    oh-my-zsh = {
      enable = true;
      plugins = [
        "git"
        "sudo"
        "command-not-found"
        "qrcode"
        # "direnv"
        "z"
      ];
      theme = "";
    };
  };
}
