import QtQuick
import "../chat"
import "../dialogs"

Window {
    id: chatWinRoot
    property var appController: null
    property var dogWindow: null
    property bool isPinned: true
    signal pinToggled()

    width: 400; height: 580; color: "transparent"
    flags: isPinned ? (Qt.Window | Qt.FramelessWindowHint | Qt.WindowStaysOnTopHint)
                    : (Qt.Window | Qt.FramelessWindowHint)

    function realignToDog() {
        if (!dogWindow) return;
        x = Math.max(10, dogWindow.x + dogWindow.width - width);
        y = (dogWindow.y - height - 8 >= 10) ? (dogWindow.y - height - 8) : (dogWindow.y + dogWindow.height + 8);
    }

    onVisibleChanged: if (visible) realignToDog()

    onXChanged: {
        if (visible && dogWindow && !dogWindow.syncingWinPos) {
            dogWindow.syncingWinPos = true;
            dogWindow.x = x + width - dogWindow.width;
            dogWindow.syncingWinPos = false;
        }
    }

    onYChanged: {
        if (visible && dogWindow && !dogWindow.syncingWinPos) {
            dogWindow.syncingWinPos = true;
            dogWindow.y = y + height + 8;
            dogWindow.syncingWinPos = false;
        }
    }

    ChatWindow {
        id: chatView; anchors.fill: parent; targetWindow: chatWinRoot
        controller: appController; isPinned: chatWinRoot.isPinned
        onPinClicked: chatWinRoot.pinToggled()
        onMinimizeClicked: if (appController) appController.isExpanded = false
        onCloseClicked: confirmDialog.visible = true
    }

    ConfirmDialog {
        id: confirmDialog; visible: false; anchors.centerIn: parent
        controller: appController
        onConfirmed: (clearData) => { if (clearData) chatView.clearHistory(); Qt.quit(); }
        onCancelled: confirmDialog.visible = false
    }

    function focusInput() { chatView.focusInput(); }
}
