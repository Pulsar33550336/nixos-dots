{
  inputs,
  pkgs,
  ...
}:
let
  noctalia = inputs.noctalia.packages.${pkgs.stdenv.hostPlatform.system}.default;

  screenshotOverlay = pkgs.callPackage (inputs.pulsar-plugins + "/screenshot-overlay") { };

in
{
  programs.noctalia = {
    enable = true;
    package = noctalia;

    settings = ../assets/noctalia/config.toml;
    checkConfig = true;
  };

  xdg.configFile."noctalia/templates".source = ../assets/noctalia/templates;

  # screen-shot-and-record 插件调用的外部工具。
  home.packages = with pkgs; [
    screenshotOverlay
    wl-clipboard
    tesseract
    curl
    jq
    wf-recorder
    swappy
  ];
}
