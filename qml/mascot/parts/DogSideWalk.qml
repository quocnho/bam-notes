import QtQuick

Item {
    id: sideWalkRoot
    width: 84; height: 60
    property real legWalkPhase: 0; property real tailWagSide: 0

    // Bước chân nhịp nhàng & Đuôi uốn lượn khi đi ngang (Disney Principles)
    SequentialAnimation {
        running: true; loops: Animation.Infinite
        NumberAnimation { target: sideWalkRoot; property: "legWalkPhase"; to: 12; duration: 130; easing.type: Easing.InOutQuad }
        NumberAnimation { target: sideWalkRoot; property: "legWalkPhase"; to: -12; duration: 130; easing.type: Easing.InOutQuad }
    }
    SequentialAnimation {
        running: true; loops: Animation.Infinite
        NumberAnimation { target: sideWalkRoot; property: "tailWagSide"; to: 28; duration: 110; easing.type: Easing.InOutSine }
        NumberAnimation { target: sideWalkRoot; property: "tailWagSide"; to: -18; duration: 110; easing.type: Easing.InOutSine }
    }

    // Đuôi phía sau (hướng phải)
    Item {
        x: 62; y: 16; width: 14; height: 20; transformOrigin: Item.BottomLeft
        rotation: 35 + sideWalkRoot.tailWagSide
        Rectangle { width: 6; height: 16; radius: 3; color: "#D35400"; border.color: "#A04000"; border.width: 1 }
        Rectangle { width: 8; height: 9; radius: 4; color: "#FFFFFF"; anchors.top: parent.top }
    }

    // Chân xa (bên trong)
    Rectangle {
        x: 52; y: 38 + sideWalkRoot.legWalkPhase * 0.5; width: 8; height: 16; radius: 4
        color: "#D35400"; border.color: "#BA4A00"; border.width: 1; z: -1
    }
    Rectangle {
        x: 20; y: 38 - sideWalkRoot.legWalkPhase * 0.5; width: 8; height: 16; radius: 4
        color: "#D35400"; border.color: "#BA4A00"; border.width: 1; z: -1
    }

    // Thân mình góc nhìn ngang (dáng thon gọn, lưng cong)
    Rectangle {
        x: 18; y: 18; width: 48; height: 26; radius: 13
        color: "#E59866"; border.color: "#BA4A00"; border.width: 1.2
        Rectangle { width: 34; height: 12; radius: 6; color: "#FFFFFF"; anchors.bottom: parent.bottom; anchors.bottomMargin: 2; x: 6 }
        Rectangle { width: 12; height: 8; radius: 4; color: "#BA4A00"; x: 26; y: 2; opacity: 0.85 }
    }

    // Chân gần (bên ngoài)
    Rectangle {
        x: 48; y: 38 - sideWalkRoot.legWalkPhase; width: 9; height: 18; radius: 4.5
        color: "#FFFFFF"; border.color: "#D5D8DC"; border.width: 1
    }
    Rectangle {
        x: 16; y: 38 + sideWalkRoot.legWalkPhase; width: 9; height: 18; radius: 4.5
        color: "#FFFFFF"; border.color: "#D5D8DC"; border.width: 1
    }

    // Đầu góc nhìn ngang (hướng sang trái đón chủ)
    Item {
        x: 4; y: 6; width: 28; height: 32
        Rectangle {
            x: 14; y: 2; width: 14; height: 22; radius: 7; color: "#C66900"
            border.color: "#A04000"; border.width: 1
            transformOrigin: Item.TopLeft; rotation: 16 + sideWalkRoot.legWalkPhase * 0.4
        }
        Rectangle {
            x: 4; y: 6; width: 22; height: 22; radius: 11; color: "#EDBB99"
            Rectangle {
                x: -5; y: 9; width: 12; height: 10; radius: 5; color: "#FFFFFF"
                Rectangle { x: -2; y: 2; width: 4; height: 3; radius: 1.5; color: "#1C2833" }
            }
            Rectangle {
                x: 3; y: 5; width: 6; height: 7; radius: 3; color: "#1C2833"
                Rectangle { width: 2.5; height: 2.5; radius: 1.25; color: "#FFFFFF"; x: 1; y: 1 }
            }
        }
    }
}
