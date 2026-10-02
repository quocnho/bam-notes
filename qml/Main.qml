import QtQuick
import "components"
import "views"


Window {
    id: root
    property var appController: null
    property bool isPinned: true
    visible: true
    width: (appController && appController.isExpanded) ? 400 : 72
    height: (appController && appController.isExpanded) ? 580 : 72
    color: "transparent"
    flags: isPinned ? (Qt.Tool | Qt.FramelessWindowHint | Qt.WindowStaysOnTopHint)
                    : (Qt.Tool | Qt.FramelessWindowHint)

    function updatePos() {
        var screenW = Screen.desktopAvailableWidth > 0 ? Screen.desktopAvailableWidth : Screen.width
        var screenH = Screen.desktopAvailableHeight > 0 ? Screen.desktopAvailableHeight : Screen.height
        x = screenW - width - 24
        y = screenH - height - 24
    }

    Component.onCompleted: Qt.callLater(updatePos)
    onWidthChanged: updatePos()
    onHeightChanged: updatePos()
    Screen.onWidthChanged: updatePos()
    Screen.onHeightChanged: updatePos()

    FloatingBubble {
        id: bubble
        anchors.fill: parent
        visible: !appController || !appController.isExpanded
        onClicked: {
            if (appController) {
                appController.isExpanded = true
                Qt.callLater(chatWindow.focusInput)
            }
        }
    }

    ChatWindow {
        id: chatWindow
        anchors.fill: parent
        controller: appController
        isPinned: root.isPinned
        visible: !!(appController && appController.isExpanded)
        onPinClicked: root.isPinned = !root.isPinned
        onMinimizeClicked: if (appController) appController.isExpanded = false
        onCloseClicked: confirmDialog.visible = true
    }

    ConfirmDialog {
        id: confirmDialog
        visible: false
        anchors.centerIn: parent
        onConfirmed: (clearData) => {
            if (clearData) chatWindow.clearHistory();
            Qt.quit();
        }
        onCancelled: confirmDialog.visible = false
    }
}


