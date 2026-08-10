{ pkgs, ... }: {
  environment.systemPackages = with pkgs; [
    llvmPackages_22.clang
    llvmPackages_22.clang-tools
  ];
}
