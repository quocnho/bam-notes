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

### [IDEA-BAM-TROLY-20261002-03] Tự Động Mở Rộng Và Focus Input Khi Click Bubble
- **Thời gian tiếp nhận:** 2026-10-02 21:32
- **Mô tả:** Khi click vào bong bóng nổi (Floating Bubble), kích hoạt mở rộng cửa sổ chat (400x580) đồng thời tự động kích hoạt `forceActiveFocus()` vào ô `TextInput` trong `PromptInput` để người dùng có thể gõ ngay lập tức trên bàn phím.
- **Mục tiêu:** Tối ưu luồng tương tác UX, cho phép gõ phím tức thì không cần click chuột lần hai.
- **Subsystem liên quan:** `ui` (Main.qml, ChatWindow.qml, PromptInput.qml).

### [IDEA-BAM-TROLY-20261002-04] Bổ Sung Context Menu Chuột Phải Cho Trợ Lý (Quick Actions & Quit)
- **Thời gian tiếp nhận:** 2026-10-02 21:40
- **Mô tả:** Bổ sung tương tác chuột phải (Right-click) vào biểu tượng bong bóng trợ lý hoặc header để hiển thị menu ngữ cảnh nổi. Cung cấp các thao tác hệ thống nhanh: Mở/thu gọn chat, Xóa lịch sử hội thoại, Khởi động lại trợ lý, và Thoát hoàn toàn ứng dụng (`Qt.quit()`).
- **Mục tiêu:** Cung cấp khả năng kiểm soát và thoát ứng dụng nhanh chóng, tiện dụng cho người dùng.
- **Subsystem liên quan:** `ui` (components/ContextMenu.qml, FloatingBubble.qml, ChatHeader.qml, Main.qml).

### [IDEA-BAM-TROLY-20261002-05] Thêm Nút Thu Nhỏ (-) & Hộp Thoại Xác Nhận Đóng Kèm Tùy Chọn Xóa Chat
- **Thời gian tiếp nhận:** 2026-10-02 22:05
- **Mô tả:** Bỏ hoàn toàn menu chuột phải (Right-click). Thêm nút thu nhỏ (`−`) cạnh nút đóng (`✕`) trên Header để co về bong bóng tròn (72x72). Khi bấm nút đóng (`✕`), hiển thị hộp thoại xác nhận: "Bạn có muốn xóa dữ liệu đoạn chat trước khi đóng không?" với các tùy chọn Có (Xóa và đóng), Không (Giữ và đóng), và Hủy (tiếp tục sử dụng).
- **Mục tiêu:** Trực quan hóa thao tác điều khiển cửa sổ và bảo vệ an toàn dữ liệu hội thoại của người dùng.
- **Subsystem liên quan:** `ui` (ChatHeader.qml, FloatingBubble.qml, ConfirmDialog.qml, ChatWindow.qml, Main.qml).




