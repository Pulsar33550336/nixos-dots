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

  xdg.configFile."hypr".source = ../assets/hypr;

  home.file.".local/share/hyprland-stubs".source = "${pkgs.hyprland}/share/hypr/stubs";

  home.file.".local/share/icons/MacOS-hyprcursor".source = ../assets/MacOS-hyprcursor;

  home.packages = with pkgs; [
    hyprpaper
    hyprlock
    hypridle
    hyprpicker
  ];

  xresources.properties = {
    "Xft.dpi" = 192;
  };
}
