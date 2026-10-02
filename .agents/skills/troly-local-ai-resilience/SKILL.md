---
name: troly-local-ai-resilience
description: Mẫu kiến trúc cách ly luồng suy luận Local AI (llama.cpp) bằng std::jthread, non-blocking UI Qt6, streaming token và kiểm soát tài nguyên VRAM/RAM.
---

# Bam Trợ Lý Local AI & Inference Resilience Skill

Sử dụng skill này khi phát triển, tối ưu hoặc gỡ lỗi tầng suy luận AI (`src/ai/`), Controller (`src/app_controller.*`), và giao tiếp QML:

## 1. 4 Mẫu Kiến Trúc Bền Vững (Resilience Patterns)

### A. Bulkhead Pattern (Khoang Ngăn Cô Lập Luồng)
- **Vấn đề**: Việc suy luận LLM/SLM tiêu tốn 100% CPU/GPU gây đông cứng (freeze) giao diện Qt/QML.
- **Giải pháp**:
  - Không bao giờ gọi `llama_decode` hoặc tạo token trên GUI Thread (Main Thread).
  - Tách hoàn toàn việc suy luận sang luồng riêng (`std::jthread`).
  - Giao tiếp giữa Engine C++ và QML bắt buộc thông qua Qt Signal-Slot (`Qt::QueuedConnection`).

### B. Cooperative Interruption (Dừng Suy Luận Tức Thì)
- **Vấn đề**: Người dùng bấm dừng hoặc đóng cửa sổ chat khi model đang sinh văn bản.
- **Giải pháp**:
  - Sử dụng cờ nguyên tử `std::atomic<bool> m_stopRequested`.
  - Trong vòng lặp sinh token (`llama_engine.cpp`), kiểm tra `if (m_stopRequested.load()) break;` sau mỗi token.
  - Khi huỷ, hoàn tất RAII dọn dẹp bộ nhớ an toàn trước khi nhận prompt mới.

### C. Streaming Token Flow
- **Giải pháp**: Phát tín hiệu `tokenGenerated(QString)` ngay khi giải mã xong từng token để QML hiển thị mượt mà theo thời gian thực (real-time typing effect), sau đó mới phát `generationFinished(QString)` để lưu vào SQLite.

## 2. Tiêu Chuẩn Giới Hạn File
- File mã nguồn C++ (`.hpp`, `.cpp`) < 100 dòng.
- File QML < 80 dòng.
- Tách nhỏ: Engine, Worker, Controller, Database Manager.
