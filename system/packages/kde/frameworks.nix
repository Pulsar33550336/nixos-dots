{ pkgs, ... }: {
  environment.systemPackages = with pkgs; [
    kdePackages.kirigami
    kdePackages.kirigami-addons
  ];
}
