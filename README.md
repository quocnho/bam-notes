# Bam Trợ Lý (bam-troly)

Ứng dụng Trợ lý AI Native chạy độc lập dưới dạng đối tượng nổi trong suốt (Frameless, Transparent Floating Widget), Always-on-Top, kéo thả tự do trên **BamOS (Wayland)** và **Windows**.
Có khả năng hoạt động ở cả 2 chế độ: **Bản Lite Offline** (nhúng trực tiếp `llama.cpp` + SQLite RAG) và **Bản Enterprise Client** (kết nối đồng bộ với hệ thống `troly.info`).

## 1. Công nghệ cốt lõi
- **Ngôn ngữ**: C++20 (CMake >= 3.24, Ninja).
- **Giao diện**: Qt6 Quick / QML (Nền trong suốt 100%, không viền, `DragHandler` kéo thả tự do, tự động trồi lên khi có thông báo).
- **AI Agent**: Kiến trúc ReAct (OpenClaw-like pattern: Reasoning -> Acting -> Context Retriever -> Tool Call).
- **Trí tuệ nhân tạo (Local Edge AI)**: `llama.cpp` nhúng trực tiếp in-process, chạy các mô hình GGUF (Qwen2.5, Llama-3.2) offline 100%.
- **Lưu trữ & RAG**: SQLite3 WAL mode + FTS5 & `sqlite-vec` (384 dimensions).
- **Kiến trúc**: Atomic Micro-Modules (< 80 dòng/file QML/Nix, < 100 dòng/file C++).


## 2. Phát triển & Biên dịch
Sử dụng môi trường Nix / devenv:
```bash
devenv shell
cmake -B build -G Ninja
cmake --build build
./build/bam-troly
```
