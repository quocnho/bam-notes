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
        width: 16; height: pawsRoot.isLying ? 16 : (pawsRoot.isSitting ? 20 : 22)
        y: (pawsRoot.dogState === "intro" ? (isLeft ? pawsRoot.legStride : -pawsRoot.legStride) : -liftY) + (pawsRoot.isLying ? 4 : 0)
        rotation: pawsRoot.isLying ? (isLeft ? -4 : 4) : (isLeft ? 4 : -4)
        Behavior on height { NumberAnimation { duration: 250; easing.type: Easing.OutBack } }

        // Bóng tiếp đất mờ khuếch tán 3 tầng
        Rectangle { anchors.horizontalCenter: parent.horizontalCenter; anchors.bottom: parent.bottom; anchors.bottomMargin: -2.5; width: pawsRoot.isLying ? 18 : 17; height: 5; radius: 2.5; color: "#502812"; opacity: liftY > 2 ? 0.03 : 0.16 }
        Rectangle { anchors.horizontalCenter: parent.horizontalCenter; anchors.bottom: parent.bottom; anchors.bottomMargin: -1.2; width: pawsRoot.isLying ? 13 : 11; height: 3.5; radius: 1.8; color: "#321606"; opacity: liftY > 2 ? 0.06 : 0.28 }

        // Bắp đùi trước thuôn mượt, mềm mại - hòa quyện màu lông thân mình #E59866
        Rectangle {
            anchors.top: parent.top; anchors.horizontalCenter: parent.horizontalCenter
            width: pawsRoot.isLying ? 12 : 11; height: Math.max(7, parent.height - 4)
            radius: width / 2; color: "#E59866"
            Rectangle {
                width: parent.width * 0.5; height: parent.height - 3; x: isLeft ? 1 : (parent.width * 0.45)
                y: 1; radius: width / 2; color: "#FADBD8"; opacity: 0.25
            }
        }

        // Bàn chân trắng tròn trịa vươn ra trước khi nằm
        Rectangle {
            anchors.bottom: parent.bottom; anchors.horizontalCenter: parent.horizontalCenter
            width: pawsRoot.isLying ? 16 : 14.5; height: pawsRoot.isLying ? 9.5 : 10.5
            radius: height / 2; color: "#FFFFFF"
            Rectangle {
                anchors.top: parent.top; anchors.horizontalCenter: parent.horizontalCenter
                width: parent.width * 0.8; height: 2.5; radius: 1.2; color: "#F6EAE1"; opacity: 0.5
            }
            Rectangle {
                anchors.bottom: parent.bottom; width: parent.width * 0.85; height: 2.2
                anchors.horizontalCenter: parent.horizontalCenter; radius: 1.1; color: "#E0D0C5"; opacity: 0.6
            }
            Row {
                anchors.bottom: parent.bottom; anchors.bottomMargin: 2.8
                anchors.horizontalCenter: parent.horizontalCenter; spacing: 3.5
                Repeater {
                    model: 2
                    Rectangle { width: 1.2; height: 3.2; radius: 0.6; color: "#D2BEB0"; opacity: 0.75 }
                }
            }
        }
    }

    Row {
        anchors.horizontalCenter: parent.horizontalCenter; anchors.bottom: parent.bottom
        spacing: pawsRoot.isLying ? 16 : (pawsRoot.isSitting ? 13 : 11)
        SoftPaw { liftY: pawsRoot.legLiftLeft; isLeft: true }
        SoftPaw { liftY: pawsRoot.legLiftRight; isLeft: false }
    }
}
