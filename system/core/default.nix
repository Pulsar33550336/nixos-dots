{
  ...
}:

{

  imports = [
    ./boot.nix
    ./nix.nix
    ./ssh.nix
    ./sudo.nix
  ];

  system.stateVersion = "25.11";
}
