import QtQuick
import "../components"

Rectangle {
    id: headerRoot
    property var controller: null
    height: 48
    color: "#2e2e2e"
    radius: 16

    property bool isPinned: true
    signal closeClicked()
    signal minimizeClicked()
    signal pinClicked()

    Rectangle { anchors.bottom: parent.bottom; width: parent.width; height: 16; color: "#2e2e2e" }
    DragHandler { target: null; onActiveChanged: if (active) root.startSystemMove() }

    Row {
        anchors.left: parent.left; anchors.leftMargin: 10
        anchors.verticalCenter: parent.verticalCenter; spacing: 8

        Rectangle {
            width: 28; height: 28; radius: 14
            color: pinMouse.containsMouse ? "#404040" : (headerRoot.isPinned ? "#384556" : "transparent")
            border.color: headerRoot.isPinned ? "#3584e4" : "transparent"
            Text { anchors.centerIn: parent; text: "📌"; font.pixelSize: 13; opacity: headerRoot.isPinned ? 1.0 : 0.5 }
            MouseArea {
                id: pinMouse; anchors.fill: parent; hoverEnabled: true
                cursorShape: Qt.PointingHandCursor; onClicked: headerRoot.pinClicked()
            }
        }

        StatusIndicator {
            anchors.verticalCenter: parent.verticalCenter
            status: (controller && controller.isGenerating) ? "streaming" : "idle"
        }

        Text { text: "Bam Trợ Lý (OpenClaw)"; color: "#ffffff"; font.bold: true; font.pixelSize: 13 }
    }

    Row {
        anchors.right: parent.right
        anchors.rightMargin: 12
        anchors.verticalCenter: parent.verticalCenter
        spacing: 6

        Rectangle {
            width: 28; height: 28; radius: 14
            color: minM.containsMouse ? "#404040" : "transparent"
            Text { anchors.centerIn: parent; text: "−"; color: "#cccccc"; font.pixelSize: 16; font.bold: true }
            MouseArea {
                id: minM; anchors.fill: parent; hoverEnabled: true
                cursorShape: Qt.PointingHandCursor; onClicked: headerRoot.minimizeClicked()
            }
        }

        Rectangle {
            width: 28; height: 28; radius: 14
            color: closeM.containsMouse ? "#c0392b" : "transparent"
            Text { anchors.centerIn: parent; text: "✕"; color: "#cccccc"; font.pixelSize: 13 }
            MouseArea {
                id: closeM; anchors.fill: parent; hoverEnabled: true
                cursorShape: Qt.PointingHandCursor; onClicked: headerRoot.closeClicked()
            }
        }
    }
}
