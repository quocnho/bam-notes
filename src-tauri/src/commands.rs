use std::fs;
use std::path::PathBuf;
use tauri::Manager;

pub fn get_storage_dir() -> PathBuf {
    let mut dir = dirs::data_local_dir().unwrap_or_else(|| PathBuf::from("."));
    dir.push("bam-notes");
    dir
}

#[tauri::command]
pub fn toggle_always_on_top(app: tauri::AppHandle, enabled: bool) -> Result<bool, String> {
    if let Some(window) = app.get_webview_window("main") {
        window.set_always_on_top(enabled).map_err(|e| e.to_string())?;
        Ok(enabled)
    } else {
        Err("Không tìm thấy cửa sổ chính".to_string())
    }
}

#[tauri::command]
pub fn backup_workspace(data_json: String) -> Result<String, String> {
    let dir = get_storage_dir();
    fs::create_dir_all(&dir).map_err(|e| e.to_string())?;
    let path = dir.join("bam_notes_backup.json");
    fs::write(&path, data_json).map_err(|e| e.to_string())?;
    Ok(path.to_string_lossy().to_string())
}

#[tauri::command]
pub fn restore_workspace() -> Result<String, String> {
    let dir = get_storage_dir();
    let path = dir.join("bam_notes_backup.json");
    if path.exists() {
        fs::read_to_string(&path).map_err(|e| e.to_string())
    } else {
        Err("Chưa tìm thấy bản sao lưu cục bộ".to_string())
    }
}
