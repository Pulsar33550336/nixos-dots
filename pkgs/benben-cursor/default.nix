{ lib, stdenvNoCC }:

stdenvNoCC.mkDerivation {
  pname = "benben-cursor";
  version = "1.0";

  # 来自「流浪地球」的笨笨鼠标指针（Windows .ani 原包 + 已转换的 Xcursor）
  src = ./BenBen;

  dontUnpack = true;

  installPhase = ''
    runHook preInstall

    mkdir -p "$out/share/icons"
    cp -a "$src" "$out/share/icons/BenBen"

    runHook postInstall
  '';

  meta = {
    description = "Benben cursor theme from The Wandering Earth (Xcursor + Windows .ani)";
    platforms = lib.platforms.linux;
  };
}
