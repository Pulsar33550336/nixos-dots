# TODO: Host-specific

{ pkgs, config, ... }:

let
  pam-fprint-grosshack = pkgs.callPackage ../../pkgs/pam-fprint-grosshack.nix { };
in
{
  imports = [
    ./hardware-configuration.nix
    ./snapper.nix
  ];

  services.pipewire = {
    enable = true;
    pulse.enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
  };

  services.power-profiles-daemon.enable = true;
  services.upower.enable = true;

  services.fprintd.enable = true;

  services.thermald.enable = true;

  hardware.bluetooth.enable = true;

  security.polkit = {
    enable = true;
    enablePkexecWrapper = true;
  };

  security.pam.services = {
    sudo.fprintAuth = config.services.fprintd.enable;
    polkit-1 = {
      fprintAuth = false;
      rules.auth = {
        fingerprint = {
          enable = config.services.fprintd.enable;
          order = 100;
          control = "sufficient";
          modulePath = "${pam-fprint-grosshack}/lib/security/pam_fprintd_grosshack.so";
        };
      };
    };
    kde-fingerprint.fprintAuth = config.services.fprintd.enable;

    login.fprintAuth = false;
    chfn.fprintAuth = false;
    chpasswd.fprintAuth = false;
    chsh.fprintAuth = false;
    groupadd.fprintAuth = false;
    groupdel.fprintAuth = false;
    groupmems.fprintAuth = false;
    groupmod.fprintAuth = false;
    kde.fprintAuth = false;
    other.fprintAuth = false;
    passwd.fprintAuth = false;
    runuser.fprintAuth = false;
    runuser-l.fprintAuth = false;
    sddm.fprintAuth = false;
    sddm-autologin.fprintAuth = false;
    sddm-greeter.fprintAuth = false;
    sshd.fprintAuth = false;
    su.fprintAuth = false;
    systemd-run0.fprintAuth = false;
    systemd-user.fprintAuth = false;
    useradd.fprintAuth = false;
    userdel.fprintAuth = false;
    usermod.fprintAuth = false;
    vlock.fprintAuth = false;
    xlock.fprintAuth = false;
  };
}
