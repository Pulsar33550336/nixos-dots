{ pkgs, ... }: {
  environment.systemPackages = with pkgs; [ kdePackages.kpipewire ];
}
