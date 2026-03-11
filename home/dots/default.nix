{
  config,
  lib,
  pkgs,
  ...
}:

{
  xdg.configFile."hypr".source = ../assets/hypr;
  xdg.configFile."noctalia/templates".source = ../assets/noctalia;

  home.file.".p10k.zsh".source = ../assets/p10k.zsh;
  home.file.".local/share/icons/MacOS-hyprcursor".source = ../assets/MacOS-hyprcursor;

  xresources.properties = {
    "Xft.dpi" = 192;
  };
}
