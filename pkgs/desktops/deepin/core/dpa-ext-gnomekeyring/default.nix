{
  stdenv,
  lib,
  fetchFromGitHub,
  cmake,
  pkg-config,
  libsForQt5,
  dtkwidget,
  dde-polkit-agent,
  qt5integration,
  libsecret,
}:

stdenv.mkDerivation rec {
  pname = "dpa-ext-gnomekeyring";
  version = "6.0.1";

  src = fetchFromGitHub {
    owner = "linuxdeepin";
    repo = pname;
    rev = version;
    hash = "sha256-SyoahSdGPkWitDek4RD5M2hTR78GFpuijryteKVAx6k=";
  };

  postPatch = ''
    substituteInPlace gnomekeyringextention.cpp \
      --replace "/usr/share/dpa-ext-gnomekeyring" "$out/share/dpa-ext-gnomekeyring"
  '';

  nativeBuildInputs = [
    cmake
    pkg-config
    libsForQt5.qttools
    libsForQt5.wrapQtAppsHook
  ];

  buildInputs = [
    dtkwidget
    dde-polkit-agent
    qt5integration
    libsecret
  ];

  meta = with lib; {
    description = "GNOME keyring extension for dde-polkit-agent";
    homepage = "https://github.com/linuxdeepin/dpa-ext-gnomekeyring";
    license = licenses.gpl3Plus;
    platforms = platforms.linux;
    teams = [ teams.deepin ];
  };
}
