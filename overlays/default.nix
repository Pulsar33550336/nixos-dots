# 关于这个目录：
# 所有关于包覆盖的内容都放到这里
# （出于清晰意义，noto 字体的 overlay 不在这里）
{ ... }: {
  imports = [
    ./kdl-lsp.nix
    ./clash-verge.nix
    ./vhs.nix
  ];
}
