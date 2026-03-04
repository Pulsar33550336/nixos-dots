{ config, lib, pkgs, ... }:

{
  xdg.configFile."hypr".source = ../../hypr;
  xdg.configFile."noctalia/templates".source = ../../noctalia;

  home.file.".p10k.zsh".source = ../../p10k.zsh;
  home.file.".local/share/icons/MacOS-hyprcursor".source = ../../MacOS-hyprcursor;
}
