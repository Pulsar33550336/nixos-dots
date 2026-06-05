{
  lib,
  ...
}:
{
  programs.zsh.initContent = lib.mkAfter ''
    function _usr_open_in_vs() {
      if [[ $# -eq 0 ]]; then
          echo "\033[1;31mError:\033[0m bad usage"
          return 2
      fi
      if [[ $# -eq 1 ]]; then
          echo "\033[1;33mNote:\033[0m use $1 with no args will not open any new window"
          return 1
      fi
      echo '\033[1;33mNote:\033[0m file will be opened in VSCode'
      code $2
    }

    if [[ $TERM_PROGRAM = vscode ]]; then
      # 使用函数代替别名
      vi() { _usr_open_in_vs vi "$@"; }
      vim() { _usr_open_in_vs vim "$@"; }
      emacs() { _usr_open_in_vs emacs "$@"; }
    else
        alias vim="nvim"
        alias vi="nvim"
    fi
  '';
}
