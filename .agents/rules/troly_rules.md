# Bam Trợ Lý Agent Rules & Conventions

Quy tắc bắt buộc dành cho mọi AI Agent (Gemini, Claude, GPT, Antigravity, Cursor, Zed) khi làm việc trong dự án **bam-troly**:

## 1. Cơ Chế Bắt Buộc: Prompt Refinement & Chuyên Gia Đối Chuẩn
Khi nhận được yêu cầu từ người dùng:
1. **Đọc hiểu & Phân tích chuyên sâu (Top-tier Domain Expert)**:
   - Nghiên cứu công nghệ, đối chuẩn giải pháp tối ưu theo chuẩn quốc tế.
2. **Refine & Reframe thành Kế hoạch chi tiết**:
   - Chuyển hóa yêu cầu thành User Story chuẩn mực, phân rã danh sách Tasks kỹ thuật, làm rõ phạm vi (Scope) và tiêu chí nghiệm thu (DoD).
3. **Cổng Xác Nhận Bắt Buộc (Confirmation Gate)**:
   - Xuất trình bản kế hoạch chi tiết và xin ý kiến xác nhận của người dùng.
   - CHỈ bắt đầu sửa đổi mã nguồn sau khi người dùng đồng ý.

## 2. Giới Hạn Dòng Mã Nguồn (Strict File Line Ceiling)
- **File Nix, QML, CMake**: Tối đa **< 80 dòng/file**. Khi đạt ~70 dòng, chủ động tách component con.
- **File C++ (`.hpp`, `.cpp`)**: Tối đa **< 100 dòng/file**. Tách nhỏ class, helpers, workers.
- **Tuyệt đối không gộp**: Giữ nguyên tính độc lập của từng bộ phận (Parts, Behaviors, Views, Controllers).

## 3. Bản Quyền & Triết Lý Phần Mềm Tự Do (Strict 100% FOSS)
- Chỉ sử dụng các thư viện, component, fonts có giấy phép mã nguồn mở tự do (MIT, LGPLv3, Apache-2.0, SIL OFL).
- Không đưa vào bất kỳ dependency thương mại hoặc đóng mã nguồn nào.

## 4. UI Invariants & Bulkhead Architecture
- Cửa sổ trong suốt, frameless, `Qt.WindowStaysOnTopHint`.
- Kéo thả tự do qua `DragHandler` + `startSystemMove()`.
- Tách biệt luồng AI inference (`llama.cpp`) sang background thread (`std::jthread`), truyền dữ liệu về UI qua Qt Signal/Slot (`Qt::QueuedConnection`) để UI luôn mượt mà 60fps.

## 5. Thao Tác Thư Viện & Tiết Kiệm Token (Token Conservation)
- Sử dụng `grep_search` và `view_file` có dòng bắt đầu/kết thúc (`StartLine`/`EndLine`).
- Không quét hoặc mở các thư mục cấm: `build/`, `.direnv/`, `.devenv/`, model `.gguf`, database `.db`.
- Dùng `replace_file_content` hoặc `multi_replace_file_content` cho các chỉnh sửa vi phẫu (surgical edits).
