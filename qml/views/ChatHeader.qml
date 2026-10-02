import QtQuick
import "../components"

Rectangle {
    id: headerRoot
    property var controller: null
    height: 48
    color: "#2e2e2e"
    radius: 16

    signal closeClicked()
    signal minimizeClicked()

    Rectangle { anchors.bottom: parent.bottom; width: parent.width; height: 16; color: "#2e2e2e" }
    DragHandler { target: null; onActiveChanged: if (active) root.startSystemMove() }

    Row {
        anchors.left: parent.left
        anchors.leftMargin: 16
        anchors.verticalCenter: parent.verticalCenter
        spacing: 8

        StatusIndicator {
            anchors.verticalCenter: parent.verticalCenter
            status: (controller && controller.isGenerating) ? "streaming" : "idle"
        }

        Text {
            text: "Bam Trợ Lý (OpenClaw ReAct Agent)"
            color: "#ffffff"
            font.bold: true
            font.pixelSize: 13
        }
    }

    Row {
        anchors.right: parent.right
        anchors.rightMargin: 12
        anchors.verticalCenter: parent.verticalCenter
        spacing: 6

        // Nút Thu nhỏ (-)
        Rectangle {
            width: 28; height: 28; radius: 14
            color: minMouse.containsMouse ? "#404040" : "transparent"
            Text { anchors.centerIn: parent; text: "−"; color: "#cccccc"; font.pixelSize: 16; font.bold: true }
            MouseArea {
                id: minMouse
                anchors.fill: parent
                hoverEnabled: true
                cursorShape: Qt.PointingHandCursor
                onClicked: headerRoot.minimizeClicked()
            }
        }

        // Nút Đóng (✕)
        Rectangle {
            width: 28; height: 28; radius: 14
            color: closeMouse.containsMouse ? "#c0392b" : "transparent"
            Text { anchors.centerIn: parent; text: "✕"; color: "#cccccc"; font.pixelSize: 13 }
            MouseArea {
                id: closeMouse
                anchors.fill: parent
                hoverEnabled: true
                cursorShape: Qt.PointingHandCursor
                onClicked: headerRoot.closeClicked()
            }
        }
    }
}
