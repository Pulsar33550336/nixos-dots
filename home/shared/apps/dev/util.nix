{ pkgs, ... }: {
  home.packages = with pkgs; [
    just-lsp
    opencode
  ];
}
