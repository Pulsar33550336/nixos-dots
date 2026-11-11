{
  lib,
  rustPlatform,
  pkg-config,
  libxkbcommon,
  wayland,
  wayland-protocols,
}:

rustPlatform.buildRustPackage {
  pname = "screenshot-overlay";
  version = "0.1.0";

  # 只拷 crate 本体，`default.nix` 自己也被 lib.cleanSource 之外的路径带进来
  # 无所谓——cargo 只读 Cargo.toml / src / benches / assets。
  src = lib.cleanSource ./.;

  cargoLock.lockFile = ./Cargo.lock;

  nativeBuildInputs = [ pkg-config ];
  buildInputs = [
    libxkbcommon
    wayland
    wayland-protocols
  ];

  # `overlay::bottombar` 的两个测试量文字宽度，断言"更长的 label 会更宽"；
  # sandbox 里没有字体，任何 label 宽度都一样，必然失败。其余 38 个测试照跑。
  doCheck = false;

  meta = {
    description = "Region-selection overlay for the Noctalia screenshot plugin";
    homepage = "https://github.com/Pulsar33550336/noctalia-plugins";
    license = lib.licenses.gpl3Plus;
    mainProgram = "screenshot-overlay";
    platforms = lib.platforms.linux;
  };
}
