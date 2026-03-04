{ config, pkgs, ... }:

{
  programs.git = {
    enable = true;
    userName = "Pulsar33550336";
    userEmail = "pulsar33550336@163.com";
    signing = {
      key = "2B867C4832784EE0";
      signByDefault = true;
    };
    extraConfig = {
      core = {
        autocrlf = "input";
      };
      init = {
        defaultBranch = "master";
      };
      tag = {
        gpgSign = false;
      };
    };
  };

  programs.gpg = {
    enable = true;
  };

  services.gpg-agent = {
    enable = true;
    pinentryPackage = pkgs.pinentry-gtk2;
  };
}
