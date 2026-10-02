<script lang="ts">
  import { Plus, Settings, Pin, PinOff, LayoutTemplate } from "lucide-svelte";
  import type { NotePage } from "../types";

  let { pages = [], activePageId = "", isPinned = false, onSelect, onCreate, onTemplate, onTogglePin, onOpenSettings } = $props<{
    pages?: NotePage[];
    activePageId?: string;
    isPinned?: boolean;
    onSelect?: (id: string) => void;
    onCreate?: () => void;
    onTemplate?: () => void;
    onTogglePin?: () => void;
    onOpenSettings?: () => void;
  }>();
</script>

<aside class="sidebar">
  <div class="header">
    <div class="brand">
      <img src="/favicon.png" alt="Logo" class="logo" />
      <span>Bam Notes</span>
    </div>
    <div class="actions">
      <button class="icon-btn {isPinned ? 'active' : ''}" onclick={onTogglePin} title={isPinned ? "Bỏ ghim cửa sổ" : "Ghim cửa sổ trên cùng"}>
        {#if isPinned}<PinOff size={16} />{:else}<Pin size={16} />{/if}
      </button>
      <button class="icon-btn" onclick={onCreate} title="Tạo trang trống"><Plus size={16} /></button>
    </div>
  </div>

  <div class="nav">
    <div class="section-title">MẪU GỢI Ý (TEMPLATES)</div>
    <button class="template-btn" onclick={onTemplate}>
      <LayoutTemplate size={14} /> <span>Chọn mẫu ghi chú...</span>
    </button>

    <div class="section-title" style="margin-top: 14px;">TRANG CỦA TÔI</div>
    {#each pages as page}
      <button class="item {page.id === activePageId ? 'active' : ''}" onclick={() => onSelect?.(page.id)}>
        <span>{page.icon}</span>
        <span class="name">{page.title}</span>
      </button>
    {/each}
  </div>

  <div class="footer">
    <button class="footer-btn" onclick={onOpenSettings}>
      <Settings size={15} /> <span>Thiết Lập & Sao Lưu</span>
    </button>
  </div>
</aside>

<style>
  .sidebar { width: 250px; height: 100vh; background: var(--bg-secondary); border-right: 1px solid var(--border-color); display: flex; flex-direction: column; }
  .header { display: flex; justify-content: space-between; align-items: center; padding: 12px 14px; border-bottom: 1px solid var(--border-color); }
  .brand { display: flex; align-items: center; gap: 8px; font-weight: 700; font-size: 14px; }
  .logo { width: 22px; height: 22px; object-fit: contain; }
  .actions { display: flex; gap: 4px; }
  .icon-btn { background: none; border: none; cursor: pointer; color: var(--text-secondary); padding: 4px; border-radius: 4px; }
  .icon-btn:hover, .icon-btn.active { background: var(--bg-hover); color: var(--accent-color); }
  .nav { flex: 1; overflow-y: auto; padding: 12px 8px; }
  .section-title { font-size: 10px; font-weight: 700; color: var(--text-secondary); padding: 4px 8px; letter-spacing: 0.05em; }
  .template-btn { width: 100%; display: flex; align-items: center; gap: 8px; padding: 6px 10px; border-radius: 6px; background: none; border: 1px dashed var(--border-color); color: var(--text-secondary); font-size: 12px; cursor: pointer; margin-top: 4px; }
  .template-btn:hover { background: var(--bg-hover); color: var(--accent-color); }
  .item { width: 100%; display: flex; align-items: center; gap: 8px; padding: 6px 10px; border-radius: 6px; background: none; border: none; color: var(--text-primary); cursor: pointer; font-size: 13px; text-align: left; }
  .item:hover { background: var(--bg-hover); }
  .item.active { background: var(--bg-hover); font-weight: 600; color: var(--accent-color); }
  .name { overflow: hidden; text-overflow: ellipsis; white-space: nowrap; }
  .footer { padding: 12px 14px; border-top: 1px solid var(--border-color); }
  .footer-btn { width: 100%; display: flex; align-items: center; gap: 8px; background: none; border: none; color: var(--text-secondary); cursor: pointer; font-size: 12px; }
  .footer-btn:hover { color: var(--text-primary); }
</style>
