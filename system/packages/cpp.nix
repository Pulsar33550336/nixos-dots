{ pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    gcc
    clang
    gdb
    cmake
    ninja
    meson
    valgrind
    cppcheck
    clang-tools
  ];
}
