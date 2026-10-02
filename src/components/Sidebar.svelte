<script lang="ts">
  import { FileText, Plus, Folder, Cloud, Settings, HardDrive } from "lucide-svelte";

  interface PageItem {
    id: string;
    title: string;
    icon: string;
  }

  let { pages = [], activePageId = "", onSelect, onCreate } = $props<{
    pages?: PageItem[];
    activePageId?: string;
    onSelect?: (id: string) => void;
    onCreate?: () => void;
  }>();
</script>

<aside class="sidebar">
  <div class="workspace-header">
    <div class="brand">
      <img src="/favicon.png" alt="Bam Notes" class="brand-logo" />
      <span class="brand-title">Bam Notes</span>
    </div>
    <button class="icon-btn" onclick={onCreate} title="Tạo trang mới">
      <Plus size={16} />
    </button>
  </div>

  <div class="nav-section">
    <div class="section-title">TRANG CỦA TÔI</div>
    <div class="page-list">
      {#each pages as page}
        <button
          class="page-item {page.id === activePageId ? 'active' : ''}"
          onclick={() => onSelect?.(page.id)}
        >
          <span class="page-icon">{page.icon}</span>
          <span class="page-name">{page.title}</span>
        </button>
      {/each}
    </div>
  </div>

  <div class="sidebar-footer">
    <button class="footer-btn">
      <Cloud size={16} />
      <span>Google Drive (Sẵn sàng)</span>
    </button>
  </div>
</aside>

<style>
  .sidebar {
    width: 250px;
    height: 100vh;
    background: var(--bg-secondary);
    border-right: 1px solid var(--border-color);
    display: flex;
    flex-direction: column;
    user-select: none;
  }
  .workspace-header {
    display: flex;
    justify-content: space-between;
    align-items: center;
    padding: 14px 16px;
    border-bottom: 1px solid var(--border-color);
  }
  .brand {
    display: flex;
    align-items: center;
    gap: 8px;
    font-weight: 600;
  }
  .brand-logo {
    width: 22px;
    height: 22px;
    object-fit: contain;
  }
  .icon-btn {
    background: none;
    border: none;
    cursor: pointer;
    color: var(--text-secondary);
    padding: 4px;
    border-radius: 4px;
  }
  .icon-btn:hover {
    background: var(--bg-hover);
    color: var(--text-primary);
  }
  .nav-section {
    flex: 1;
    overflow-y: auto;
    padding: 12px 8px;
  }
  .section-title {
    font-size: 11px;
    font-weight: 700;
    color: var(--text-secondary);
    padding: 4px 8px 8px;
  }
  .page-item {
    width: 100%;
    display: flex;
    align-items: center;
    gap: 8px;
    padding: 6px 10px;
    background: none;
    border: none;
    border-radius: 6px;
    color: var(--text-primary);
    cursor: pointer;
    font-size: 14px;
    text-align: left;
  }
  .page-item:hover {
    background: var(--bg-hover);
  }
  .page-item.active {
    background: var(--bg-hover);
    font-weight: 600;
  }
  .page-name {
    overflow: hidden;
    text-overflow: ellipsis;
    white-space: nowrap;
  }
  .sidebar-footer {
    padding: 12px 16px;
    border-top: 1px solid var(--border-color);
  }
  .footer-btn {
    width: 100%;
    display: flex;
    align-items: center;
    gap: 8px;
    background: none;
    border: none;
    color: var(--text-secondary);
    cursor: pointer;
    font-size: 13px;
  }
</style>
