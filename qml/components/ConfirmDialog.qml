import QtQuick

Rectangle {
    id: dialogRoot
    width: parent ? Math.min(parent.width - 32, 340) : 320
    height: contentCol.implicitHeight + 32
    radius: 12
    color: "#282828"
    border.color: "#444444"
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
            color: "#ffffff"
            font.bold: true
            font.pixelSize: 14
        }

        Text {
            width: parent.width
            text: "Bạn có muốn xóa dữ liệu đoạn chat trước khi đóng ứng dụng không?"
            color: "#cccccc"
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
