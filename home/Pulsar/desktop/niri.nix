{
  ...
}:
{
  # niri 的 config.kdl 现在由 HM 管；~/.config/niri/noctalia.kdl 仍是 Noctalia
  # 生成的（内置 niri 模板），两者是不同文件，互不覆盖。
  #
  # 注意：内置模板的 apply.sh 只会在缺少 `include "noctalia.kdl"` 时改
  # config.kdl；这里已经是 store 里的只读软链，所以那行必须留在源文件里。
  xdg.configFile."niri/config.kdl".source = ../assets/niri/config.kdl;
}
