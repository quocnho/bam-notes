mod commands;

use commands::{backup_workspace, restore_workspace, toggle_always_on_top};

#[cfg_attr(mobile, tauri::mobile_entry_point)]
pub fn run() {
    tauri::Builder::default()
        .plugin(tauri_plugin_opener::init())
        .invoke_handler(tauri::generate_handler![
            toggle_always_on_top,
            backup_workspace,
            restore_workspace,
        ])
        .run(tauri::generate_context!())
        .expect("error while running tauri application");
}
