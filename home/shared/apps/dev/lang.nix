{ pkgs, ... }: {
  home.packages = with pkgs; [
    kdl-lsp
    kdlfmt
    nixd
    nixfmt
  ];
}
