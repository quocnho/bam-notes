# 📦 Archive of Accepted Ideas (bk_idea.md) - Bam Trợ Lý

Lưu trữ lịch sử các ý tưởng đã được người dùng xác nhận cho dự án **bam-troly**.

---

## Lịch Sử Ý Tưởng Đã Tiếp Nhận

### [IDEA-BAM-TROLY-20261002-01] Kiến trúc Bam Trợ Lý C++20 / Qt6 Quick & Local AI llama.cpp
- **Thời gian tiếp nhận:** 2026-10-02 13:25
- **Mô tả:** Chuyển đổi ứng dụng từ nền tảng cũ sang Native C++20 + Qt6 Quick (QML) dạng bong bóng nổi (Floating Bubble) neo góc dưới bên phải màn hình. Nhúng trực tiếp thư viện `llama.cpp` để chạy mô hình AI SLM (GGUF) offline 100%, lưu trữ lịch sử bằng SQLite3 WAL + FTS5, tuân thủ nguyên tắc Micro-Modules (< 80 dòng QML, < 100 dòng C++).
- **Mục tiêu:** Trợ lý ảo native siêu nhẹ, hiệu năng cao, phản hồi streaming tức thì không giật lag giao diện, tích hợp trực tiếp vào BamOS.
- **Subsystem liên quan:** `ui` (QML Bubble & ChatWindow), `ai` (llama.cpp engine & worker thread), `storage` (SQLite3 db manager).

### [IDEA-BAM-TROLY-20261002-02] Thống Nhất Công Nghệ C++20 / Qt6 Quick & OpenClaw Agent / RAG Cho Cả 2 Dự Án
- **Thời gian tiếp nhận:** 2026-10-02 20:55
- **Mô tả:** Thống nhất công nghệ trên cả `bam-troly` và `troly/app/desktop` sang C++20 và Qt6 Quick (QML). Giao diện là đối tượng nổi trong suốt (Frameless, Transparent), Always-on-top, kéo thả tự do bằng `DragHandler` native trên cả Linux Wayland và Windows DWM. Tích hợp AI Agent theo mô hình ReAct (OpenClaw-like) và Local RAG (`sqlite-vec` + SQLite3 FTS5). Hỗ trợ song song Bản Lite (Offline in-process) và Bản Enterprise (Đồng bộ cổng :8088 / :8080 của troly.info).
- **Mục tiêu:** Trải nghiệm trợ lý ảo bay bổng, không viền cửa sổ, mượt mà trên mọi nền tảng, phản ứng thông minh với sự kiện hệ thống.
- **Subsystem liên quan:** `ui` (Transparent Drag Window), `ai` (OpenClaw ReAct runner), `core` (Hybrid Provider & Network Sync).

