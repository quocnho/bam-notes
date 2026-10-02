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
        x = Screen.desktopAvailableWidth - width - 24
        y = Screen.desktopAvailableHeight - height - 24
    }

    Component.onCompleted: updatePos()
    onWidthChanged: updatePos()
    onHeightChanged: updatePos()


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
        visible: !!(appController && appController.isExpanded)
        onCloseClicked: if (appController) appController.isExpanded = false
    }
}


