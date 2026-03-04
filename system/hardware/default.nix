{ config, pkgs, ... }:

let
  pam-fprint-grosshack = pkgs.callPackage ../pkgs/pam-fprint-grosshack.nix { };
in
{
  imports = [
    ./hardware-configuration.nix
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

  security.pam.services = {
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
    kde-fingerprint.fprintAuth = true;

    noctalia-shell = {
      rules.auth = {
        fprintd = {
          order = 0;
          control = "sufficient";
          modulePath = "${pkgs.fprintd}/lib/security/pam_fprintd.so";
          args = [ "max-tries=5" ];
        };
      };
    };

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
