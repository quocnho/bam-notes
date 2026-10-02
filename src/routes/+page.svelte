<script lang="ts">
  import Sidebar from "../components/Sidebar.svelte";
  import Editor from "../components/Editor.svelte";
  import "../styles.css";

  interface NotePage {
    id: string;
    title: string;
    icon: string;
    content: string;
  }

  let pages = $state<NotePage[]>([
    {
      id: "1",
      title: "Chào mừng đến với Bam Notes",
      icon: "🎋",
      content: `
        <h1>Chào mừng bạn đến với Bam Notes!</h1>
        <p>Ứng dụng ghi chú và quản trị tri thức dạng khối (Block-based) tối ưu cho <strong>BamOS</strong>.</p>
        <blockquote>Trải nghiệm soạn thảo tự do, bảo mật 100% dữ liệu cục bộ và sẵn sàng sao lưu Google Drive.</blockquote>
        <ul data-type="taskList">
          <li data-checked="true"><input type="checkbox" checked /> Khởi tạo ứng dụng & cấu hình Devenv NixOS</li>
          <li data-checked="true"><input type="checkbox" checked /> Tích hợp Block Editor & Theme Adwaita</li>
          <li data-checked="false"><input type="checkbox" /> Kết nối Google Drive Backup & Sync</li>
        </ul>
      `,
    },
  ]);

  let activePageId = $state("1");
  let activePage = $derived(pages.find((p) => p.id === activePageId) || pages[0]);

  function handleCreatePage() {
    const newId = String(Date.now());
    const newPage: NotePage = {
      id: newId,
      title: "Trang không tên",
      icon: "📄",
      content: "<h1>Trang mới</h1><p>Bắt đầu viết nội dung tại đây...</p>",
    };
    pages.push(newPage);
    activePageId = newId;
  }

  function handleContentChange(newHtml: string) {
    if (activePage) {
      activePage.content = newHtml;
    }
  }
</script>

<main class="app-layout">
  <Sidebar
    {pages}
    {activePageId}
    onSelect={(id) => (activePageId = id)}
    onCreate={handleCreatePage}
  />
  <section class="content-area">
    <div class="top-bar">
      <span class="active-icon">{activePage?.icon}</span>
      <input
        class="title-input"
        bind:value={activePage.title}
        placeholder="Tiêu đề trang..."
      />
    </div>
    <div class="scroll-wrapper">
      {#key activePageId}
        <Editor
          initialContent={activePage?.content}
          onChange={handleContentChange}
        />
      {/key}
    </div>
  </section>
</main>

<style>
  .app-layout {
    display: flex;
    height: 100vh;
    width: 100vw;
    background: var(--bg-primary);
  }
  .content-area {
    flex: 1;
    display: flex;
    flex-direction: column;
    height: 100vh;
    overflow: hidden;
  }
  .top-bar {
    display: flex;
    align-items: center;
    gap: 12px;
    padding: 12px 3rem;
    border-bottom: 1px solid var(--border-color);
  }
  .active-icon {
    font-size: 1.5rem;
  }
  .title-input {
    font-size: 1.4rem;
    font-weight: 700;
    border: none;
    background: transparent;
    color: var(--text-primary);
    outline: none;
    width: 100%;
  }
  .scroll-wrapper {
    flex: 1;
    overflow-y: auto;
  }
</style>
