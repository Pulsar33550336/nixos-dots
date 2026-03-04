{
  config,
  pkgs,
  lib,
  ...
}:

{
  home.packages = with pkgs; [
    zsh-powerlevel10k
    safe-rm
    direnv
    neovim
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
        "direnv"
        "z"
      ];
      theme = "";
    };
    initContent = lib.mkMerge [
      (lib.mkBefore ''
        # Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
        # Initialization code that may require console input (password prompts, [y/n]
        # confirmations, etc.) must go above this block; everything else may go below.
        if [[ -r "''${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-''${(%):-%n}.zsh" ]]; then
          source "''${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-''${(%):-%n}.zsh"
        fi
      '')
      (lib.mkAfter ''
        source ${pkgs.zsh-powerlevel10k}/share/zsh-powerlevel10k/powerlevel10k.zsh-theme
        [[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

        alias reload="source ~/.zshrc"
        alias rm="safe-rm"
        alias rmexe="file ./**/* | grep ELF | cut -d: -f1 | xargs rm -f"
        alias start="kioclient exec"

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

        # QR码识别函数
        qrdecode() {
            if [[ $# -eq 0 ]]; then
                echo "用法: qrdecode <图片文件>"
                echo "示例: qrdecode qrcode.png"
                return 1
            fi

            local image_file="$1"

            # 检查文件是否存在
            if [[ ! -f "$image_file" ]]; then
                echo "错误: 文件 '$image_file' 不存在"
                return 1
            fi

            # 检查文件类型
            if ! file "$image_file" | grep -q "image"; then
                echo "错误: '$image_file' 不是有效的图片文件"
                return 1
            fi

            # 发送请求到API
            local response
            response=$(curl -s -X POST \
                -F "file=@$image_file" \
                "https://api.2dcode.biz/v1/read-qr-code")

            # 检查curl是否成功
            if [[ $? -ne 0 ]]; then
                echo "错误: 网络请求失败"
                return 1
            fi

            # 解析JSON响应
            local contents
            if command -v jq >/dev/null 2>&1; then
                contents=$(echo "$response" | jq -r '.data.contents // empty')
            else
                # 如果没有jq，使用grep和sed简单提取
                contents=$(echo "$response" | grep -o '"contents":"[^"]*"' | head -1 | sed 's/"contents":"\([^"]*\)"/\1/')
            fi

            if [[ -n "$contents" ]]; then
                echo "识别到的二维码内容: $contents"
                # 可选：复制到剪贴板（macOS）
                if command -v pbcopy >/dev/null 2>&1; then
                    echo "$contents" | pbcopy
                    echo "内容已复制到剪贴板"
                fi
            else
                echo "错误: 无法识别二维码内容"
                echo "API响应: $response"
                return 1
            fi
        }

        # 自动补全支持
        _qrdecode() {
            _files -g "*.(png|jpg|jpeg|gif|bmp)"
        }

        compdef _qrdecode qrdecode
      '')
    ];
  };
}
