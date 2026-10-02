{ pkgs, ... }:

{
  languages.cplusplus.enable = true;

  packages = with pkgs; [
    cmake
    ninja
    pkg-config
    gcc14
    gdb

    # Qt6 Framework
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
}
