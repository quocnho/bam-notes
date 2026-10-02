{ lib
, stdenv
, cmake
, ninja
, pkg-config
, qt6
, sqlite
, llama-cpp ? null
}:

stdenv.mkDerivation {
  pname = "bam-troly";
  version = "26.01.01";
  src = lib.cleanSourceWith {
    src = ./.;
    filter = path: type:
      let baseName = baseNameOf (toString path);
      in baseName != "build" && baseName != ".direnv" && baseName != ".devenv";
  };

  nativeBuildInputs = [
    cmake
    ninja
    pkg-config
    qt6.wrapQtAppsHook
  ];

  buildInputs = [
    qt6.qtbase
    qt6.qtdeclarative
    qt6.qtwayland
    qt6.qtsvg
    sqlite
  ] ++ lib.optional (llama-cpp != null) llama-cpp;

  cmakeFlags = [
    "-DCMAKE_BUILD_TYPE=Release"
  ];

  installPhase = ''
    runHook preInstall
    install -D -m 755 bam-troly $out/bin/bam-troly
    install -D -m 644 ../data/bam-troly.desktop $out/share/applications/bam-troly.desktop
    runHook postInstall
  '';

  meta = with lib; {
    description = "Trợ lý AI Native dạng bong bóng nổi trong suốt trên BamOS";
    license = licenses.gpl3Plus;
    mainProgram = "bam-troly";
    platforms = platforms.linux;
  };
}
