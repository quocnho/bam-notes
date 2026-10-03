import QtQuick

Item {
    id: mouthRoot
    property string dogState: "active"
    property bool isBarking: false
    property real tongueVibrate: 0
    width: 26; height: 20

    SequentialAnimation {
        running: mouthRoot.isBarking || mouthRoot.dogState === "active"; loops: Animation.Infinite
        NumberAnimation { target: mouthRoot; property: "tongueVibrate"; to: 1.2; duration: 90 }
        NumberAnimation { target: mouthRoot; property: "tongueVibrate"; to: -1.2; duration: 90 }
    }

    Rectangle {
        width: 24; height: 16; radius: 8; color: "#FFFFFF"
        border.color: "#E2E8F0"; border.width: 1
        anchors.horizontalCenter: parent.horizontalCenter; anchors.top: parent.top

        Rectangle {
            anchors.bottom: parent.bottom; anchors.horizontalCenter: parent.horizontalCenter
            width: parent.width * 0.85; height: 3; radius: 1.5; color: "#CBD5E1"; opacity: 0.6
        }

        // Mũi chó đen bóng 3D
        Rectangle {
            width: 8; height: 6; radius: 3; color: "#111827"
            anchors.horizontalCenter: parent.horizontalCenter; y: 1
            Rectangle { width: 2.5; height: 1.5; radius: 0.75; color: "#FFFFFF"; opacity: 0.85; x: 1.5; y: 1 }
        }

        Rectangle {
            width: 1.2; height: 4; radius: 0.6; color: "#94A3B8"
            anchors.horizontalCenter: parent.horizontalCenter; y: 6.5
        }

        // Khoang miệng mở & đóng cực nhanh theo nhịp sủa dứt khoát (Snappy Staging - Disney #3)
        Rectangle {
            id: mouthHole
            width: mouthRoot.isBarking ? 13 : (mouthRoot.dogState === "sleeping" ? 0 : 7)
            height: mouthRoot.isBarking ? 9 : (mouthRoot.dogState === "sleeping" ? 0 : 3.5)
            radius: mouthRoot.isBarking ? 4.5 : 1.8; color: "#450A0A"
            anchors.horizontalCenter: parent.horizontalCenter; y: 8
            visible: mouthRoot.dogState !== "sleeping"

            Behavior on height { NumberAnimation { duration: 45; easing.type: Easing.OutQuad } }
            Behavior on width { NumberAnimation { duration: 45; easing.type: Easing.OutQuad } }

            Rectangle {
                width: parent.width * 0.75; height: 5; radius: 2.5; color: "#FB7185"
                anchors.horizontalCenter: parent.horizontalCenter
                anchors.bottom: parent.bottom; anchors.bottomMargin: -2
                x: mouthRoot.tongueVibrate
                Rectangle { width: 1; height: 3; color: "#E11D48"; anchors.centerIn: parent }
            }
        }
    }
}
