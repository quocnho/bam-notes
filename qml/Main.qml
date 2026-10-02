import QtQuick
import "components"
import "views"


Window {
    id: root
    property var appController: null
    visible: true
    width: Screen.width
    height: Screen.height
    color: "transparent"
    flags: Qt.FramelessWindowHint | Qt.WindowStaysOnTopHint

    Component.onCompleted: {
        x = 0
        y = 0
    }

    FloatingBubble {
        id: bubble
        anchors.right: parent.right
        anchors.bottom: parent.bottom
        anchors.rightMargin: 24
        anchors.bottomMargin: 48
        visible: !appController || !appController.isExpanded
        onClicked: if (appController) appController.isExpanded = true
    }

    ChatWindow {
        id: chatWindow
        width: 400
        height: 580
        anchors.right: parent.right
        anchors.bottom: parent.bottom
        anchors.rightMargin: 24
        anchors.bottomMargin: 48
        controller: appController
        visible: !!(appController && appController.isExpanded)
        onCloseClicked: if (appController) appController.isExpanded = false
    }
}

