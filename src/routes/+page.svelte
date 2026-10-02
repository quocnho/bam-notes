<script lang="ts">
  import Sidebar from "../components/Sidebar.svelte";
  import Editor from "../components/Editor.svelte";
  import TemplateModal from "../components/TemplateModal.svelte";
  import SettingsModal from "../components/SettingsModal.svelte";
  import { invoke } from "@tauri-apps/api/core";
  import { TEMPLATES, type NotePage } from "../types";
  import "../styles.css";

  let pages = $state<NotePage[]>([
    {
      id: "1",
      title: "Trang không tên",
      icon: "🎋",
      content: "<h1>Trang mới</h1><p>Bắt đầu viết nội dung tại đây...</p>",
    },
  ]);

  let activePageId = $state("1");
  let isPinned = $state(false);
  let showTemplates = $state(false);
  let showSettings = $state(false);
  let activePage = $derived(pages.find((p) => p.id === activePageId) || pages[0]);

  function handleCreatePage() {
    const newId = String(Date.now());
    pages.push({ id: newId, title: "Trang không tên", icon: "📄", content: "" });
    activePageId = newId;
  }

  function handleSelectTemplate(key: string) {
    const tmpl = TEMPLATES[key];
    if (!tmpl) return;
    const newId = String(Date.now());
    pages.push({ id: newId, title: tmpl.title, icon: tmpl.icon, content: tmpl.content });
    activePageId = newId;
    showTemplates = false;
  }

  async function handleTogglePin() {
    try {
      const next = !isPinned;
      const res = await invoke<boolean>("toggle_always_on_top", { enabled: next });
      isPinned = res;
    } catch (e) {
      console.error("Lỗi ghim cửa sổ:", e);
    }
  }

  async function handleBackup(): Promise<string> {
    const json = JSON.stringify(pages, null, 2);
    return await invoke<string>("backup_workspace", { dataJson: json });
  }

  async function handleRestore() {
    const json = await invoke<string>("restore_workspace");
    const restored = JSON.parse(json);
    if (Array.isArray(restored) && restored.length > 0) {
      pages = restored;
      activePageId = pages[0].id;
    }
  }
</script>

<main class="app-layout">
  <Sidebar
    {pages} {activePageId} {isPinned}
    onSelect={(id) => (activePageId = id)}
    onCreate={handleCreatePage}
    onTemplate={() => (showTemplates = true)}
    onTogglePin={handleTogglePin}
    onOpenSettings={() => (showSettings = true)}
  />

  <section class="content-area">
    <div class="top-bar">
      <span class="active-icon">{activePage?.icon}</span>
      <input
        class="title-input"
        bind:value={activePage.title}
        placeholder="Tiêu đề trang..."
        onfocus={(e) => {
          if (activePage.title === "Trang không tên") activePage.title = "";
        }}
      />
    </div>
    <div class="scroll-wrapper">
      {#key activePageId}
        <Editor
          initialContent={activePage?.content}
          onChange={(html) => { if (activePage) activePage.content = html; }}
        />
      {/key}
    </div>
  </section>

  <TemplateModal isOpen={showTemplates} onClose={() => (showTemplates = false)} onSelectTemplate={handleSelectTemplate} />
  <SettingsModal isOpen={showSettings} onClose={() => (showSettings = false)} onBackup={handleBackup} onRestore={handleRestore} />
</main>

<style>
  .app-layout { display: flex; height: 100vh; width: 100vw; background: var(--bg-primary); }
  .content-area { flex: 1; display: flex; flex-direction: column; height: 100vh; overflow: hidden; }
  .top-bar { display: flex; align-items: center; gap: 12px; padding: 12px 3rem; border-bottom: 1px solid var(--border-color); }
  .active-icon { font-size: 1.5rem; }
  .title-input { font-size: 1.4rem; font-weight: 700; border: none; background: transparent; color: var(--text-primary); outline: none; width: 100%; }
  .scroll-wrapper { flex: 1; overflow-y: auto; }
</style>
