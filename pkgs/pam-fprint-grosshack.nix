{
  lib,
  stdenv,
  fetchFromGitLab,
  meson,
  ninja,
  pkg-config,
  fprintd,
  glib,
  libfprint,
  polkit,
  dbus,
  dbus-glib,
  systemd,
  pam,
  python3,
  libpam-wrapper,
  python3Packages,
}:

stdenv.mkDerivation rec {
  pname = "pam-fprint-grosshack";
  version = "0.3.0";

  src = fetchFromGitLab {
    domain = "gitlab.com";
    owner = "mishakmak";
    repo = "pam-fprint-grosshack";
    rev = "v${version}";
    hash = "sha256-obczZbf/oH4xGaVvp3y3ZyDdYhZnxlCWvL0irgEYIi0=";
  };

  nativeBuildInputs = [
    meson
    ninja
    pkg-config
    python3Packages.python
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
    python3Packages.dbus-python
    python3Packages.python-dbusmock
    libpam-wrapper
  ];

  mesonFlags = [
    "-D pam_modules_dir=${placeholder "out"}/lib/security"
  ];

  pythonPath = with python3Packages; [
    pycairo
    dbus-python
    python-dbusmock
    libpam-wrapper
  ];

  meta = with lib; {
    description = "PAM module enabling simultaneous fingerprint (fprintd) and password authentication";
    homepage = "https://fprint.freedesktop.org/";
    license = licenses.gpl2Plus;
    maintainers = # with maintainers;
      [ ];
    platforms = platforms.linux;
  };
}
