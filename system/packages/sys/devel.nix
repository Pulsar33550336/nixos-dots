{ pkgs, ... }: {
  environment.systemPackages = with pkgs; [
    bison
    gcc
    gnum4
  ];
}
