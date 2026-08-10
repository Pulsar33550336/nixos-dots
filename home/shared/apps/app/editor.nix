{
  pkgs,
  ...
}:
let
  vscode-pkg = pkgs.vscode.override {
    commandLineArgs = [
      "--ozone-platform-hint=auto"
      "--enable-wayland-ime"
      "--password-store=kwallet5"
    ];
  };
in
{
  home.packages = with pkgs; [
    neovim
    vscode-pkg
  ];
}
