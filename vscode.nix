{
  config,
  lib,
  pkgs,
  inputs,
  ...
}:
let
  homeDir = config.home.homeDirectory;
  dataDir = config.xdg.dataHome;
  userDataDir = "${dataDir}/vscode/data";
  extensionsDir = "${dataDir}/vscode/extensions";

  marketplace = inputs.nix-vscode-extensions.extensions.${pkgs.system}.vscode-marketplace;
  marketplace-universal = inputs.nix-vscode-extensions.extensions.${pkgs.system}.vscode-marketplace-universal;

  # 包装 VSCode 包，注入路径参数
  vscode-pkg = pkgs.vscode.override {
    commandLineArgs = [
      "--user-data-dir"
      "${userDataDir}"
      "--extensions-dir"
      "${extensionsDir}"
      "--ozone-platform-hint=auto"
      "--enable-wayland-ime"
    ];
  };
in
{
  programs.vscode = {
    enable = true;
    package = vscode-pkg;
    # mutableExtensionsDir = false;

    # 插件列表（在这里添加或删除插件）
    extensions = with marketplace; [
      maptz.regionfolder
      jeff-hykin.better-cpp-syntax
      ms-vscode.cpp-devtools
      ms-vscode.cpptools-themes
      ms-ceintl.vscode-language-pack-zh-hans
      xaver.clang-format
      llvm-vs-code-extensions.vscode-clangd
      angelo-breuer.clock
      ms-vscode.cmake-tools
      formulahendry.code-runner
      marketplace-universal.vadimcn.vscode-lldb
      langningchen.cph-ng
      repreng.csv
      usernamehw.errorlens
      tamasfe.even-better-toml
      pomdtr.excalidraw-editor
      miguelsolorio.fluent-icons
      github.vscode-github-actions
      github.codespaces
      ms-vscode.hexeditor
      oderwat.indent-rainbow
      ms-toolsai.jupyter
      ms-toolsai.vscode-jupyter-cell-tags
      ms-toolsai.jupyter-keymap
      ms-toolsai.jupyter-renderers
      ms-toolsai.vscode-jupyter-slideshow
      shd101wyy.markdown-preview-enhanced
      davidanson.vscode-markdownlint
      rakib13332.material-code
      pkief.material-icon-theme
      jnoortheen.nix-ide
      ms-python.vscode-pylance
      ms-python.python
      ms-python.debugpy
      bbenoist.qml
      mechatroner.rainbow-csv
      rust-lang.rust-analyzer
      ctf0.show-unsaved-changes
      textualize.textual-syntax-highlighter
      myriad-dreamin.tinymist
      yltx.vscode-luogu
      tomoki1207.pdf
      vue.volar
      slevesque.vscode-zipexplorer
      # github.copilot-chat
      # ms-vscode-remote.remote-wsl
    ];

    # 将你的 JSON 配置转换为 Nix 语法
    userSettings = {
      # Editor settings
      "editor.fontSize" = 18;
      "editor.fontFamily" = "'Maple Mono Normal NL NF CN', Consolas, 'Courier New', monospace";
      "editor.wordWrap" = "on";
      "editor.mouseWheelZoom" = true;
      "editor.formatOnPaste" = true;
      "editor.formatOnSave" = true;
      "editor.cursorSmoothCaretAnimation" = "explicit";
      "editor.inlayHints.enabled" = "off";
      "editor.defaultFormatter" = "llvm-vs-code-extensions.vscode-clangd";

      # Unicode settings
      "editor.unicodeHighlight.allowedLocales" = {
        "zh-hans" = true;
      };

      # Minimap settings
      "editor.minimap.showSlider" = "always";
      "editor.minimap.renderCharacters" = false;

      # Files settings
      "files.autoSave" = "onFocusChange";
      "files.trimTrailingWhitespace" = true;

      # Explorer settings
      "explorer.confirmDelete" = false;
      "explorer.confirmDragAndDrop" = false;

      # Workbench settings
      "workbench.startupEditor" = "none";
      "workbench.tree.indent" = 22;
      "workbench.productIconTheme" = "fluent-icons";
      "workbench.secondarySideBar.showLabels" = false;
      "workbench.iconTheme" = "material-icon-theme";
      "workbench.colorTheme" = "Material Code";
      "workbench.preferredLightColorTheme" = "Material Code Light";
      "workbench.editorAssociations" = {
        "{hexdiff}:/**/*.*" = "hexEditor.hexedit";
        "*.exe" = "hexEditor.hexedit";
        "*.zip" = "hexEditor.hexedit";
        "*.wasm" = "hexEditor.hexedit";
      };
      "workbench.editor.empty.hint" = "hidden";

      # Window settings
      "window.autoDetectHighContrast" = false;
      "window.autoDetectColorScheme" = true;

      # Terminal settings
      "terminal.integrated.smoothScrolling" = true;
      "terminal.integrated.cursorStyle" = "line";
      "terminal.integrated.cursorStyleInactive" = "line";
      "terminal.integrated.cursorBlinking" = true;
      "terminal.integrated.enableMultiLinePasteWarning" = "never";
      "terminal.integrated.enableVisualBell" = true;
      "terminal.integrated.fontFamily" = "'Maple Mono Normal NL NF CN', CaskaydiaMono Nerd Font";
      "terminal.integrated.rightClickBehavior" = "paste";
      "terminal.integrated.shellIntegration.enabled" = false;
      "terminal.integrated.suggest.enabled" = false;
      "terminal.integrated.initialHint" = false;
      "terminal.integrated.defaultProfile.windows" = "PowerShell";

      "terminal.integrated.profiles.windows" = {
        "PowerShell" = {
          "source" = "PowerShell";
          "icon" = "terminal-powershell";
        };
        "Command Prompt" = {
          "path" = [
            "\${env:windir}\\Sysnative\\cmd.exe"
            "\${env:windir}\\System32\\cmd.exe"
          ];
          "args" = [ ];
          "icon" = "terminal-cmd";
        };
        "Git Bash" = {
          "source" = "Git Bash";
        };
        "Ubuntu (WSL)" = {
          "path" = "C:\\windows\\System32\\wsl.exe";
          "args" = [
            "-d"
            "Ubuntu"
          ];
        };
        "Windows PowerShell" = {
          "path" = "C:\\windows\\System32\\WindowsPowerShell\\v1.0\\powershell.exe";
        };
      };

      # Git settings
      "git.openRepositoryInParentFolders" = "never";
      "git.autofetch" = true;
      "git.confirmSync" = false;
      "git.defaultBranchName" = "master";
      "git.enableSmartCommit" = true;

      # Diff editor settings
      "diffEditor.maxComputationTime" = 0;
      "diffEditor.renderSideBySide" = true;
      "diffEditor.useInlineViewWhenSpaceIsLimited" = false;

      # Markdown settings
      "markdown.preview.fontSize" = 20;

      # Hex editor settings
      "hexeditor.columnWidth" = 12;
      "hexeditor.showDecodedText" = true;
      "hexeditor.defaultEndianness" = "little";
      "hexeditor.inspectorType" = "aside";

      # Clock settings
      "clock.alignment" = "Right";
      "clock.format" = "yyyy/mm/dd hh:MM:ss";
      "clock.priority" = 50;

      # Code Runner settings
      "code-runner.saveFileBeforeRun" = true;
      "code-runner.runInTerminal" = true;
      "code-runner.ignoreSelection" = true;
      "code-runner.showRunCommandInEditorContextMenu" = false;

      # Luogu extension settings
      "luogu.guessProblemID" = true;
      "luogu.defaultLanguageVersion" = {
        "C++" = "C++14 (GCC 9) with O2";
      };
      "luogu.alwaysUseDefaultLanguageVersion" = true;

      # Show Unsaved Changes settings
      "showUnsavedChanges.styles" = {
        "overview" = {
          "opacity" = 0.75;
          "add" = "#2faf64";
          "change" = "#FFCE57";
          "del" = "#a31515";
        };
        "gutter" = {
          "size" = "auto";
          "add" = "#2faf64";
          "change" = "#FFCE57";
          "del" = "#a31515";
        };
      };
      "showUnsavedChanges.wholeLine" = false;
      "showUnsavedChanges.clearOnSave" = true;

      # CPH (Competitive Programming Helper) settings
      "cph-ng.sidebar.showTips" = false;
      "cph-ng.sidebar.fontFamily" =
        "'Maple Mono Normal NL NF CN', Monaspace, 'Cascadia Code', 'Source Code Pro', Consolas, 'Ubuntu Mono', monospace";
      "cph-ng.compilation.useWrapper" = true;
      "cph-ng.compilation.cppArgs" = "-O2 -std=c++14 -Wall -DCPH -DONLINE_JUDGE";
      "cph-ng.companion.submitLanguage" = 54;

      # Clang format settings
      "clang-format.fallbackStyle" = "Webkit";
      "clang-format.language.cpp.style" = "file";

      # Clangd settings
      "clangd.arguments" = [
        "--compile-commands-dir=.vscode"
        "--suggest-missing-includes=false"
        "--background-index=false"
        "--clang-tidy=false"
        "--header-insertion=never"
        "--query-driver=/usr/bin/g++"
      ];

      # Material Code theme settings
      "material-code.primaryColor" = "#4C3D50";
      "material-code.syntaxTheme" = "现代深色";
      "material-code.syntaxThemeLight" = "现代深色";

      # Maptz Region Folder settings
      "maptz.regionfolder" = {
        "[cpp]" = {
          "foldEndRegex" = "^[\\s]*#pragma[\\s]*endregion.*$";
          "foldStartRegex" = "^[\\s]*#pragma[\\s]*region[\\s]*(.*)[\\s]*$";
        };
      };

      # Indent Rainbow settings
      "indentRainbow.errorColor" = "rgba(128,32,32,0)";
      "indentRainbow.indicatorStyle" = "light";

      # Winopacity settings
      "winopacity.opacity" = 255;

      # Security settings
      "security.workspace.trust.untrustedFiles" = "open";

      # Chat settings
      "chat.commandCenter.enabled" = false;
      "chat.notifyWindowOnConfirmation" = false;
      "chat.agent.maxRequests" = 0;
      "chat.agent.enabled" = false;

      # Telemetry settings
      "telemetry.feedback.enabled" = false;

      # GitHub Copilot settings
      "github.copilot.enable" = {
        "cpp" = false;
      };

      # Application settings
      "application.shellEnvironmentResolutionTimeout" = 30;

      # Markdown Preview Enhanced settings
      "markdown-preview-enhanced.enablePreviewZenMode" = true;

      # Language-specific settings
      "[cpp]" = {
        "editor.defaultFormatter" = "xaver.clang-format";
      };
      "[typst]" = {
        "editor.defaultFormatter" = "myriad-dreamin.tinymist";
      };
      "[rust]" = {
        "editor.defaultFormatter" = "rust-lang.rust-analyzer";
      };
      "[markdown]" = {
        "editor.defaultFormatter" = "DavidAnson.vscode-markdownlint";
      };
      "[json]" = {
        "editor.defaultFormatter" = "vscode.json-language-features";
      };
      "[jsonc]" = {
        "editor.defaultFormatter" = "vscode.json-language-features";
      };
      "[nix]" = {
        "editor.defaultFormatter" = "jnoortheen.nix-ide";
      };
    };
  };

  systemd.user.services.vscode-setup = {
    Unit = {
      Description = "VSCode Setup service";
      After = [ "graphical-session-pre.target" ];
      Wants = [ "graphical-session-pre.target" ];
    };
    Install.WantedBy = [ "graphical-session.target" ];
    Service = {
      Type = "oneshot";
      UMask = "0022";
      ExecStart = lib.getExe (
        pkgs.writeShellApplication {
          name = "vscode-setup";
          runtimeInputs = with pkgs; [
            coreutils
            gnutar
            jq
          ];
          text =
            let
              userSrc = "${homeDir}/.config/Code/User";
              userDst = "${userDataDir}/User";
              extSrc = "${homeDir}/.vscode/extensions";
              extDst = extensionsDir;

              dirsToPreserve = [
                "workspaceStorage"
                "History"
              ];
              backupCmds = builtins.concatStringsSep "\n" (
                map (dir: ''
                  if [ -e "${userDst}/${dir}" ]; then
                    echo "Backing up data/User/${dir}..."
                    mv "${userDst}/${dir}" "/tmp/vscode-${dir}-$$"
                  fi
                '') (dirsToPreserve ++ [ "globalStorage" ])
              );
              restoreCmds = builtins.concatStringsSep "\n" (
                map (dir: ''
                  if [ -e "/tmp/vscode-${dir}-$$" ]; then
                    echo "Restoring data/User/${dir}..."
                    mv "/tmp/vscode-${dir}-$$" "${userDst}/${dir}"
                  fi
                '') dirsToPreserve
              );
            in
            ''
              set -eu
              ${backupCmds}
              echo "Cleaning old directories..."
              rm -rf "${userDst}"
              rm -rf "${extDst}"
              mkdir -p "${userDataDir}"
              mkdir -p "${extDst}"
              echo "Copying user settings from ${userSrc}..."
              cp -r --dereference --no-preserve=mode,ownership ${userSrc} "${userDst}"
              echo "Copying extensions from ${extSrc}..."
              tar -h -C "${extSrc}" -cf - . | tar -C "${extDst}" -xf - --no-same-owner --no-same-permissions --mode='u=rX,go=rX'
              chmod u+w -R "${extDst}" 2>/dev/null || true
              ${restoreCmds}
              echo "Restoring and merging data/User/globalStorage..."
              if [ -e "/tmp/vscode-globalStorage-$$" ]; then
                cp -rT "/tmp/vscode-globalStorage-$$" "${userDst}/globalStorage"
                src_storage_json="${userSrc}/globalStorage/storage.json"
                dst_storage_json="${userDst}/globalStorage/storage.json"
                if [ -f "$src_storage_json" ] && [ -f "$dst_storage_json" ]; then
                  merged_json=$(mktemp)
                  jq -s '.[0] * .[1]' "$dst_storage_json" "$src_storage_json" > "$merged_json"
                  mv "$merged_json" "$dst_storage_json"
                fi
              fi
              echo "VSCode setup complete."
            '';
        }
      );
    };
  };
}
