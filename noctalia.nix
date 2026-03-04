{ pkgs, inputs, ... }:
{
  home-manager.users.Pulsar = {
    imports = [
      inputs.noctalia.homeModules.default
    ];

    home.sessionVariables = {
      NIXPKGS_QT6_QML_IMPORT_PATH = "${pkgs.kdePackages.kirigami.unwrapped}/lib/qt-6/qml";
    };

    xdg.configFile."noctalia/templates".source = ./noctalia;

    programs.noctalia-shell = {
      enable = true;
      settings = {
        settingsVersion = 54;
        bar = {
          barType = "simple";
          position = "top";
          monitors = [ ];
          density = "comfortable";
          showOutline = false;
          showCapsule = true;
          capsuleOpacity = 0.5;
          capsuleColorKey = "none";
          widgetSpacing = 6;
          contentPadding = 2;
          fontScale = 1;
          backgroundOpacity = 0;
          useSeparateOpacity = false;
          floating = false;
          marginVertical = 3;
          marginHorizontal = 3;
          frameThickness = 8;
          frameRadius = 12;
          outerCorners = false;
          hideOnOverview = false;
          displayMode = "always_visible";
          autoHideDelay = 500;
          autoShowDelay = 150;
          showOnWorkspaceSwitch = true;
          widgets = {
            left = [
              {
                colorizeSystemIcon = "none";
                customIconPath = "";
                enableColorization = false;
                icon = "rocket";
                iconColor = "none";
                id = "Launcher";
                useDistroLogo = false;
              }
              {
                compactMode = true;
                diskPath = "/";
                iconColor = "none";
                id = "SystemMonitor";
                showCpuFreq = false;
                showCpuTemp = true;
                showCpuUsage = true;
                showDiskAvailable = false;
                showDiskUsage = false;
                showDiskUsageAsPercent = false;
                showGpuTemp = false;
                showLoadAverage = false;
                showMemoryAsPercent = true;
                showMemoryUsage = true;
                showNetworkStats = false;
                showSwapUsage = true;
                textColor = "none";
                useMonospaceFont = true;
                usePadding = false;
              }
              {
                compactMode = true;
                hideMode = "hidden";
                hideWhenIdle = false;
                id = "MediaMini";
                maxWidth = 185;
                panelShowAlbumArt = true;
                scrollingMode = "hover";
                showAlbumArt = true;
                showArtistFirst = false;
                showProgressRing = true;
                showVisualizer = false;
                textColor = "none";
                useFixedWidth = false;
                visualizerType = "wave";
              }
              {
                colorizeIcons = false;
                hideMode = "hidden";
                id = "ActiveWindow";
                maxWidth = 205;
                scrollingMode = "hover";
                showIcon = true;
                textColor = "none";
                useFixedWidth = false;
              }
              {
                defaultSettings = {
                  activeColor = "primary";
                  enableToast = true;
                  hideInactive = false;
                  iconSpacing = 4;
                  inactiveColor = "none";
                  removeMargins = false;
                };
                id = "plugin:privacy-indicator";
              }
            ];
            center = [
              {
                characterCount = 2;
                colorizeIcons = false;
                emptyColor = "secondary";
                enableScrollWheel = true;
                focusedColor = "primary";
                followFocusedScreen = true;
                groupedBorderOpacity = 1;
                hideUnoccupied = false;
                iconScale = 0.7;
                id = "Workspace";
                labelMode = "index";
                occupiedColor = "secondary";
                pillSize = 0.6000000000000001;
                showApplications = true;
                showBadge = true;
                showLabelsOnlyWhenOccupied = true;
                unfocusedIconsOpacity = 1;
              }
            ];
            right = [
              {
                blacklist = [ ];
                chevronColor = "none";
                colorizeIcons = false;
                drawerEnabled = true;
                hidePassive = false;
                id = "Tray";
                pinned = [
                  "Fcitx"
                  "Flameshot"
                ];
              }
              {
                displayMode = "onhover";
                iconColor = "none";
                id = "Volume";
                middleClickCommand = "pwvucontrol || pavucontrol-qt || pavucontrol";
                textColor = "none";
              }
              {
                applyToAllMonitors = false;
                displayMode = "alwaysHide";
                iconColor = "none";
                id = "Brightness";
                textColor = "none";
              }
              {
                defaultSettings = {
                  autoStartBreaks = false;
                  autoStartWork = false;
                  longBreakDuration = 15;
                  sessionsBeforeLongBreak = 4;
                  shortBreakDuration = 5;
                  workDuration = 25;
                };
                id = "plugin:pomodoro";
              }
              {
                defaultSettings = {
                  currentIconName = "world-download";
                  hideOnZero = false;
                  updateIntervalMinutes = 30;
                  updateTerminalCommand = "foot -e";
                };
                id = "plugin:update-count";
              }
              {
                deviceNativePath = "BAT0";
                displayMode = "graphic-clean";
                hideIfIdle = false;
                hideIfNotDetected = true;
                id = "Battery";
                showNoctaliaPerformance = true;
                showPowerProfiles = true;
              }
              {
                clockColor = "none";
                customFont = "Maple Mono Normal NL NF CN";
                formatHorizontal = "HH:mm / M 月 dd 日 ddd";
                formatVertical = "HH mm - dd MM";
                id = "Clock";
                tooltipFormat = "HH:mm ddd - yyyy 年 M 月 dd 日";
                useCustomFont = false;
              }
              {
                hideWhenZero = false;
                hideWhenZeroUnread = false;
                iconColor = "none";
                id = "NotificationHistory";
                showUnreadBadge = true;
                unreadBadgeColor = "primary";
              }
              {
                colorizeDistroLogo = false;
                colorizeSystemIcon = "none";
                customIconPath = "";
                enableColorization = false;
                icon = "noctalia";
                id = "ControlCenter";
                useDistroLogo = false;
              }
              {
                defaultSettings = {
                  enableCross = true;
                  enableWindowsSelection = true;
                  screenshotEditor = "swappy";
                };
                id = "plugin:screen-shot-and-record";
              }
            ];
          };
          mouseWheelAction = "workspace";
          reverseScroll = false;
          mouseWheelWrap = true;
          screenOverrides = [ ];
        };
        general = {
          avatarImage = "/home/Pulsar/.face";
          dimmerOpacity = 0.2;
          showScreenCorners = true;
          forceBlackScreenCorners = true;
          scaleRatio = 0.9500000000000001;
          radiusRatio = 0.6;
          iRadiusRatio = 1;
          boxRadiusRatio = 1;
          screenRadiusRatio = 0.49;
          animationSpeed = 1.2;
          animationDisabled = false;
          compactLockScreen = true;
          lockScreenAnimations = true;
          lockOnSuspend = true;
          showSessionButtonsOnLockScreen = true;
          showHibernateOnLockScreen = true;
          enableLockScreenMediaControls = false;
          enableShadows = false;
          shadowDirection = "bottom_right";
          shadowOffsetX = 2;
          shadowOffsetY = 3;
          language = "";
          allowPanelsOnScreenWithoutBar = true;
          showChangelogOnStartup = true;
          telemetryEnabled = true;
          enableLockScreenCountdown = true;
          lockScreenCountdownDuration = 3000;
          autoStartAuth = true;
          allowPasswordWithFprintd = true;
          clockStyle = "custom";
          clockFormat = "hh\\nmm";
          passwordChars = true;
          lockScreenMonitors = [ ];
          lockScreenBlur = 0.6;
          lockScreenTint = 0;
          keybinds = {
            keyUp = [ "Up" ];
            keyDown = [ "Down" ];
            keyLeft = [ "Left" ];
            keyRight = [ "Right" ];
            keyEnter = [
              "Return"
              "Enter"
            ];
            keyEscape = [ "Esc" ];
            keyRemove = [ "Del" ];
          };
          reverseScroll = false;
        };
        ui = {
          fontDefault = "Noto Sans CJK SC";
          fontFixed = "Maple Mono Normal NL NF CN";
          fontDefaultScale = 1;
          fontFixedScale = 1;
          tooltipsEnabled = true;
          boxBorderEnabled = true;
          panelBackgroundOpacity = 0.75;
          panelsAttachedToBar = false;
          settingsPanelMode = "centered";
          settingsPanelSideBarCardStyle = false;
        };
        location = {
          name = "Xi'an";
          weatherEnabled = true;
          weatherShowEffects = true;
          useFahrenheit = false;
          use12hourFormat = false;
          showWeekNumberInCalendar = false;
          showCalendarEvents = true;
          showCalendarWeather = true;
          analogClockInCalendar = false;
          firstDayOfWeek = -1;
          hideWeatherTimezone = false;
          hideWeatherCityName = false;
        };
        calendar = {
          cards = [
            {
              enabled = true;
              id = "calendar-header-card";
            }
            {
              enabled = true;
              id = "calendar-month-card";
            }
            {
              enabled = true;
              id = "weather-card";
            }
          ];
        };
        wallpaper = {
          enabled = true;
          overviewEnabled = false;
          directory = "/home/Pulsar/Pictures";
          monitorDirectories = [ ];
          enableMultiMonitorDirectories = false;
          showHiddenFiles = false;
          viewMode = "single";
          setWallpaperOnAllMonitors = true;
          fillMode = "crop";
          fillColor = "#000000";
          useSolidColor = false;
          solidColor = "#1a1a2e";
          automationEnabled = false;
          wallpaperChangeMode = "random";
          randomIntervalSec = 300;
          transitionDuration = 1500;
          transitionType = "random";
          skipStartupTransition = true;
          transitionEdgeSmoothness = 0.05;
          panelPosition = "follow_bar";
          hideWallpaperFilenames = false;
          overviewBlur = 0.4;
          overviewTint = 0.6;
          useWallhaven = false;
          wallhavenQuery = "";
          wallhavenSorting = "relevance";
          wallhavenOrder = "desc";
          wallhavenCategories = "111";
          wallhavenPurity = "100";
          wallhavenRatios = "";
          wallhavenApiKey = "";
          wallhavenResolutionMode = "atleast";
          wallhavenResolutionWidth = "";
          wallhavenResolutionHeight = "";
          sortOrder = "date_asc";
          favorites = [ ];
        };
        appLauncher = {
          enableClipboardHistory = true;
          autoPasteClipboard = false;
          enableClipPreview = true;
          clipboardWrapText = true;
          clipboardWatchTextCommand = "wl-paste --type text --watch cliphist store";
          clipboardWatchImageCommand = "wl-paste --type image --watch cliphist store";
          position = "center";
          pinnedApps = [ ];
          useApp2Unit = false;
          sortByMostUsed = true;
          terminalCommand = "kitty -e";
          customLaunchPrefixEnabled = false;
          customLaunchPrefix = "";
          viewMode = "list";
          showCategories = true;
          iconMode = "tabler";
          showIconBackground = false;
          enableSettingsSearch = true;
          enableWindowsSearch = true;
          enableSessionSearch = true;
          ignoreMouseInput = false;
          screenshotAnnotationTool = "";
          overviewLayer = false;
          density = "default";
        };
        controlCenter = {
          position = "close_to_bar_button";
          openAtMouseOnBarRightClick = true;
          diskPath = "/";
          shortcuts = {
            left = [
              {
                id = "Network";
              }
              {
                id = "Bluetooth";
              }
              {
                id = "WallpaperSelector";
              }
              {
                id = "NoctaliaPerformance";
              }
            ];
            right = [
              {
                id = "Notifications";
              }
              {
                id = "PowerProfile";
              }
              {
                id = "KeepAwake";
              }
              {
                id = "NightLight";
              }
              {
                defaultSettings = {
                  completedCount = 0;
                  count = 0;
                  current_page_id = 0;
                  isExpanded = false;
                  pages = [
                    {
                      id = 0;
                      name = "General";
                    }
                  ];
                  priorityColors = {
                    high = "#f44336";
                    low = "#9e9e9e";
                    medium = "#2196f3";
                  };
                  showBackground = true;
                  showCompleted = true;
                  todos = [ ];
                  useCustomColors = false;
                };
                id = "plugin:todo";
              }
            ];
          };
          cards = [
            {
              enabled = true;
              id = "profile-card";
            }
            {
              enabled = true;
              id = "shortcuts-card";
            }
            {
              enabled = true;
              id = "audio-card";
            }
            {
              enabled = true;
              id = "brightness-card";
            }
            {
              enabled = true;
              id = "weather-card";
            }
            {
              enabled = true;
              id = "media-sysmon-card";
            }
          ];
        };
        systemMonitor = {
          cpuWarningThreshold = 80;
          cpuCriticalThreshold = 90;
          tempWarningThreshold = 80;
          tempCriticalThreshold = 90;
          gpuWarningThreshold = 80;
          gpuCriticalThreshold = 90;
          memWarningThreshold = 80;
          memCriticalThreshold = 90;
          swapWarningThreshold = 80;
          swapCriticalThreshold = 90;
          diskWarningThreshold = 80;
          diskCriticalThreshold = 90;
          diskAvailWarningThreshold = 20;
          diskAvailCriticalThreshold = 10;
          batteryWarningThreshold = 20;
          batteryCriticalThreshold = 5;
          enableDgpuMonitoring = false;
          useCustomColors = false;
          warningColor = "#d0bfe7";
          criticalColor = "#ffb4ab";
          externalMonitor = "resources || missioncenter || jdsystemmonitor || corestats || system-monitoring-center || gnome-system-monitor || plasma-systemmonitor || mate-system-monitor || ukui-system-monitor || deepin-system-monitor || pantheon-system-monitor";
        };
        dock = {
          enabled = false;
          position = "bottom";
          displayMode = "auto_hide";
          dockType = "floating";
          backgroundOpacity = 1;
          floatingRatio = 1;
          size = 1;
          onlySameOutput = true;
          monitors = [ ];
          pinnedApps = [ ];
          colorizeIcons = false;
          showLauncherIcon = false;
          launcherPosition = "end";
          launcherIconColor = "none";
          pinnedStatic = false;
          inactiveIndicators = true;
          groupApps = false;
          groupContextMenuMode = "extended";
          groupClickAction = "cycle";
          groupIndicatorStyle = "dots";
          deadOpacity = 0.6;
          animationSpeed = 1;
          sitOnFrame = false;
          showDockIndicator = false;
          indicatorThickness = 3;
          indicatorColor = "primary";
          indicatorOpacity = 0.6;
        };
        network = {
          wifiEnabled = true;
          airplaneModeEnabled = false;
          bluetoothRssiPollingEnabled = false;
          bluetoothRssiPollIntervalMs = 10000;
          networkPanelView = "wifi";
          wifiDetailsViewMode = "grid";
          bluetoothDetailsViewMode = "grid";
          bluetoothHideUnnamedDevices = false;
          disableDiscoverability = false;
        };
        sessionMenu = {
          enableCountdown = true;
          countdownDuration = 3000;
          position = "center";
          showHeader = true;
          showKeybinds = true;
          largeButtonsStyle = true;
          largeButtonsLayout = "grid";
          powerOptions = [
            {
              action = "lock";
              command = "";
              countdownEnabled = false;
              enabled = true;
              keybind = "1";
            }
            {
              action = "suspend";
              command = "";
              countdownEnabled = true;
              enabled = true;
              keybind = "2";
            }
            {
              action = "hibernate";
              command = "";
              countdownEnabled = true;
              enabled = true;
              keybind = "3";
            }
            {
              action = "reboot";
              command = "";
              countdownEnabled = true;
              enabled = true;
              keybind = "4";
            }
            {
              action = "logout";
              command = "";
              countdownEnabled = true;
              enabled = true;
              keybind = "5";
            }
            {
              action = "shutdown";
              command = "";
              countdownEnabled = true;
              enabled = true;
              keybind = "6";
            }
            {
              action = "rebootToUefi";
              command = "";
              countdownEnabled = true;
              enabled = false;
              keybind = "";
            }
          ];
        };
        notifications = {
          enabled = true;
          enableMarkdown = false;
          density = "default";
          monitors = [ "eDP-1" ];
          location = "top_right";
          overlayLayer = true;
          backgroundOpacity = 1;
          respectExpireTimeout = false;
          lowUrgencyDuration = 3;
          normalUrgencyDuration = 8;
          criticalUrgencyDuration = 15;
          clearDismissed = true;
          saveToHistory = {
            low = true;
            normal = true;
            critical = true;
          };
          sounds = {
            enabled = false;
            volume = 0.5;
            separateSounds = false;
            criticalSoundFile = "";
            normalSoundFile = "";
            lowSoundFile = "";
            excludedApps = "discord,firefox,chrome,chromium,edge";
          };
          enableMediaToast = false;
          enableKeyboardLayoutToast = true;
          enableBatteryToast = true;
        };
        osd = {
          enabled = true;
          location = "top_right";
          autoHideMs = 2000;
          overlayLayer = true;
          backgroundOpacity = 1;
          enabledTypes = [
            0
            1
            2
          ];
          monitors = [ ];
        };
        audio = {
          volumeStep = 2;
          volumeOverdrive = false;
          cavaFrameRate = 30;
          visualizerType = "linear";
          mprisBlacklist = [ ];
          preferredPlayer = "";
          volumeFeedback = false;
          volumeFeedbackSoundFile = "";
        };
        brightness = {
          brightnessStep = 2;
          enforceMinimum = false;
          enableDdcSupport = false;
          backlightDeviceMappings = [ ];
        };
        colorSchemes = {
          useWallpaperColors = true;
          predefinedScheme = "Eldritch";
          darkMode = true;
          schedulingMode = "off";
          manualSunrise = "06:30";
          manualSunset = "18:30";
          generationMethod = "tonal-spot";
          monitorForColors = "eDP-1";
        };
        templates = {
          activeTemplates = [
            {
              enabled = true;
              id = "pywalfox";
            }
            {
              enabled = true;
              id = "kitty";
            }
            {
              enabled = true;
              id = "gtk";
            }
            {
              enabled = true;
              id = "kcolorscheme";
            }
            {
              enabled = true;
              id = "qt";
            }
          ];
          enableUserTheming = true;
        };
        nightLight = {
          enabled = true;
          forced = false;
          autoSchedule = true;
          nightTemp = "6000";
          dayTemp = "6500";
          manualSunrise = "06:30";
          manualSunset = "18:30";
        };
        hooks = {
          enabled = false;
          wallpaperChange = "";
          darkModeChange = "";
          screenLock = "";
          screenUnlock = "";
          performanceModeEnabled = "";
          performanceModeDisabled = "";
          startup = "";
          session = "";
        };
        plugins = {
          autoUpdate = true;
        };
        idle = {
          enabled = true;
          screenOffTimeout = 300;
          lockTimeout = 600;
          suspendTimeout = 900;
          fadeDuration = 5;
          screenOffCommand = "";
          lockCommand = "";
          suspendCommand = "";
          resumeScreenOffCommand = "";
          resumeLockCommand = "";
          resumeSuspendCommand = "";
          customCommands = "[]";
        };
        desktopWidgets = {
          enabled = true;
          overviewEnabled = true;
          gridSnap = true;
          monitorWidgets = [
            {
              name = "eDP-1";
              widgets = [
                {
                  clockColor = "none";
                  clockStyle = "digital";
                  customFont = "";
                  format = "HH:mm\\nd MMMM yyyy";
                  id = "Clock";
                  roundedCorners = true;
                  scale = 1.207878345125389;
                  showBackground = true;
                  useCustomFont = false;
                  x = 936;
                  y = 312;
                }
              ];
            }
          ];
        };
      };

      user-templates = {
        hyprland = {
          input_path = "~/.config/noctalia/templates/colors.conf";
          output_path = "~/.cache/hypr/hyprland-colors.conf";
        };
        hyprlock = {
          input_path = "~/.config/noctalia/templates/hyprlock-colors.conf";
          output_path = "~/.cache/hypr/hyprlock-colors.conf";
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
          keybind-cheatsheet = {
            enabled = true;
            sourceUrl = "https://github.com/noctalia-dev/noctalia-plugins";
          };
          # mpris-lyric = {
          #   enabled = false;
          #   sourceUrl = "https://github.com/noctalia-dev/noctalia-plugins";
          # };
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
          # screen-recorder = {
          #   enabled = false;
          #   sourceUrl = "https://github.com/noctalia-dev/noctalia-plugins";
          # };
          screen-shot-and-record = {
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
          update-count = {
            enabled = true;
            sourceUrl = "https://github.com/noctalia-dev/noctalia-plugins";
          };
        };
        version = 2;
      };

      pluginSettings = {
        keybind-cheatsheet = {
          windowWidth = 1200;
          modKeyVariable = "Super";
          columnCount = 3;
          autoHeight = true;
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
        screen-shot-and-record = {
          enableWindowsSelection = true;
          screenshotEditor = "swappy";
          enableCross = true;
        };
        timer = {
          compactMode = true;
        };
        update-count = {
          updateTerminalCommand = "kitty -e {}";
        };
      };
    };
  };
}
