{
  config,
  lib,
  pkgs,
  ...
}:
{
  programs.kitty = {
    enable = true;

    font = {
      name = "Maple Mono Normal NL NF CN";
      size = 11.0;
    };

    keybindings = {
      "ctrl+c" = "interrupt";
      "ctrl+shift+f" =
        "launch --location=hsplit --allow-remote-control kitty +kitten search.py @active-kitty-window-id";
      "kitty_mod+f" =
        "launch --location=hsplit --allow-remote-control kitty +kitten search.py @active-kitty-window-id";
      "page_up" = "scroll_page_up";
      "page_down" = "scroll_page_down";
      "ctrl+plus" = "change_font_size all +1";
      "ctrl+equal" = "change_font_size all +1";
      "ctrl+kp_add" = "change_font_size all +1";
      "ctrl+minus" = "change_font_size all -1";
      "ctrl+underscore" = "change_font_size all -1";
      "ctrl+kp_subtract" = "change_font_size all -1";
      "ctrl+0" = "change_font_size all 0";
      "ctrl+kp_0" = "change_font_size all 0";
    };

    mouseBindings = {
      "left click ungrabbed" = "no-op";
      "ctrl+left click ungrabbed" = "mouse_click_url";
    };

    settings = {
      cursor_shape = "beam";
      cursor_trail = 0;
      window_margin_width = 4;
      confirm_os_window_close = 0;
      paste_actions = "quote-urls-at-prompt,confirm-if-large";
      shell = "zsh";
      url_style = "straight";
    };

    extraConfig = ''
      # Noctalia
      include themes/noctalia.conf
    '';
  };
}
