{
  lib,
  ...
}:
{
  programs.zsh.initContent = lib.mkAfter ''
    alias reload="source ~/.zshrc"
    alias rm="safe-rm"
    alias rmexe="file ./**/* | grep ELF | cut -d: -f1 | xargs rm -f"
    alias start="kioclient exec"
  '';
}
