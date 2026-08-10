{ pkgs, ... }: {
  environment.systemPackages = with pkgs; [
    gdb
    valgrind
  ];
}
