# Bam Trợ Lý (bam-troly) Architecture & Context Map

> **Dành cho AI Assistants (Gemini, Claude, GPT, Antigravity, Cursor, Zed):**
> Đọc tài liệu này trước để định tuyến trực tiếp đến đúng file cần sửa.
> Tuân thủ nghiêm ngặt mô hình **Clean Architecture & Atomic Micro-Modules (< 80 dòng/file QML/Nix, < 100 dòng/file C++)**.

## 1. Directory Structure Map (Clean Architecture)

```text
bam-troly/
├── devenv.nix                        # Môi trường Nix (C++20, Qt6, CMake, llama-cpp) (< 40 dòng)
├── CMakeLists.txt                    # Build configuration C++20 / Qt6 (< 50 dòng)
├── AGENTS.md                         # Bản đồ kiến trúc & quy tắc AI Agent
├── README.md                         # Tổng quan dự án & hướng dẫn chạy
├── bk_idea.md                        # Lịch sử ý tưởng đã chuẩn hóa
├── idea.md                           # Quick Idea Capture
├── src/
│   ├── main.cpp                      # Khởi tạo QGuiApplication & QML Engine (< 40 dòng)
│   ├── core/                         # Domain Layer: Thực thể & Kiểu dữ liệu
│   │   ├── types.hpp                 # MessageRole, AgentStatus (< 30 dòng)
│   │   └── message.hpp               # Message struct entity (< 30 dòng)
│   ├── workflow/                     # Use Cases Layer: Quy trình & Hành vi
│   │   ├── agent_workflow.hpp        # ReAct Pipeline interface (< 40 dòng)
│   │   └── agent_workflow.cpp        # Điều phối Reasoning, Tool Call, Reply (< 45 dòng)
│   ├── plugins/                      # Plugins Layer: Mở rộng hành vi & Công cụ
│   │   ├── plugin_interface.hpp      # IAgentTool interface (< 20 dòng)
│   │   ├── tool_registry.hpp         # ToolRegistry header (< 30 dòng)
│   │   ├── tool_registry.cpp         # Quản lý & gọi tools (< 40 dòng)
│   │   └── builtins/                 # Các tools mặc định (System, Memory)
│   ├── modules/                      # Infrastructure Layer: Modules kỹ thuật
│   │   ├── ai/                       # AI Engine & Providers
│   │   │   ├── ai_provider.hpp       # IAIProvider interface (< 25 dòng)
│   │   │   ├── llama_engine.hpp      # llama.cpp RAII header (< 30 dòng)
│   │   │   └── llama_engine.cpp      # llama.cpp worker thread (< 60 dòng)
│   │   └── storage/                  # Lưu trữ CSDL
│   │       ├── db_manager.hpp        # SQLite3 WAL + FTS5 header (< 30 dòng)
│   │       └── db_manager.cpp        # SQLite3 queries & mutations (< 75 dòng)
│   └── presentation/                 # Presentation Layer: Controllers & ViewModel
│       ├── app_controller.hpp        # Qt ViewModel kết nối QML <-> Workflow (< 40 dòng)
│       └── app_controller.cpp        # Signals/slots & UI handlers (< 60 dòng)
└── qml/                              # UI Layer: Qt6 Quick (QML)
    ├── Main.qml                      # Cửa sổ trong suốt, Frameless, DragHandler (< 50 dòng)
    ├── components/                   # UI Micro-Components
    │   ├── FloatingBubble.qml        # Bong bóng tròn nổi 72x72 kéo thả (< 40 dòng)
    │   └── StatusIndicator.qml       # Đèn trạng thái AI Idle/Streaming (< 20 dòng)
    └── views/                        # View Panels
        ├── ChatWindow.qml            # Khung chat nổi 400x580 (< 75 dòng)
        ├── MessageList.qml           # Danh sách tin nhắn streaming (< 55 dòng)
        └── PromptInput.qml           # Ô nhập liệu và nút gửi/dừng (< 45 dòng)
```

## 2. Token Saving Guidelines for AI
- **Targeted Reading**: Sử dụng `grep_search` và `view_file` với `StartLine`/`EndLine` cụ thể. Không quét toàn bộ repo.
- **Targeted Edits**: Ưu tiên sử dụng `replace_file_content` hoặc `multi_replace_file_content`.
- **Tuyệt đối không đọc**: `build/`, `.direnv/`, `.devenv/`, file nhị phân, model file `.gguf`.

## 3. Clean Architecture & Micro-Modules Rules
- **Ngưỡng trần giới hạn dòng (Strict Ceiling)**:
  - Mọi file Nix, QML, CMake: **TỐI ĐA < 80 dòng/file**. Khi đạt ~70 dòng, tách component nhỏ.
  - Mọi file mã nguồn C++ (`.hpp`, `.cpp`): **TỐI ĐA < 100 dòng/file**.
- **Strict FOSS & No Commercial License (100% Tự do)**:
  - Toàn bộ dependencies C++ và Qt6 đều phải là FOSS (LGPLv3, MIT, Apache-2.0).

## 4. UI & Floating Agent Invariants
- **Frameless, Transparent & Drag-and-Drop**:
  - Giao diện KHÔNG phải là cửa sổ thông thường: Nền trong suốt (`color: "transparent"`), không viền, `Qt.WindowStaysOnTopHint`.
  - Hỗ trợ kéo thả tự do trên cả Wayland (Linux/BamOS) và Windows qua `DragHandler` + `startSystemMove()`.
  - Tự động co giãn mượt mà: Bong bóng chờ (72x72) <--> Khung chat / thông báo (400x580).
- **OpenClaw Agent Pattern & Local RAG**:
  - ReAct Workflow (Reasoning ➔ Acting ➔ Tool Execution ➔ Synthesis).
  - RAG cục bộ bằng SQLite3 WAL + FTS5 & `sqlite-vec` (384 dimensions).
- **Bulkhead Pattern (Cô lập tài nguyên)**:
  - Tách hoàn toàn việc suy luận AI (`llama.cpp`) sang luồng nền (`std::jthread`).
  - Truyền token streaming qua Qt Signal/Slot (`Qt::QueuedConnection`) để UI luôn mượt 60fps.

## 5. Versioning Standard (`AA.BB.CC`) & Git Workflow
- **Định dạng**: `AA.BB.CC` (ví dụ năm 2026 -> `v26.01.01`).
- **Nhánh Git**: `develop` (dev chính), `main` (release có Git tag).
- **Commit Standard**: Conventional Commits (`feat(...)`, `fix(...)`, `refactor(...)`, `perf(...)`, `chore(...)`).
- **Zero Bloat Invariant**: Không bao giờ commit `build/`, `*.gguf`, `*.db`, `.direnv`, `.devenv`.
