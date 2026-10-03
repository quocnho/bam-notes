import QtQuick

Item {
    id: pawsRoot
    property string dogState: "active"
    property real legLiftLeft: 0; property real legLiftRight: 0; property real legStride: 0
    width: 62; height: 26

    readonly property bool isLying: dogState === "lying" || dogState === "sleeping"
    readonly property bool isSitting: dogState === "sitting"

    component SoftPaw: Item {
        id: pawItem
        property real liftY: 0; property bool isLeft: true
        width: 16; height: pawsRoot.isLying ? 12 : (pawsRoot.isSitting ? 20 : 22)
        y: pawsRoot.dogState === "intro" ? (isLeft ? pawsRoot.legStride : -pawsRoot.legStride) : -liftY
        rotation: pawsRoot.isLying ? (isLeft ? -10 : 10) : (isLeft ? 4 : -4)
        Behavior on height { NumberAnimation { duration: 250; easing.type: Easing.OutBack } }

        // Bóng tiếp đất mờ khuếch tán 3 tầng (Diffused Ambient Occlusion Shadow)
        Rectangle { anchors.horizontalCenter: parent.horizontalCenter; anchors.bottom: parent.bottom; anchors.bottomMargin: -3; width: pawsRoot.isLying ? 20 : 17; height: 5; radius: 2.5; color: "#502812"; opacity: liftY > 2 ? 0.03 : 0.16 }
        Rectangle { anchors.horizontalCenter: parent.horizontalCenter; anchors.bottom: parent.bottom; anchors.bottomMargin: -1.5; width: pawsRoot.isLying ? 14 : 11; height: 3.5; radius: 1.8; color: "#321606"; opacity: liftY > 2 ? 0.06 : 0.28 }
        Rectangle { anchors.horizontalCenter: parent.horizontalCenter; anchors.bottom: parent.bottom; anchors.bottomMargin: -0.5; width: pawsRoot.isLying ? 8 : 7; height: 2; radius: 1; color: "#1A0902"; opacity: liftY > 2 ? 0.08 : 0.42 }

        // Bắp đùi trước thuôn mượt, mềm mại (Organic Tapered Upper Leg)
        Rectangle {
            anchors.top: parent.top; anchors.horizontalCenter: parent.horizontalCenter
            width: pawsRoot.isLying ? 13 : 11; height: Math.max(7, parent.height - 5)
            radius: width / 2; color: "#DE854C"
            Rectangle {
                width: parent.width * 0.45; height: parent.height - 2; x: isLeft ? 1.5 : (parent.width * 0.4)
                y: 1; radius: width / 2; color: "#FFFFFF"; opacity: 0.35
            }
        }

        // Bàn chân trắng tròn trịa múp míp (Soft Rounded Chubby Paw)
        Rectangle {
            anchors.bottom: parent.bottom; anchors.horizontalCenter: parent.horizontalCenter
            width: pawsRoot.isLying ? 17 : 14.5; height: pawsRoot.isLying ? 8.5 : 10.5
            radius: height / 2; color: "#FFFFFF"
            // Vệt bóng ấm tiếp xúc cổ chân
            Rectangle {
                anchors.top: parent.top; anchors.horizontalCenter: parent.horizontalCenter
                width: parent.width * 0.8; height: 2.5; radius: 1.2; color: "#F0DDD0"; opacity: 0.6
            }
            // Đổ bóng chân 3D mềm mại phía dưới
            Rectangle {
                anchors.bottom: parent.bottom; width: parent.width * 0.85; height: 2.5
                anchors.horizontalCenter: parent.horizontalCenter; radius: 1.2; color: "#D8C5B8"; opacity: 0.7
            }
            // 2 vệt rãnh ngón mờ nhạt tự nhiên
            Row {
                anchors.bottom: parent.bottom; anchors.bottomMargin: 1.5
                anchors.horizontalCenter: parent.horizontalCenter; spacing: 3.5
                Repeater {
                    model: 2
                    Rectangle { width: 1.2; height: 3; radius: 0.6; color: "#D2BEB0"; opacity: 0.75 }
                }
            }
        }
    }

    Row {
        anchors.horizontalCenter: parent.horizontalCenter; anchors.bottom: parent.bottom
        spacing: pawsRoot.isLying ? 22 : (pawsRoot.isSitting ? 13 : 11)
        SoftPaw { liftY: pawsRoot.legLiftLeft; isLeft: true }
        SoftPaw { liftY: pawsRoot.legLiftRight; isLeft: false }
    }
}
