{
  ...
}:
{
  # 配置本体在 assets/noctalia/config.toml：v5 的 TOML 有 900 多行，nix 化只会
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
}
