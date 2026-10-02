import QtQuick
import "components"
import "views"


Window {
    id: root
    property var appController: null
    visible: true
    width: (appController && appController.isExpanded) ? 400 : 72
    height: (appController && appController.isExpanded) ? 580 : 72
    color: "transparent"
    flags: Qt.Tool | Qt.FramelessWindowHint | Qt.WindowStaysOnTopHint

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
        onRightClicked: contextMenu.visible = !contextMenu.visible
    }

    ChatWindow {
        id: chatWindow
        anchors.fill: parent
        controller: appController
        visible: !!(appController && appController.isExpanded)
        onCloseClicked: if (appController) appController.isExpanded = false
        onRightClicked: contextMenu.visible = !contextMenu.visible
    }

    ContextMenu {
        id: contextMenu
        visible: false
        anchors.right: parent.right
        anchors.bottom: parent.bottom
        anchors.rightMargin: (appController && appController.isExpanded) ? 8 : 0
        anchors.bottomMargin: (appController && appController.isExpanded) ? 48 : 72
        onToggleChat: {
            visible = false;
            if (appController) {
                appController.isExpanded = !appController.isExpanded;
                if (appController.isExpanded) Qt.callLater(chatWindow.focusInput);
            }
        }
        onClearHistory: {
            visible = false;
            chatWindow.clearHistory();
        }
        onQuitApp: Qt.quit()
    }
}


