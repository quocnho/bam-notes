export interface NotePage {
  id: string;
  title: string;
  icon: string;
  content: string;
  type?: "note" | "todo" | "task" | "checklist";
  updatedAt?: number;
}

export const TEMPLATES: Record<string, { title: string; icon: string; content: string }> = {
  todo: {
    title: "Danh Sách Công Việc (To-Do)",
    icon: "✅",
    content: `
      <h1>Danh Sách Công Việc Hôm Nay</h1>
      <p>Theo dõi các đầu việc ưu tiên cần giải quyết:</p>
      <ul data-type="taskList">
        <li data-checked="false"><input type="checkbox" /> Nhiệm vụ quan trọng 1</li>
        <li data-checked="false"><input type="checkbox" /> Nhiệm vụ quan trọng 2</li>
        <li data-checked="false"><input type="checkbox" /> Đánh giá cuối ngày</li>
      </ul>
    `,
  },
  meeting: {
    title: "Biên Bản Cuộc Họp",
    icon: "👥",
    content: `
      <h1>Biên Bản Cuộc Họp</h1>
      <p><strong>Thời gian:</strong> Hôm nay | <strong>Người tham gia:</strong> Toàn đội</p>
      <h2>Mục Tiêu Cuộc Họp</h2>
      <p>Nêu rõ kết quả cần đạt được sau cuộc họp...</p>
      <h2>Nội Dung Thảo Luận</h2>
      <blockquote>Ý kiến và giải pháp đề xuất từ các thành viên.</blockquote>
      <h2>Hành Động Cần Làm (Action Items)</h2>
      <ul data-type="taskList">
        <li data-checked="false"><input type="checkbox" /> Giao việc cho thành viên A</li>
        <li data-checked="false"><input type="checkbox" /> Giao việc cho thành viên B</li>
      </ul>
    `,
  },
  project: {
    title: "Kế Hoạch Dự Án",
    icon: "🚀",
    content: `
      <h1>Kế Hoạch Phát Triển Dự Án</h1>
      <p>Tài liệu đặc tả các mốc phát triển chính của hệ thống.</p>
      <h2>Mục Tiêu & Định Hướng</h2>
      <p>Đạt chuẩn chất lượng 99% trải nghiệm Notion.</p>
      <h2>Các Giai Đoạn (Milestones)</h2>
      <ul data-type="taskList">
        <li data-checked="true"><input type="checkbox" checked /> Sprint 1: Core Shell & Editor</li>
        <li data-checked="false"><input type="checkbox" /> Sprint 2: Templates & Pin window</li>
        <li data-checked="false"><input type="checkbox" /> Sprint 3: Google Drive Sync</li>
      </ul>
    `,
  },
};
