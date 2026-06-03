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

  home.sessionVariables = {
    # Make QT Happy
    NIXPKGS_QT6_QML_IMPORT_PATH = lib.concatStringsSep ":" [
      # Noctalia
      "${pkgs.kdePackages.kirigami.unwrapped}/lib/qt-6/qml"
      # KDE System Settings
      "${pkgs.kdePackages.knewstuff}/lib/qt-6/qml"
      "${pkgs.kdePackages.kdeclarative}/lib/qt-6/qml"
      "${pkgs.kdePackages.ksvg}/lib/qt-6/qml"
    ];
  };

  home.file.".local/share/hyprland-stubs".source = "${pkgs.hyprland}/share/hypr/stubs";

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
    tesseract
  ];
}
