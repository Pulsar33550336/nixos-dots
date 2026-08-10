{ pkgs, ... }: {
  environment.systemPackages = with pkgs; [
    libreoffice-qt-still
  ];
}
