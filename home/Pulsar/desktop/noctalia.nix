{
  inputs,
  ...
}:
{
  imports = [
    inputs.noctalia.homeModules.default
  ];

  xdg.configFile."noctalia/templates".source = ../assets/noctalia;

  programs.noctalia-shell = {
    enable = true;
    # 将长长的配置 nix 化并写进配置中是一种愚蠢的行为
    settings = ../assets/noctalia-config.json;
    # 不过剩下的拿 nix 声明式配置还是不错的
    user-templates = {
      templates = {
        hyprland = {
          input_path = "~/.config/noctalia/templates/colors.lua";
          output_path = "~/.cache/hypr/hyprland-colors.lua";
        };
        hyprlock = {
          input_path = "~/.config/noctalia/templates/hyprlock-colors.conf";
          output_path = "~/.cache/hypr/hyprlock-colors.conf";
        };
      };
    };

    plugins = {
      sources = [
        {
          enabled = true;
          name = "Official Noctalia Plugins";
          url = "https://github.com/noctalia-dev/noctalia-plugins";
        }
        {
          enabled = true;
          name = "Pulsar's Noctalia Plugins Fork";
          url = "https://github.com/Pulsar33550336/pulsar-ns-plugins";
        }

      ];
      states = {
        github-feed = {
          enabled = false;
          sourceUrl = "https://github.com/noctalia-dev/noctalia-plugins";
        };
        "f4c24d:keybind-cheatsheet" = {
          enabled = true;
          sourceUrl = "https://github.com/Pulsar33550336/pulsar-ns-plugins";
        };
        polkit-agent = {
          enabled = true;
          sourceUrl = "https://github.com/noctalia-dev/noctalia-plugins";
        };
        pomodoro = {
          enabled = true;
          sourceUrl = "https://github.com/noctalia-dev/noctalia-plugins";
        };
        privacy-indicator = {
          enabled = true;
          sourceUrl = "https://github.com/noctalia-dev/noctalia-plugins";
        };
        "f4c24d:screen-shot-and-record" = {
          enabled = true;
          sourceUrl = "https://github.com/Pulsar33550336/pulsar-ns-plugins";
        };
        timer = {
          enabled = true;
          sourceUrl = "https://github.com/noctalia-dev/noctalia-plugins";
        };
        todo = {
          enabled = true;
          sourceUrl = "https://github.com/noctalia-dev/noctalia-plugins";
        };
      };
      version = 2;
    };

    pluginSettings = {
      "f4c24d:keybind-cheatsheet" = {
        windowWidth = 1200;
        columnCount = 3;
        autoHeight = true;
        showUndescribedBinds = true;

        keyColorAlt = "#69787e";
        keyColorXF86 = "#4ECDC4";
        keyColorPrint = "#95E1D3";
        keyColorNumeric = "#A8DADC";
        keyColorMouse = "#bcc5eb";
        keyColorSuper = "#3f484b";
        keyColorCtrl = "#3f484b";
        keyColorShift = "#69787e";
        keyColorDefault = "#6C757D";
        keyLabelColor = "#FFFFFF";
        descriptionTextColor = "#E0E0E0";

        useMacSymbol = false;
        useFnSymbol = true;
        useMouseSymbol = false;
        superKeyText = "";
      };
      pomodoro = {
        workDuration = 25;
        shortBreakDuration = 5;
        longBreakDuration = 15;
        sessionsBeforeLongBreak = 4;
        autoStartBreaks = false;
        autoStartWork = false;
        compactMode = true;
        playSound = true;
      };
      privacy-indicator = {
        hideInactive = true;
        enableToast = false;
        iconSpacing = 2;
        removeMargins = false;
        activeColor = "primary";
        inactiveColor = "none";
      };
      "f4c24d:screen-shot-and-record" = {
        enableWindowsSelection = true;
        screenshotEditor = "swappy";
        enableCross = true;
        keepSourceScreenshot = false;
        pngCompressionLevel = 1;
        savePath = "~/Pictures/Screenshots";
        recordingSavePath = "~/Videos";
        recordingNotifications = false;
        notificationsEnabled = false;
      };
      timer = {
        compactMode = true;
      };
    };
  };
}
