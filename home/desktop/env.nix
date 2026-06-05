{ pkgs, lib, ... }:
{
  home.sessionVariables = {
    NIXPKGS_QT6_QML_IMPORT_PATH = lib.concatStringsSep ":" [
      "${pkgs.kdePackages.kirigami.unwrapped}/lib/qt-6/qml"
      "${pkgs.kdePackages.knewstuff}/lib/qt-6/qml"
      "${pkgs.kdePackages.kdeclarative}/lib/qt-6/qml"
      "${pkgs.kdePackages.ksvg}/lib/qt-6/qml"
    ];
  };
}
