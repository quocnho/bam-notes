import QtQuick
import QtQuick.Window
import "components"
import "views"

Window {
    id: root
    visible: true
    width: appController.isExpanded ? 400 : 72
    height: appController.isExpanded ? 580 : 72
    color: "transparent"
    flags: Qt.FramelessWindowHint | Qt.WindowStaysOnTopHint

    Component.onCompleted: {
        x = Screen.width - 420
        y = Screen.height - 620
    }

    Behavior on width { NumberAnimation { duration: 220; easing.type: Easing.OutCubic } }
    Behavior on height { NumberAnimation { duration: 220; easing.type: Easing.OutCubic } }

    DragHandler {
        id: dragHandler
        target: null
        onActiveChanged: if (active) root.startSystemMove()
    }

    FloatingBubble {
        id: bubble
        anchors.right: parent.right
        anchors.bottom: parent.bottom
        visible: !appController.isExpanded
        onClicked: appController.isExpanded = true
    }

    ChatWindow {
        id: chatWindow
        anchors.fill: parent
        visible: appController.isExpanded
        onCloseClicked: appController.isExpanded = false
    }
}
