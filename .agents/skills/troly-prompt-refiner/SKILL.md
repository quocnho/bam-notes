---
name: troly-prompt-refiner
description: Tự động tiếp nhận, phân tích, tinh chỉnh và định dạng lại (Refine & Reframe) yêu cầu của người dùng thành Prompt kỹ thuật chuyên nghiệp trước khi thực thi.
---

# Bam Trợ Lý Prompt Refiner & Task Reframing Skill

Kỹ năng này chịu trách nhiệm chuẩn hóa mọi yêu cầu thô từ người dùng thành bản đặc tả kỹ thuật (Technical Specification / Action Plan) chuẩn mực, sắc bén và tối ưu trước khi AI bắt tay vào thực hiện thay đổi mã nguồn.

## 1. Nguyên Tắc Cốt Lõi (Core Principles)
- **Không thực thi mù quáng**: Khi nhận một prompt ngắn gọn hoặc mang tính ý tưởng ("làm nút này đẹp hơn", "thêm tính năng X"), AI KHÔNG được nhảy ngay vào viết mã nguồn nếu chưa qua bước Refine & Reframe.
- **Bảo toàn ngữ cảnh Bam Trợ Lý**: Mọi phân tích phải bám sát kiến trúc C++20, Qt6 Quick/QML, SQLite RAG, và giới hạn file (<80 dòng QML, <100 dòng C++).
- **Phân tách Rõ Ràng**:
  1. *Ngữ cảnh & Mục tiêu (Context & Goal)*
  2. *Phạm vi ảnh hưởng (Impact Scope: UI/QML, C++ Core, Database, Workflow)*
  3. *Kế hoạch thực thi (Technical Implementation Plan)*
  4. *Tiêu chuẩn nghiệm thu (Definition of Done - DoD)*

## 2. Khung Mẫu Reframing (Prompt Reframing Framework)

Mỗi khi nhận yêu cầu, AI Agent chuyển đổi sang cấu trúc chuẩn:

```markdown
### 🎯 Yêu Cầu Đã Chuẩn Hóa (Refined Request)
- **Mục tiêu chính**: [Tóm tắt mục đích cụ thể bằng ngôn ngữ kỹ thuật]
- **Phạm vi tác động (Scope)**: [Danh sách file/module C++ hoặc QML bị ảnh hưởng]

### 🛠️ Kế Hoạch Kỹ Thuật (Technical Spec)
1. **Kiến trúc & Giải pháp**: [Mô tả luồng dữ liệu, signals/slots, QML component hierarchy]
2. **Tuân thủ quy chuẩn**: [Kiểm soát <80 dòng QML, <100 dòng C++, FOSS 100%]
3. **Tiêu chí nghiệm thu (DoD)**:
   - [ ] Biên dịch `troly build` thành công, không cảnh báo.
   - [ ] Giao diện responsive 60fps, trong suốt, không rò rỉ bộ nhớ.
```

## 3. Khi Nào Cần Xác Nhận (Prompt Clarification Gate)
- Nếu yêu cầu có nhiều hướng kiến trúc khả thi hoặc làm thay đổi logic lớn (Breaking Change), AI xuất trình bản Reframing và đề xuất phương án tối ưu để người dùng xác nhận trước khi sửa code.
- Nếu yêu cầu là mệnh lệnh rõ ràng (ví dụ: sửa bug cụ thể, update tài liệu, thêm animation nhỏ), AI tự động Refame trực quan ở đầu phản hồi rồi tiến hành thực thi chuẩn xác.
