{ pkgs, inputs, ... }:

{
  programs.gpg = {
    enable = true;
  };

  services.gpg-agent = {
    enable = true;
    pinentry.package = inputs.pinentry-kwallet.packages."${pkgs.stdenv.hostPlatform.system}".default;
  };
}
