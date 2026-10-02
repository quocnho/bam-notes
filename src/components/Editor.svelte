<script lang="ts">
  import { onMount, onDestroy } from "svelte";
  import { Editor } from "@tiptap/core";
  import StarterKit from "@tiptap/starter-kit";
  import Placeholder from "@tiptap/extension-placeholder";
  import TaskList from "@tiptap/extension-task-list";
  import TaskItem from "@tiptap/extension-task-item";

  let { initialContent = "", onChange } = $props<{
    initialContent?: string;
    onChange?: (content: string) => void;
  }>();

  let element: HTMLDivElement | null = $state(null);
  let editor: Editor | null = $state(null);

  onMount(() => {
    if (!element) return;

    editor = new Editor({
      element,
      extensions: [
        StarterKit,
        Placeholder.configure({
          placeholder: "Gõ '/' để mở menu lệnh hoặc bắt đầu viết ghi chú...",
        }),
        TaskList,
        TaskItem.configure({ nested: true }),
      ],
      content: initialContent,
      onFocus: ({ editor }) => {
        // Tự động xóa nội dung mẫu mặc định khi người dùng click vào soạn thảo
        const text = editor.getText().trim();
        if (text === "Bắt đầu viết nội dung tại đây..." || text === "Trang mới") {
          editor.commands.clearContent();
        }
      },
      onUpdate: ({ editor }) => {
        onChange?.(editor.getHTML());
      },
    });
  });

  onDestroy(() => {
    editor?.destroy();
  });
</script>

<div class="editor-wrapper">
  <div bind:this={element} class="tiptap-container"></div>
</div>

<style>
  .editor-wrapper { width: 100%; max-width: 900px; margin: 0 auto; padding: 2rem 3rem; }
  .tiptap-container { cursor: text; }
</style>
