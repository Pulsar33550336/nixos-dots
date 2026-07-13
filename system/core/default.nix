{
  ...
}:

{

  imports = [
    ./boot.nix
    ./nix.nix
    ./ssh.nix
    ./sudo.nix
    ./kernel.nix
  ];

  system.stateVersion = "25.11";
}
