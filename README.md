# Bam Trợ Lý (bam-troly)

Ứng dụng Trợ lý AI Native chạy độc lập dưới dạng đối tượng nổi trong suốt (Frameless, Transparent Floating Widget), Always-on-Top, kéo thả tự do trên **BamOS (Wayland)** và **Windows**.
Hỗ trợ cả 2 chế độ: **Bản Lite Offline** (nhúng trực tiếp `llama.cpp` + SQLite RAG) và **Bản Enterprise Client** (kết nối đồng bộ với hệ thống `troly.info`).

## 1. Công nghệ cốt lõi
- **Ngôn ngữ**: C++20 (CMake >= 3.24, Ninja).
- **Giao diện**: Qt6 Quick / QML (Nền trong suốt, không viền, `DragHandler` kéo thả tự do, tự động focus input khi mở).
- **AI Agent**: Kiến trúc ReAct (OpenClaw-like pattern: Reasoning ➔ Acting ➔ Tool Call ➔ Reply).
- **Edge AI**: `llama.cpp` nhúng trực tiếp in-process, chạy các mô hình GGUF offline 100%.
- **Lưu trữ & RAG**: SQLite3 WAL mode + FTS5 & `sqlite-vec` (384 dimensions).
- **Kiến trúc**: Clean Architecture & Atomic Micro-Modules (< 80 dòng/file QML/Nix, < 100 dòng/file C++).

## 2. Phát triển & Biên dịch Cục bộ (devenv)
Sử dụng môi trường Nix thông qua `direnv` hoặc `devenv`:

```bash
# 1. Kích hoạt môi trường (chỉ cần chạy 1 lần)
direnv allow   # hoặc: devenv shell

# 2. Biên dịch dự án
troly build

# 3. Khởi chạy thử nghiệm
troly run

# 4. Dọn dẹp bản build
troly clean
```

> **Cách biên dịch thủ công (bằng CMake):**
> ```bash
> cmake -B build -G Ninja -DCMAKE_BUILD_TYPE=Release
> cmake --build build
> ./build/bam-troly
> ```

## 3. Đóng gói & Triển khai trên BamOS / NixOS
Dự án cung cấp sẵn tệp đặc tả [package.nix](file:///home/quocnho/Projects/Bam/BamApps/bam-troly/package.nix) để tích hợp vào Flake của BamOS (`/etc/nixos/flake.nix`):

```nix
# Trong cấu hình Flake hoặc overlay của BamOS:
bam-troly = pkgs.callPackage ./package.nix { };
```

Khi cài đặt qua Nix derivation, ứng dụng sẽ tự động sinh file desktop entry tại `/share/applications/bam-troly.desktop` và có thể tìm kiếm, khởi chạy trực tiếp từ GNOME App Grid.

## 4. Thao tác Người Dùng & Phím Tắt
- **Mở rộng chat**: Click chuột trái vào bong bóng 🤖.
- **Tự động Focus**: Con trỏ phím tự động kích hoạt vào ô nhập liệu để bắt đầu gõ lệnh/chat ngay lập tức.
- **Kéo thả tự do**: Kéo bong bóng hoặc thanh header đến bất kỳ vị trí nào trên màn hình.
- **Nút Thu nhỏ (`−`)**: Click vào nút `−` trên thanh Header để thu gọn khung chat về lại bong bóng tròn (72x72).
- **Nút Đóng (`✕`) & Xác nhận**: Click vào nút `✕` trên thanh Header sẽ mở hộp thoại xác nhận:
  - **Có (Xóa)**: Xóa sạch dữ liệu lịch sử hội thoại và thoát ứng dụng.
  - **Không (Giữ)**: Giữ nguyên lịch sử hội thoại và thoát ứng dụng.
  - **Hủy**: Đóng hộp thoại và tiếp tục sử dụng trợ lý.
