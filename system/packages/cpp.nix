{ pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    gcc
    llvmPackages_22.clang
    gdb
    cmake
    ninja
    meson
    valgrind
    cppcheck
    llvmPackages_22.clang-tools
  ];
}
