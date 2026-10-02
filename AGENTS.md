# Bam Notes Codebase Architecture & Context Map

> **Dành cho AI Assistants (Gemini, Claude, GPT, Antigravity, Cursor, Zed):**
> Đọc tài liệu này trước để định tuyến trực tiếp đến đúng file cần sửa. Không quét/grep diện rộng trên toàn bộ repo.
> Tuân thủ nghiêm ngặt mô hình **Atomic Micro-Modules (< 80 dòng/file Nix/TS/Svelte, < 100 dòng/file Rust)**.

## 1. Directory Structure Map

```text
bam-notes/
├── devenv.nix                        # Môi trường phát triển Nix (Rust + Node.js 22 + WebKitGTK)
├── .envrc                            # Direnv tự động nạp devenv
├── ROADMAP.md                        # Lộ trình 4 Sprint đạt 99% tính năng Notion
├── AGENTS.md                         # Bản đồ kiến trúc & quy tắc AI Agent
├── .agents/skills/                   # Skills chuyên biệt cho Solo Coder & AI
│   ├── bamos-agile-workflow/         # Quản lý Sprint, DoD, Vibe Coding
│   ├── bamos-git-workflow/           # Chuẩn nhánh (develop -> main) & AA.BB.CC
│   └── bamos-modular-architecture/   # Giới hạn dòng & Clean Architecture
├── src-tauri/                        # Backend Rust (Tauri v2)
│   ├── Cargo.toml                    # Cấu hình dependencies Rust
│   ├── tauri.conf.json               # Cấu hình cửa sổ, quyền bảo mật, capabilities
│   └── src/
│       ├── main.rs                   # Entrypoint khởi tạo Tauri app (< 60 dòng)
│       ├── lib.rs                    # Aggregator modules (< 50 dòng)
│       ├── commands/                 # Tauri IPC Commands gọi từ Frontend
│       │   ├── mod.rs                # Re-export commands (< 40 dòng)
│       │   ├── notes.rs              # Tạo, đọc, ghi, xóa Markdown note (< 80 dòng)
│       │   └── drive.rs              # Google Drive OAuth & Backup/Restore (< 80 dòng)
│       └── storage/                  # Local File & SQLite storage
│           ├── mod.rs                # Storage traits & helpers (< 40 dòng)
│           ├── markdown.rs           # Quản lý file Markdown & Frontmatter (< 80 dòng)
│           └── drive_client.rs       # Client gọi Google Drive REST API (< 90 dòng)
└── src/                              # Frontend (Svelte / TypeScript / TipTap)
    ├── App.svelte                    # Root UI Shell (Sidebar + Editor view)
    ├── main.ts                       # Frontend entrypoint
    ├── components/
    │   ├── sidebar/                  # Sidebar quản lý cây trang (Nested pages)
    │   ├── editor/                   # TipTap / Block Editor engine
    │   └── common/                   # Modal, Buttons, Context Menu
    └── styles/
        └── app.css                   # Adwaita GNOME Theme & Block Styling
```

## 2. Token Saving Guidelines for AI
- **Targeted Reading**: Sử dụng `grep_search` và `view_file` với `StartLine`/`EndLine` cụ thể. Không quét toàn bộ repo.
- **Targeted Edits**: Ưu tiên sử dụng `replace_file_content` hoặc `multi_replace_file_content`.
- **Tuyệt đối không đọc**: `target/`, `node_modules/`, `.direnv/`, `.devenv/`, `dist/`, `build/`, file nhị phân, `.lock`.

## 3. Clean Architecture & Micro-Modules Rules
- **Ngưỡng trần giới hạn dòng (Strict Ceiling)**:
  - Mọi file Nix, TypeScript, Svelte, CSS: **TỐI ĐA < 80 dòng/file**. Khi đạt ~70 dòng, tách component nhỏ.
  - Mọi file mã nguồn Rust: **TỐI ĐA < 100 dòng/file**. Tách biệt domain logic, IPC commands và storage.
- **Strict FOSS & No Commercial License (100% Tự do)**:
  - Toàn bộ dependencies Rust crates và npm packages đều phải là FOSS (MIT, Apache-2.0, GPL-3.0, BSD).

## 4. Versioning Standard (`AA.BB.CC`) & Git Workflow
- **Định dạng**: `AA.BB.CC` (ví dụ năm 2026 -> `v26.01.01`).
- **Nhánh Git**:
  - `develop`: Nhánh làm việc chính cho mọi commit tính năng.
  - `main`: Nhánh ổn định, chỉ merge từ `develop` khi kết thúc Sprint và tạo Git Tag `vAA.BB.CC`.
- **Zero Bloat Invariant**: Không bao giờ commit file build, node_modules, target, backup archives.
