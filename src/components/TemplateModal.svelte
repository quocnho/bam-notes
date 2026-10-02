<script lang="ts">
  import { X, CheckSquare, Users, Rocket, Plus } from "lucide-svelte";
  import { TEMPLATES } from "../types";

  let { isOpen = false, onClose, onSelectTemplate } = $props<{
    isOpen?: boolean;
    onClose?: () => void;
    onSelectTemplate?: (key: string) => void;
  }>();

  const templateList = [
    { key: "todo", title: "Danh Sách To-Do", desc: "Theo dõi công việc, checklist hàng ngày", icon: "✅" },
    { key: "meeting", title: "Biên Bản Họp", desc: "Mục tiêu, nội dung thảo luận & đầu việc", icon: "👥" },
    { key: "project", title: "Kế Hoạch Dự Án", desc: "Lộ trình, mục tiêu và các mốc bàn giao", icon: "🚀" },
  ];
</script>

{#if isOpen}
  <div class="backdrop" onclick={onClose}>
    <div class="card" onclick={(e) => e.stopPropagation()}>
      <div class="header">
        <h3>Chọn Mẫu Ghi Chú (Templates)</h3>
        <button class="close-btn" onclick={onClose}><X size={18} /></button>
      </div>
      <div class="grid">
        {#each templateList as t}
          <button class="t-item" onclick={() => onSelectTemplate?.(t.key)}>
            <span class="icon">{t.icon}</span>
            <div class="meta">
              <h4>{t.title}</h4>
              <p>{t.desc}</p>
            </div>
          </button>
        {/each}
      </div>
    </div>
  </div>
{/if}

<style>
  .backdrop { position: fixed; inset: 0; background: rgba(0,0,0,0.5); display: flex; align-items: center; justify-content: center; z-index: 100; }
  .card { background: var(--bg-primary); width: 480px; border-radius: 12px; border: 1px solid var(--border-color); overflow: hidden; box-shadow: 0 10px 25px rgba(0,0,0,0.3); }
  .header { display: flex; justify-content: space-between; align-items: center; padding: 14px 18px; border-bottom: 1px solid var(--border-color); }
  .close-btn { background: none; border: none; cursor: pointer; color: var(--text-secondary); }
  .grid { padding: 14px; display: flex; flex-direction: column; gap: 8px; }
  .t-item { display: flex; align-items: center; gap: 12px; padding: 10px 12px; border-radius: 8px; border: 1px solid var(--border-color); background: var(--bg-secondary); cursor: pointer; text-align: left; }
  .t-item:hover { border-color: var(--accent-color); background: var(--bg-hover); }
  .icon { font-size: 1.8rem; }
  .meta h4 { font-size: 14px; color: var(--text-primary); margin-bottom: 2px; }
  .meta p { font-size: 12px; color: var(--text-secondary); }
</style>
