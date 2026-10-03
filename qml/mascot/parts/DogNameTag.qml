import QtQuick

Item {
    id: tagRoot
    property string dogState: "active"
    property real chestPuff: 1.0
    property real bodyBob: 0

    readonly property bool isLying: dogState === "lying" || dogState === "sleeping"
    readonly property bool isSitting: dogState === "sitting"

    // Vòng cổ ôm sát bờ cổ trên gần cằm
    width: isLying ? 34 : (isSitting ? 30 : 28)
    height: isLying ? 13 : 15

    // 1. Vòng cổ da thời trang (Dog Collar) - bo cong mềm mại
    Rectangle {
        id: collarStrap
        width: parent.width; height: isLying ? 4 : 4.5; radius: height / 2
        color: "#C0392B"; border.color: "#78281F"; border.width: 0.8
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.top: parent.top
        Rectangle {
            anchors.centerIn: parent; width: parent.width * 0.88; height: 1
            radius: 0.5; color: "#E6B0AA"; opacity: 0.6
        }
    }

    // 2. Thẻ tên BAM gắn liền sát khít ngay dưới vòng cổ
    Rectangle {
        id: nameBadge
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.top: collarStrap.bottom
        // Sát khít với vòng cổ ở cả tư thế đứng, ngồi và nằm
        anchors.topMargin: 0
        width: isLying ? 23 : (isSitting ? 21 : 20)
        height: isLying ? 11.5 : 13
        radius: height / 2
        color: "#0F172A" // Nền Navy Dark tương phản mạnh
        border.color: "#38BDF8" // Viền Cyan công nghệ BamOS sắc nét
        border.width: 1.1

        // Vệt sáng bóng kim loại mượt mà
        Rectangle {
            anchors.top: parent.top; anchors.topMargin: 1; anchors.horizontalCenter: parent.horizontalCenter
            width: parent.width * 0.65; height: 1.5; radius: 0.75; color: "#FFFFFF"; opacity: 0.45
        }

        // Chữ BAM to, đậm, nằm ở vị trí cao nhất nhìn rõ ngay từ cằm
        Text {
            anchors.centerIn: parent
            text: "BAM"
            font.bold: true
            font.pixelSize: tagRoot.isLying ? 7.2 : 8.2
            font.family: "Monospace"
            color: "#FFFFFF"
        }

        // Đung đưa tự nhiên theo chuyển động thở
        rotation: tagRoot.isLying ? -2.5 : (Math.sin(tagRoot.bodyBob * 1.5) * 3.5)
        Behavior on rotation { NumberAnimation { duration: 180; easing.type: Easing.OutSine } }
        Behavior on width { NumberAnimation { duration: 250; easing.type: Easing.OutBack } }
        Behavior on height { NumberAnimation { duration: 250; easing.type: Easing.OutBack } }
    }
}
