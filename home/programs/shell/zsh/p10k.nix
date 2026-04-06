{
  lib,
  pkgs,
  ...
}:
{
  programs.zsh.initContent = lib.mkAfter ''
    source ${pkgs.zsh-powerlevel10k}/share/zsh-powerlevel10k/powerlevel10k.zsh-theme
    [[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh
  '';
}
