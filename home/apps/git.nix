{ pkgs, ... }:

{
  programs.git = {
    enable = true;
    signing = {
      key = "2B867C4832784EE0";
      signByDefault = true;
    };
    settings = {
      user = {
        name = "Pulsar33550336";
        email = "pulsar33550336@163.com";
      };
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

  home.packages = with pkgs; [
    git-lfs
    git-cliff
  ];
}
