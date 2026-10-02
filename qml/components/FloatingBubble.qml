import QtQuick

Rectangle {
    id: bubbleRoot
    width: 56
    height: 56
    radius: 28
    color: "#3584e4"
    border.color: "#ffffff"
    border.width: 2

    signal clicked()

    Text {
        anchors.centerIn: parent
        text: "🤖"
        font.pixelSize: 26
    }

    DragHandler {
        target: null
        onActiveChanged: if (active) root.startSystemMove()
    }

    MouseArea {
        anchors.fill: parent
        cursorShape: Qt.PointingHandCursor
        hoverEnabled: true
        onEntered: bubbleRoot.scale = 1.10
        onExited: bubbleRoot.scale = 1.0
        onClicked: bubbleRoot.clicked()
    }

    Behavior on scale {
        NumberAnimation { duration: 150; easing.type: Easing.OutQuad }
    }
}
