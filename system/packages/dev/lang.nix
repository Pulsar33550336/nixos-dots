{ pkgs, ... }: {
  environment.systemPackages = with pkgs; [
    perl
    python3
  ];
}
