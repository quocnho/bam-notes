import QtQuick

Rectangle {
    id: dialogRoot
    width: parent ? Math.min(parent.width - 32, 340) : 320
    height: contentCol.implicitHeight + 32
    property var controller: null
    readonly property bool isDark: !controller || controller.isDarkTheme
    radius: 12
    color: isDark ? "#282828" : "#ffffff"
    border.color: isDark ? "#444444" : "#d8d8dc"
    border.width: 1

    signal confirmed(bool clearData)
    signal cancelled()

    Column {
        id: contentCol
        anchors.fill: parent
        anchors.margins: 16
        spacing: 14

        Text {
            text: "Xác nhận đóng ứng dụng"
            color: dialogRoot.isDark ? "#ffffff" : "#1a1a1c"
            font.bold: true
            font.pixelSize: 14
        }

        Text {
            width: parent.width
            text: "Bạn có muốn xóa dữ liệu đoạn chat trước khi đóng ứng dụng không?"
            color: dialogRoot.isDark ? "#cccccc" : "#55555c"
            font.pixelSize: 12
            wrapMode: Text.Wrap
        }

        Row {
            anchors.horizontalCenter: parent.horizontalCenter
            spacing: 8

            Rectangle {
                width: 96; height: 32; radius: 6
                color: yesM.containsMouse ? "#c0392b" : "#e74c3c"
                Text { anchors.centerIn: parent; text: "Có (Xóa)"; color: "#ffffff"; font.pixelSize: 12; font.bold: true }
                MouseArea {
                    id: yesM; anchors.fill: parent; cursorShape: Qt.PointingHandCursor
                    onClicked: dialogRoot.confirmed(true)
                }
            }

            Rectangle {
                width: 96; height: 32; radius: 6
                color: noM.containsMouse ? "#2980b9" : "#3584e4"
                Text { anchors.centerIn: parent; text: "Không (Giữ)"; color: "#ffffff"; font.pixelSize: 12; font.bold: true }
                MouseArea {
                    id: noM; anchors.fill: parent; cursorShape: Qt.PointingHandCursor
                    onClicked: dialogRoot.confirmed(false)
                }
            }

            Rectangle {
                width: 60; height: 32; radius: 6
                color: cancelM.containsMouse ? "#444444" : "#333333"
                Text { anchors.centerIn: parent; text: "Hủy"; color: "#aaaaaa"; font.pixelSize: 12 }
                MouseArea {
                    id: cancelM; anchors.fill: parent; cursorShape: Qt.PointingHandCursor
                    onClicked: dialogRoot.cancelled()
                }
            }
        }
    }
}
