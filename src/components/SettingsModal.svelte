<script lang="ts">
  import { X, HardDrive, Download, Upload, CheckCircle2 } from "lucide-svelte";

  let { isOpen = false, onClose, onBackup, onRestore } = $props<{
    isOpen?: boolean;
    onClose?: () => void;
    onBackup?: () => Promise<string | void>;
    onRestore?: () => Promise<void>;
  }>();

  let statusMsg = $state("");
  let isBackingUp = $state(false);

  async function handleBackup() {
    isBackingUp = true;
    statusMsg = "Đang sao lưu...";
    try {
      const res = await onBackup?.();
      statusMsg = res ? `Đã sao lưu: ${res}` : "Sao lưu thành công!";
    } catch (e: any) {
      statusMsg = `Lỗi: ${e}`;
    } finally {
      isBackingUp = false;
    }
  }

  async function handleRestore() {
    statusMsg = "Đang khôi phục...";
    try {
      await onRestore?.();
      statusMsg = "Khôi phục dữ liệu thành công!";
    } catch (e: any) {
      statusMsg = `Lỗi: ${e}`;
    }
  }
</script>

{#if isOpen}
  <div class="modal-backdrop" onclick={onClose}>
    <div class="modal-card" onclick={(e) => e.stopPropagation()}>
      <div class="modal-header">
        <h3>Cấu Hình & Thiết Lập</h3>
        <button class="close-btn" onclick={onClose}><X size={18} /></button>
      </div>

      <div class="modal-body">
        <div class="setting-group">
          <div class="group-title">SAO LƯU & KHÔI PHỤC (LOCAL / DRIVE)</div>
          <p class="group-desc">Dữ liệu được lưu trữ an toàn tại thư mục hệ thống cục bộ.</p>
          <div class="action-buttons">
            <button class="btn btn-primary" onclick={handleBackup} disabled={isBackingUp}>
              <Upload size={16} /> Sao Lưu Ngay
            </button>
            <button class="btn btn-secondary" onclick={handleRestore}>
              <Download size={16} /> Khôi Phục Dữ Liệu
            </button>
          </div>
        </div>

        {#if statusMsg}
          <div class="status-box">
            <CheckCircle2 size={16} />
            <span>{statusMsg}</span>
          </div>
        {/if}
      </div>
    </div>
  </div>
{/if}

<style>
  .modal-backdrop {
    position: fixed; inset: 0; background: rgba(0,0,0,0.5);
    display: flex; align-items: center; justify-content: center; z-index: 100;
  }
  .modal-card {
    background: var(--bg-primary); width: 440px; border-radius: 12px;
    border: 1px solid var(--border-color); overflow: hidden; box-shadow: 0 10px 25px rgba(0,0,0,0.3);
  }
  .modal-header {
    display: flex; justify-content: space-between; align-items: center;
    padding: 14px 18px; border-bottom: 1px solid var(--border-color);
  }
  .close-btn { background: none; border: none; cursor: pointer; color: var(--text-secondary); }
  .modal-body { padding: 18px; }
  .group-title { font-size: 11px; font-weight: 700; color: var(--text-secondary); margin-bottom: 6px; }
  .group-desc { font-size: 13px; color: var(--text-secondary); margin-bottom: 14px; }
  .action-buttons { display: flex; gap: 10px; }
  .btn {
    display: flex; align-items: center; gap: 6px; padding: 8px 14px;
    border-radius: 6px; font-size: 13px; font-weight: 600; cursor: pointer; border: none;
  }
  .btn-primary { background: var(--accent-color); color: #fff; }
  .btn-secondary { background: var(--bg-hover); color: var(--text-primary); border: 1px solid var(--border-color); }
  .status-box {
    margin-top: 14px; padding: 10px; border-radius: 6px; background: var(--bg-secondary);
    display: flex; align-items: center; gap: 8px; font-size: 12px; color: var(--accent-color);
  }
</style>
