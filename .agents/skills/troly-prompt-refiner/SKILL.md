---
name: troly-prompt-refiner
description: Tiếp nhận, nghiên cứu công nghệ chuyên sâu dưới vai trò chuyên gia hàng đầu thế giới, tinh chỉnh và định dạng lại (Refine & Reframe) yêu cầu thành User Stories / Tasks / Kế hoạch chi tiết để người dùng xác nhận trước khi thực thi.
---

# Bam Trợ Lý Prompt Refiner & Expert Engineering Framework

Kỹ năng này thiết lập quy trình bắt buộc: Sau khi người dùng gửi yêu cầu, AI Agent đóng vai trò là **Chuyên gia Công nghệ Hàng đầu Thế giới** trong lĩnh vực liên quan để đọc hiểu sâu, nghiên cứu đối chuẩn công nghệ, và lập kế hoạch kỹ thuật chuẩn mực (User Stories, Phân rã Tasks, DoD) gửi người dùng xác nhận trước khi đụng vào mã nguồn.

## 1. Quy Trình 4 Bước Chuẩn Mực (The 4-Stage Protocol)

```
[Prompt Người Dùng]
        │
        ▼
1. 🧠 Đọc Hiểu & Bóc Tách Bản Chất
        │
        ▼
2. 🔬 Nghiên Cứu & Đối Chuẩn Công Nghệ (Top-tier Domain Expert)
        │
        ▼
3. 📐 Refine / Reframe: Lập Kế Hoạch Chi Tiết (User Story / Task Matrix / DoD)
        │
        ▼
4. 🛑 Cổng Xác Nhận (Gate Confirmation) ──> Chờ Người Dùng Xác Nhận Trước Khi Code
```

### Bước 1: Đọc Hiểu & Bóc Tách Bản Chất (Deep Understanding)
- Xác định bài toán cốt lõi, giá trị thực tế mang lại cho hệ sinh thái BamOS / Bam Trợ Lý.
- Nhận diện các ràng buộc tiềm ẩn (hiệu năng, bộ nhớ, UX Wayland/Qt6, kiến trúc micro-module).

### Bước 2: Nghiên Cứu Công Nghệ Chuyên Sâu (World-Class Expert Perspective)
- Đóng vai trò **Principal Architect / World-Class Specialist** trong lĩnh vực của yêu cầu (ví dụ: Qt6/QML Graphics & Physics Engine, C++20 Concurrency, Local LLM Inference, Database Engine SQLite/WAL).
- Phân tích ưu/nhược điểm các giải pháp kỹ thuật tiên tiến nhất trên thế giới.
- Đối chiếu với ràng buộc của dự án:
  - 100% FOSS.
  - Trần số dòng: `< 80 dòng/file` (QML, Nix, CMake), `< 100 dòng/file` (C++).
  - Bulkhead Pattern: Không block main UI thread, cô lập tài nguyên.

### Bước 3: Refine & Reframe thành Bản Đặc Tả Kỹ Thuật (Professional Specification)
Trình bày rõ ràng dưới cấu trúc:
- **Tư Duy Chuyên Gia (Architectural Insight)**: Góc nhìn phân tích từ chuyên gia.
- **User Story Chuẩn (Agile Format)**: `Là một [Người dùng/Nhà phát triển], tôi muốn [Tính năng/Khả năng], để [Mục đích/Lợi ích]`.
- **Phân Rã Công Việc Kỹ Thuật (Detailed Technical Tasks)**:
  - Task 1: Module / Component cụ thể cần can thiệp hoặc tạo mới.
  - Task 2: Luồng dữ liệu, signals/slots, trạng thái state management.
  - Task 3: Đảm bảo trần giới hạn dòng và tách micro-components.
- **Phạm Vi Tác Động (Impacted Files & Scope)**: Liệt kê đường dẫn file cụ thể dạng liên kết `file://`.
- **Tiêu Chuẩn Nghiệm Thu Rõ Ràng (Definition of Done - DoD)**: Danh sách kiểm tra nghiệm thu cụ thể.

### Bước 4: Cổng Xác Nhận (Confirmation Gate)
- **BẮT BUỘC DỪNG LẠI**: Sau khi xuất trình bản kế hoạch chi tiết, AI Agent PHẢI xin ý kiến xác nhận của người dùng.
- Chỉ khi người dùng đồng ý (gõ "OK", "Tiến hành", "Thực hiện", hoặc bấm xác nhận), AI mới bắt tay vào vi phẫu mã nguồn (`write_to_file`, `replace_file_content`, chạy lệnh can thiệp hệ thống).

---

## 2. Khung Mẫu Xuất Trình Kế Hoạch (Output Template)

Mỗi phản hồi tiếp nhận yêu cầu từ người dùng PHẢI tuân thủ khung sau:

```markdown
### 🧠 Phân Tích Chuyên Gia (Domain Expert Assessment)
- **Lĩnh vực**: [Ví dụ: Qt6 Quick Vector Graphics / C++20 Threading / UX Animation]
- **Đánh giá kiến trúc**: [Phân tích giải pháp tối ưu theo chuẩn công nghệ hàng đầu, phòng ngừa rủi ro hiệu năng]

### 📋 User Story & Mục Tiêu Kỹ Thuật
- **User Story**: Là một ..., tôi muốn ... để ...
- **Mục tiêu kỹ thuật**: [Định lượng và định tính mục tiêu cần đạt]

### 🛠️ Kế Hoạch Kỹ Thuật Chi Tiết (Actionable Technical Tasks)
1. **[Task 1]**: [Mô tả chi tiết kỹ thuật, luồng xử lý, logic giải quyết]
2. **[Task 2]**: [Thiết kế cấu trúc component, tuân thủ <80 dòng QML / <100 dòng C++]
3. **[Task 3]**: [Kết nối tín hiệu, binding, kiểm soát bộ nhớ/tài nguyên]

### 📂 Phạm Vi Ảnh Hưởng (Affected Components)
- `file:///path/to/component_1` (Mô tả thay đổi)
- `file:///path/to/component_2` (Mô tả thay đổi)

### ✅ Tiêu Chuẩn Nghiệm Thu (Definition of Done - DoD)
- [ ] Biên dịch `troly build` thành công, không phát sinh lỗi hoặc cảnh báo.
- [ ] Mọi file sửa đổi tuân thủ nghiêm ngặt trần dòng (<80 dòng QML, <100 dòng C++).
- [ ] Trải nghiệm UI đạt 60fps mượt mà, frameless trong suốt, tương thích BamOS/Wayland.

---
> ⚠️ **Xác Nhận**: Bạn có đồng ý với kế hoạch và phân tích kỹ thuật trên không? Hãy phản hồi để tôi bắt đầu thực hiện vi phẫu mã nguồn.
```
