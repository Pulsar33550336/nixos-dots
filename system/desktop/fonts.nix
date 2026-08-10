{ pkgs, ... }:
{
  # 使用非 VF 字体
  nixpkgs.overlays = [
    (self: super: {
      noto-fonts-cjk-sans = super.noto-fonts-cjk-sans.override {
        static = true;
      };
      noto-fonts-cjk-serif = super.noto-fonts-cjk-serif.override {
        static = true;
      };
    })
  ];

  fonts = {
    packages = with pkgs; [
      noto-fonts
      noto-fonts-cjk-sans
      noto-fonts-cjk-serif
      rubik

      # 等宽字体
      nerd-fonts.ubuntu
      nerd-fonts.jetbrains-mono
      maple-mono.NormalNL-NF-CN
    ];
    fontconfig = {
      defaultFonts = {
        sansSerif = [ "Noto Sans CJK SC" ];
        serif = [ "Noto Serif CJK SC" ];
        monospace = [ "Maple Mono Normal NL NF CN" ];
      };
    };
  };
}
