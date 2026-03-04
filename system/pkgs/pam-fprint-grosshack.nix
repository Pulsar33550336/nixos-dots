{ lib
, stdenv
, fetchFromGitLab
, meson
, ninja
, pkg-config
, fprintd
, glib
, libfprint
, polkit
, dbus
, dbus-glib
, systemd
, pam
, python3
, libpam-wrapper
, # 注意：在 Nixpkgs 中，正确的包名是 python3Packages，而不是 pam_wrapper
  python3Packages
}:

stdenv.mkDerivation rec {
  pname = "pam-fprint-grosshack";
  version = "0.3.0";

  src = fetchFromGitLab {
    domain = "gitlab.com";
    owner = "mishakmak";
    repo = "pam-fprint-grosshack";
    rev = "v${version}";
    hash = "sha256-obczZbf/oH4xGaVvp3y3ZyDdYhZnxlCWvL0irgEYIi0=";  # 先用fake hash，构建时会提示正确的hash
  };

  nativeBuildInputs = [
    meson
    ninja
    pkg-config
    python3Packages.python  # 需要python来运行测试
  ];

  buildInputs = [
    fprintd
    glib
    libfprint
    polkit
    dbus
    dbus-glib
    systemd
    pam
    python3
    python3Packages.pycairo
    python3Packages.dbus-python  # 注意包名是 dbus-python，不是 python-dbus
    python3Packages.python-dbusmock
    libpam-wrapper  # pam_wrapper 在 python3Packages 中
  ];

  mesonFlags = [
    "-D pam_modules_dir=${placeholder "out"}/lib/security"
  ];

  # 如果测试需要python依赖，设置pythonPath
  pythonPath = with python3Packages; [
    pycairo
    dbus-python
    python-dbusmock
    libpam-wrapper
  ];

  # 跳过测试（可选，如果测试有依赖问题）
  # doCheck = false;

  meta = with lib; {
    description = "PAM module enabling simultaneous fingerprint (fprintd) and password authentication";
    homepage = "https://fprint.freedesktop.org/";
    license = licenses.gpl2Plus;
    maintainers = with maintainers; [ ];
    platforms = platforms.linux;
  };
}