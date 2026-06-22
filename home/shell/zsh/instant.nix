{
  lib,
  pkgs,
  ...
}:
{
  programs.zsh.initContent = lib.mkBefore ''
    # direnv may make noise.
    (( ''${+commands[direnv]} )) && emulate zsh -c "$(direnv export zsh)"

    if [[ -r "''${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-''${(%):-%n}.zsh" ]]; then
      source "''${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-''${(%):-%n}.zsh"
    fi
    source ${pkgs.zsh-powerlevel10k}/share/zsh-powerlevel10k/powerlevel10k.zsh-theme
    [[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

    (( ''${+commands[direnv]} )) && emulate zsh -c "$(direnv hook zsh)"
  '';
}
