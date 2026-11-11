{ pkgs, ... }: {
  environment.systemPackages = with pkgs; [ gparted-full ];
}
