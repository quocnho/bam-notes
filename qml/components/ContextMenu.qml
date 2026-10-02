import QtQuick

Rectangle {
    id: menuRoot
    width: 180
    height: menuCol.implicitHeight + 16
    radius: 10
    color: "#282828"
    border.color: "#3f3f3f"
    border.width: 1

    signal toggleChat()
    signal clearHistory()
    signal quitApp()

    Column {
        id: menuCol
        anchors.fill: parent
        anchors.margins: 8
        spacing: 4

        Rectangle {
            width: parent.width
            height: 32
            radius: 6
            color: item1Mouse.containsMouse ? "#3b3b3b" : "transparent"

            Row {
                anchors.fill: parent
                anchors.leftMargin: 8
                spacing: 8
                Text { anchors.verticalCenter: parent.verticalCenter; text: "💬"; font.pixelSize: 13 }
                Text { anchors.verticalCenter: parent.verticalCenter; text: "Mở / Thu gọn"; color: "#f0f0f0"; font.pixelSize: 12 }
            }
            MouseArea {
                id: item1Mouse
                anchors.fill: parent
                hoverEnabled: true
                cursorShape: Qt.PointingHandCursor
                onClicked: menuRoot.toggleChat()
            }
        }

        Rectangle {
            width: parent.width
            height: 32
            radius: 6
            color: item2Mouse.containsMouse ? "#3b3b3b" : "transparent"

            Row {
                anchors.fill: parent
                anchors.leftMargin: 8
                spacing: 8
                Text { anchors.verticalCenter: parent.verticalCenter; text: "🧹"; font.pixelSize: 13 }
                Text { anchors.verticalCenter: parent.verticalCenter; text: "Xoá đoạn chat"; color: "#f0f0f0"; font.pixelSize: 12 }
            }
            MouseArea {
                id: item2Mouse
                anchors.fill: parent
                hoverEnabled: true
                cursorShape: Qt.PointingHandCursor
                onClicked: menuRoot.clearHistory()
            }
        }

        Rectangle {
            width: parent.width
            height: 1
            color: "#3a3a3a"
        }

        Rectangle {
            width: parent.width
            height: 32
            radius: 6
            color: item3Mouse.containsMouse ? "#4a2424" : "transparent"

            Row {
                anchors.fill: parent
                anchors.leftMargin: 8
                spacing: 8
                Text { anchors.verticalCenter: parent.verticalCenter; text: "❌"; font.pixelSize: 13 }
                Text { anchors.verticalCenter: parent.verticalCenter; text: "Đóng ứng dụng"; color: "#ff6b6b"; font.pixelSize: 12 }
            }
            MouseArea {
                id: item3Mouse
                anchors.fill: parent
                hoverEnabled: true
                cursorShape: Qt.PointingHandCursor
                onClicked: menuRoot.quitApp()
            }
        }
    }
}
