{ pkgs, ... }: {
  # 输入法
  i18n.inputMethod = {
    enable = true;
    type = "fcitx5";
    fcitx5.addons = with pkgs; [
      qt6Packages.fcitx5-chinese-addons
      (fcitx5-rime.override {
        rimeDataPkgs = [
          rime-ice
          rime-data
        ];
      })
    ];
    fcitx5.waylandFrontend = true;
  };
}
