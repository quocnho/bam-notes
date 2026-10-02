{ pkgs, ... }:

{
  languages.cplusplus.enable = true;

  packages = with pkgs; [
    # Build toolchain C++20 & Ninja
    cmake
    ninja
    pkg-config
    gcc14
    gdb

    # Qt6 Framework & Wayland/X11
    qt6.qtbase
    qt6.qtdeclarative
    qt6.qtwayland
    qt6.qtsvg
    qt6.qttools

    # Inference & Database
    llama-cpp
    sqlite
  ];

  env = {
    QT_QPA_PLATFORM = "wayland;xcb";
  };

  scripts = {
    "bam-troly-build".exec = ''
      cmake -B build -G Ninja -DCMAKE_BUILD_TYPE=Release
      cmake --build build
    '';
    "bam-troly-run".exec = ''
      if [ ! -f "build/bam-troly" ]; then
        bam-troly-build
      fi
      ./build/bam-troly "$@"
    '';
    "bam-troly-clean".exec = ''
      rm -rf build
      echo "✔ Đã dọn dẹp thư mục build."
    '';
  };
}
