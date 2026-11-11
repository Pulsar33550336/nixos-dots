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

      # 顶层 poppler 同理（poppler-utils / poppler-glib 等依赖它）
      poppler = super.poppler.override {
        noto-fonts-cjk-sans = super.noto-fonts-cjk-sans;
      };

      # poppler 只是为了构建期测试在 nativeBuildInputs 里依赖
      # noto-fonts-cjk-sans，但它一被覆盖，poppler 的 drv 就变，
      # 进而 kfilemetadata → baloo → plasma-workspace 等整条 KDE 链
      # 全部换 drv、无法命中官方二进制缓存。
      # 这里把 kdePackages 里的 poppler 换回未覆盖的原版 noto（只影响
      # 构建期测试，不影响用户看到的字体），KDE 就恢复官方派生。
      kdePackages = super.kdePackages.overrideScope (
        _kfinal: kprev: {
          poppler = kprev.poppler.override {
            noto-fonts-cjk-sans = super.noto-fonts-cjk-sans;
          };
        }
      );
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

      # sth I like
      lxgw-wenkai
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
