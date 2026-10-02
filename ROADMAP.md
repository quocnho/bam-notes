# 🗺️ Bam Notes - Lộ Trình Phát Triển (Roadmap Đạt 99% Notion)

> **Mục tiêu**: Xây dựng ứng dụng ghi chú & quản trị tri thức (Knowledge Base) cá nhân và nhóm, vận hành **Local-First**, trải nghiệm soạn thảo dạng khối (**Block-based Editor**) tinh tế đạt 99% Notion, hỗ trợ **sao lưu & khôi phục hai chiều trên Google Drive**, đồng thời tích hợp sâu vào hệ sinh thái **BamOS**.

---

## 🏗️ 1. Kiến Trúc Kỹ Thuật (Architecture Overview)

```text
┌────────────────────────────────────────────────────────────────────────┐
│                   Bam Notes Frontend (Tauri WebView)                   │
│   • Block Editor Engine: TipTap / BlockSuite (Slash Commands, Drag)    │
│   • UI Design System: Adwaita CSS + Tailwind (Dark/Light Auto-sync)    │
│   • State Management: Svelte Stores / Signals + IndexedDB Offline     │
└───────────────────────────────────┬────────────────────────────────────┘
                                    │ IPC Bridge (Tauri Commands)
┌───────────────────────────────────▼────────────────────────────────────┐
│                    Bam Notes Core (Rust Backend)                       │
│   • Storage Engine: Local Markdown + YAML Frontmatter + SQLite Index   │
│   • Search Engine: SQLite FTS5 (Full-text Search siêu tốc tức thì)     │
│   • Sync Daemon: Google Drive REST API v3 + OAuth2 PKCE                │
│   • Backup Engine: AES-256 GCM (tùy chọn) + Tar/Zip Packager           │
└───────────────────────────────────┬────────────────────────────────────┘
                                    │ BamOS System Integration
┌───────────────────────────────────▼────────────────────────────────────┐
│                   BamOS / NixOS Ecosystem Modules                      │
│   • Nix Derivation: pkgs/bam-notes                                     │
│   • Configuration Flag: bam.features.office.bam-notes.enable           │
│   • GUI Settings: Xuất hiện trong bam-customizer & Calamares Installer │
└────────────────────────────────────────────────────────────────────────┘
```

---

## 🎯 2. Lộ Trình Chi Tiết (Milestone Roadmap)

### 📍 Giai Đoạn 1: Nền Tảng Core, UI Shell & Block Editor Cơ Bản (Sprint 1)
- [ ] Khởi tạo môi trường phát triển `devenv.nix` & `.envrc` (Rust, Node.js 22, pnpm, WebKitGTK).
- [ ] Thiết lập khung dự án Tauri v2 + SvelteKit / Vite + TailwindCSS.
- [ ] Xây dựng Sidebar điều hướng Workspace:
  - Cây thư mục lồng nhau vô hạn (Infinite Nested Pages).
  - Thêm, sửa, xóa, đổi icon (Emoji Picker), ảnh Cover.
- [ ] Tích hợp Engine Block-Editor cốt lõi:
  - Soạn thảo Text, Heading (H1, H2, H3), Paragraph.
  - Danh sách: Bullet list, Numbered list, Checklist (To-do).
  - Code Block (syntax highlighting), Quote, Callout box có icon màu.
  - **Menu Slash Command (`/`)**: Gõ `/` để gọi nhanh danh sách các loại block.

---

### 📍 Giai Đoạn 2: Trải Nghiệm Khối Nâng Cao Chuẩn 99% Notion (Sprint 2)
- [ ] **Kéo thả khối (Block Drag & Drop)**: Nút handle 6 chấm bên cạnh mỗi block để di chuyển, đổi vị trí mượt mà.
- [ ] **Chuyển đổi kiểu khối (Turn Into)**: Đổi qua lại giữa Paragraph, Heading, Bullet, Toggle list, Callout.
- [ ] **Toggle Lists & Details**: Khối nội dung có thể gập mở (Collapsible blocks).
- [ ] **Bảng & Cơ sở dữ liệu cơ bản (Table Block)**:
  - Bảng đơn giản (Simple Table) hỗ trợ thêm/xóa hàng cột.
  - Chế độ xem danh sách (List View) và bảng dữ liệu.
- [ ] **Liên kết nội bộ (Backlinks & Page Mentions)**:
  - Gõ `@` hoặc `[[` để liên kết đến một trang ghi chú khác trong workspace.
- [ ] **Tìm kiếm toàn văn (Quick Search / Ctrl+K)**: Tìm kiếm tức thì trong toàn bộ tiêu đề và nội dung note qua SQLite FTS5.

---

### 📍 Giai Đoạn 3: Lưu Trữ Cục Bộ & Cơ Chế Đồng Bộ Google Drive (Sprint 3)
- [ ] **Local-First Storage Engine**:
  - Lưu trữ trực tiếp tại `~/.local/share/bam-notes/workspaces/`.
  - Format chuẩn Markdown + metadata JSON, người dùng có thể mở bằng bất kỳ trình soạn thảo nào.
- [ ] **Tích hợp Google Drive OAuth 2.0 (PKCE Flow)**:
  - Đăng nhập bảo mật thông qua trình duyệt mặc định, lưu Access/Refresh Token an toàn vào `secret-service` / keyring của GNOME.
- [ ] **1-Click Backup & Restore**:
  - **Sao lưu (Backup)**: Nén toàn bộ workspace thành file `.bamnotes.tar.gz` và tải lên thư mục `Google Drive/BamNotes_Backup/`.
  - **Khôi phục (Restore)**: Tải và giải nén bản sao lưu từ Google Drive về máy khi cài lại hệ điều hành.
- [ ] **Auto Sync Background**: Tự động kiểm tra thay đổi và đồng bộ nền định kỳ hoặc khi đóng ứng dụng.

---

### 📍 Giai Đoạn 4: Trải Nghiệm Tinh Chỉnh Đẳng Cấp & Đóng Gói BamOS (Sprint 4)
- [ ] Tự động chuyển đổi Dark / Light theme theo cài đặt của hệ điều hành GNOME/BamOS.
- [ ] Hỗ trợ xuất dữ liệu đa định dạng: Export ra PDF, HTML, Markdown ZIP.
- [ ] Đóng gói Flake Nix derivation trong `pkgs/bam-notes`.
- [ ] Khai báo option `bam.features.office.bam-notes.enable` trong `modules/features/catalog.nix`.
- [ ] Đưa vào danh mục `bam-customizer` và Live ISO installer.
