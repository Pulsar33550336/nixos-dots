{
  pkgs,
  ...
}:

{
  home.packages = with pkgs; [
    hyprlock
    hyprpicker
    mpvpaper
  ];

  xresources.properties = {
    "Xft.dpi" = 192;
  };
}
