{ pkgs, ... }:

{
  # Bộ công cụ phát triển cần thiết cho Tauri v2, Rust và Frontend
  packages = with pkgs; [
    # Rust toolchain
    rustc
    cargo
    clippy
    rustfmt
    rust-analyzer

    # Node.js toolchain
    nodejs_22
    pnpm

    # Native dependencies cho Tauri v2 & WebKitGTK trên Linux
    pkg-config
    dbus
    openssl
    glib
    gtk3
    webkitgtk_4_1
    libsoup_3
    libappindicator-gtk3
    librsvg
  ];

  env = {
    RUST_BACKTRACE = "1";
    # Biến môi trường hỗ trợ WebKitGTK chạy mượt trên card đồ họa kết hợp
    WEBKIT_DISABLE_COMPOSITING_MODE = "0";
  };

  scripts = {
    check-all.exec = ''
      echo "-> Kiểm tra Rust code..."
      cargo clippy -- -D warnings
      echo "-> Kiểm tra Frontend..."
      pnpm run check
    '';

    dev.exec = ''
      echo "-> Khởi chạy môi trường Dev Bam Notes..."
      pnpm tauri dev
    '';
  };
}
