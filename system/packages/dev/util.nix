{ pkgs, ... }: {
  environment.systemPackages = with pkgs; [
    cppcheck
    pkg-config
    rustup
  ];
}
