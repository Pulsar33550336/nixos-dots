{ pkgs, ... }: {
  environment.systemPackages = with pkgs; [
    cmake
    gnumake
    meson
    ninja
  ];
}
