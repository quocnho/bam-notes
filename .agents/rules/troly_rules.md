# Bam Trợ Lý Agent Rules & Conventions

Quy tắc bắt buộc dành cho mọi AI Agent (Gemini, Claude, GPT, Antigravity, Cursor, Zed) khi làm việc trong dự án **bam-troly**:

## 1. Cơ Chế Bắt Buộc: Prompt Refinement & Reframing
Khi nhận được yêu cầu từ người dùng:
1. **Tiếp nhận & Diễn đạt lại (Refine & Reframe)**:
   - Trước khi sửa mã nguồn hoặc thực thi kế hoạch phức tạp, agent PHẢI tóm tắt và làm rõ mục tiêu, phạm vi (Scope), giải pháp kỹ thuật và tiêu chí nghiệm thu (DoD).
   - Biến yêu cầu thô sơ thành bản đặc tả kỹ thuật sắc bén, chuẩn mực theo định dạng chuyên nghiệp.
2. **Không phỏng đoán mơ hồ**:
   - Khi có điểm chưa rõ về UI/UX hoặc kiến trúc, hãy đề xuất giải pháp tối ưu và hỏi ý kiến người dùng.

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
