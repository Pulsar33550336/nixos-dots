# Edit this configuration file to define what should be installed on
# your system. Help is available in the configuration.nix(5) man page, on
# https://search.nixos.org/options and in the NixOS manual (`nixos-help`).

{
  config,
  lib,
  pkgs,
  ...
}:
let
  pam-fprint-grosshack = pkgs.callPackage ./packages/pam-fprint-grosshack.nix { };
in
{
  imports = [
    # Include the results of the hardware scan.
    ./hardware-configuration.nix
    #<home-manager/nixos>
  ];

  # Use the systemd-boot EFI boot loader.
  boot.loader = {
    grub = {
      enable = true;
      efiSupport = true;
      device = "nodev"; # UEFI模式使用"nodev"
    };
    efi = {
      canTouchEfiVariables = true;
      efiSysMountPoint = "/boot"; # EFI分区挂载点
    };
  };

  # Enable Hyprland
  programs.hyprland.enable = true;

  # Required services
  services.geoclue2.enable = true; # For QtPositioning
  # networking.networkmanager.enable = true;  # For network management
  services.upower.enable = true; # For battery status

  # System fonts (optional but recommended)
  fonts.packages = with pkgs; [
    rubik
    nerd-fonts.ubuntu
    nerd-fonts.jetbrains-mono
    maple-mono.NormalNL-NF-CN
  ];

  # Use latest kernel.
  boot.kernelPackages = pkgs.linuxPackages_latest;

  networking.hostName = "NixOS-Pulsar"; # Define your hostname.

  # Configure network connections interactively with nmcli or nmtui.
  networking.networkmanager.enable = true;
  hardware.bluetooth.enable = true;
  services.power-profiles-daemon.enable = true;

  # Set your time zone.
  time.timeZone = "Asia/Shanghai";

  nix.settings = {
    substituters = [
      "https://mirrors.tuna.tsinghua.edu.cn/nix-channels/store?priority=10"
      "https://mirrors.ustc.edu.cn/nix-channels/store?priority=5"
      "https://cache.nixos.org"
    ];
    experimental-features = [
      "nix-command"
      "flakes"
    ];
  };

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Select internationalisation properties.
  # i18n.defaultLocale = "en_US.UTF-8";
  # console = {
  #   font = "Lat2-Terminus16";
  #   keyMap = "us";
  #   useXkbConfig = true; # use xkb.options in tty.
  # };

  # Enable the X11 windowing system.
  # services.xserver.enable = true;
  services.desktopManager.plasma6.enable = true;
  services.displayManager.sddm = {
    enable = true;
    autoLogin = {
      enable = true;
      user = "Pulsar"; # 请替换为你的实际用户名
    };
    # 可选：如果你喜欢更现代的 SDDM 主题
    # theme = "breeze"; 
  };
  services.displayManager.defaultSession = "hyprland";

  # Configure keymap in X11
  services.xserver.xkb.layout = "us";
  # services.xserver.xkb.options = "eurosign:e,caps:escape";

  # Enable CUPS to print documents.
  # services.printing.enable = true;

  # Enable sound.
  # services.pulseaudio.enable = true;
  # OR
  services.pipewire = {
    enable = true;
    pulse.enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
  };

  # Enable touchpad support (enabled default in most desktopManager).
  # services.libinput.enable = true;

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.Pulsar = {
    isNormalUser = true;
    description = "Pulsar";
    extraGroups = [
      "networkmanager"
      "wheel"
    ]; # Enable ‘sudo’ for the user.
    packages = with pkgs; [ ];
  };

  programs.firefox.enable = true;
  services.flatpak.enable = true;
  services.fprintd.enable = true;

  security.pam.services = {
    # 明确开启的服务
    sudo.fprintAuth = true;
    polkit-1 = {
      fprintAuth = false;
      rules.auth = {
        fingerprint = {
          order = 100;
          control = "sufficient";
          modulePath = "${pam-fprint-grosshack}/lib/security/pam_fprintd_grosshack.so";
        };
      };
    };

    kde-fingerprint.fprintAuth = true;  # KDE 指纹特定
    
    # 明确关闭所有其他服务（基于你列出的列表）
    login.fprintAuth = false;           # 登录界面
    chfn.fprintAuth = false;            # 修改finger信息
    chpasswd.fprintAuth = false;        # 批量修改密码
    chsh.fprintAuth = false;            # 修改shell
    groupadd.fprintAuth = false;        # 添加组
    groupdel.fprintAuth = false;        # 删除组
    groupmems.fprintAuth = false;       # 管理组成员
    groupmod.fprintAuth = false;        # 修改组
    kde.fprintAuth = false;             # KDE 相关
    other.fprintAuth = false;           # 其他服务
    passwd.fprintAuth = false;          # 修改密码
    runuser.fprintAuth = false;         # 以其他用户身份运行
    runuser-l.fprintAuth = false;       # runuser 的登录 shell 版本
    sddm.fprintAuth = false;            # SDDM 登录管理器
    sddm-autologin.fprintAuth = false;  # SDDM 自动登录
    sddm-greeter.fprintAuth = false;    # SDDM 欢迎界面
    sshd.fprintAuth = false;            # SSH 守护进程
    su.fprintAuth = false;              # 切换用户
    systemd-run0.fprintAuth = false;    # systemd 运行命令
    systemd-user.fprintAuth = false;    # systemd 用户实例
    useradd.fprintAuth = false;         # 添加用户
    userdel.fprintAuth = false;         # 删除用户
    usermod.fprintAuth = false;         # 修改用户
    vlock.fprintAuth = false;           # 终端锁屏
    xlock.fprintAuth = false;           # X 锁屏
  };

  programs.clash-verge.enable = true;
  programs.clash-verge.tunMode = true;
  programs.clash-verge.serviceMode = true;

  # List packages installed in system profile.
  # You can use https://search.nixos.org/ to find more packages (and options).
  environment.systemPackages = with pkgs; [
    vim # Do not forget to add an editor to edit configuration.nix! The Nano editor is also installed by default.
    wget
    kitty
    git
    perl
    cargo
    qq
    killall
    gcc
    clang
    gdb
    cmake
    ninja
    meson
    # vscode
    file
    vlc
    valgrind
    cppcheck
    clang-tools
    pipewire
    fastfetch
    xwayland-satellite
    kdePackages.kirigami
    kdePackages.kirigami-addons
    kdePackages.qt6ct
    kdePackages.kpipewire
    libsForQt5.kirigami2
    libsForQt5.kirigami-addons
  ];

  nixpkgs.config.allowUnfree = true;

  services.openssh.enable = true;
  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };

  # List services that you want to enable:

  # Enable the OpenSSH daemon.
  # services.openssh.enable = true;

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  networking.firewall.enable = false;
  # networking.firewall = {
  #   trustedInterfaces = [
  #     "virbr0"
  #     "Mihomo"
  #   ];
  #   extraReversePathFilterRules = ''iifname { "Mihomo" } accept comment "trusted interfaces"'';
  # };

  # Copy the NixOS configuration file and link it from the resulting system
  # (/run/current-system/configuration.nix). This is useful in case you
  # accidentally delete configuration.nix.
  # system.copySystemConfiguration = true;

  # This option defines the first version of NixOS you have installed on this particular machine,
  # and is used to maintain compatibility with application data (e.g. databases) created on older NixOS versions.
  #
  # Most users should NEVER change this value after the initial install, for any reason,
  # even if you've upgraded your system to a new NixOS release.
  #
  # This value does NOT affect the Nixpkgs version your packages and OS are pulled from,
  # so changing it will NOT upgrade your system - see https://nixos.org/manual/nixos/stable/#sec-upgrading for how
  # to actually do that.
  #
  # This value being lower than the current NixOS release does NOT mean your system is
  # out of date, out of support, or vulnerable.
  #
  # Do NOT change this value unless you have manually inspected all the changes it would make to your configuration,
  # and migrated your data accordingly.
  #
  # For more information, see `man configuration.nix` or https://nixos.org/manual/nixos/stable/options#opt-system.stateVersion .
  #   home-manager.users.Pulsar = { pkgs, ... }: {
  #     home.stateVersion = "25.11";
  #     home.packages = [ ] ;
  #     };
  system.stateVersion = "25.11"; # Did you read the comment?

}
