{
  pkgs,
  ...
}:
let
  # 插件本体（Luau）和它依赖的 overlay 二进制都在仓库里，版本一起走。
  screenshotOverlay = pkgs.callPackage ../../../pkgs/screenshot-overlay { };
in
{
  # 配置本体在 assets/noctalia/config.toml：v5 的 TOML 有 400 多行，nix 化只会
  # 让 diff 更难读。这里只声明"哪份文件"和"构建期校验"。
  #
  # v5 的配置分两层：~/.config/noctalia/*.toml 是声明式基础层，GUI 改动用
  # ~/.local/state/noctalia/settings.toml 覆盖。所以 GUI 里改了东西却"没生效"时，
  # 先看 state 那个文件。
  programs.noctalia = {
    enable = true;
    settings = ../assets/noctalia/config.toml;

    # 构建期跑 `noctalia config validate`：配置写错会在这里失败，而不是开屏发现
    # 面板空白。调试配置时可以先临时关掉。
    checkConfig = true;
  };

  # screen-shot-and-record 插件调用的外部工具。插件 manifest 里声明了它们，但
  # 只用于报错提示，不会替你安装。
  home.packages = [
    screenshotOverlay
    pkgs.wl-clipboard
    pkgs.tesseract
    pkgs.curl
    pkgs.jq
    pkgs.wf-recorder
    pkgs.swappy
  ];

  # v5 把 ~/.local/share/noctalia/plugins/<dir>/ 当作内置 local 源，所以插件不需要
  # 在 config.toml 里写 path source（那样只能写绝对路径，且绑死开发目录）。
  xdg.dataFile."noctalia/plugins/screen-shot-and-record".source =
    ../../../pkgs/pulsar-plugins/screen-shot-and-record;
}
