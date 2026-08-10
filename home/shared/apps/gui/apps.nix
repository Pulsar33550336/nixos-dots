{ pkgs, ... }: {
  home.packages = with pkgs; [
    fuzzel
    grim
    slurp
    swappy
    wf-recorder
    wl-clipboard
    wlsunset
  ];
}
