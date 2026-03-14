{
  pkgs,
  lib,
  ...
}:

{
  home.activation = {
    makeScriptsExecutable = lib.hm.dag.entryAfter [ "writeBoundary" ] ''
      if [ -d "$HOME/.config/hypr" ]; then
        find "$HOME/.config/hypr" -name "*.sh" -exec chmod +x {} \; 2>/dev/null || true
      fi
    '';
  };

  home.packages = with pkgs; [
    hyprpaper
    hyprlock
    hypridle
    wl-clipboard
    grim
    slurp
    swappy
    fuzzel
    playerctl
    hyprpicker
    wlsunset
    wf-recorder
    imagemagick
    libnotify
    xrdb
    jq
  ];
}
