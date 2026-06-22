{
  pkgs,
  ...
}:
{
  programs.ghostty = {
    enable = true;
    systemd = {
      enable = true;
    };
    enableZshIntegration = false;
    settings = {
      theme = "Kitty Default";

      font-family = [
        "Maple Mono Normal NL NF CN"
      ];

      font-codepoint-map = [
        "U+23F8=Noto Sans Symbols 2"
        "U+21E1,U+21E3=Noto Sans Math"
      ];

      font-size = 11;

      shell-integration = "none";

      confirm-close-surface = false;
      window-padding-x = 8;
      window-padding-y = 8;

      cursor-style = "bar";
      adjust-cursor-thickness = 2;

      app-notifications = false;

      link-previews = false;

      quit-after-last-window-closed = false;
    };
  };

  dbus.packages = with pkgs; [
    ghostty
  ];
}
