import QtQuick

Item {
    id: torsoRoot
    property string dogState: "active"; property bool isBarking: false
    property real chestPuff: 1.0; property real squashY: 1.0; property real legStride: 0
    property real legLiftLeft: 0; property real legLiftRight: 0
    width: 80; height: 54

    SequentialAnimation {
        running: torsoRoot.dogState === "intro"; loops: Animation.Infinite
        NumberAnimation { target: torsoRoot; property: "legStride"; to: 6; duration: 120 }
        NumberAnimation { target: torsoRoot; property: "legStride"; to: -6; duration: 120 }
    }

    // 1. Chân sau (Hind legs - 3D depth layer z: -2)
    Row {
        anchors.horizontalCenter: torsoRect.horizontalCenter
        anchors.bottom: torsoRect.bottom; anchors.bottomMargin: -2; z: -2
        spacing: torsoRoot.dogState === "lying" || torsoRoot.dogState === "sleeping" ? 34 : (torsoRoot.dogState === "sitting" ? 28 : 22)
        visible: torsoRoot.dogState !== "intro"
        Repeater {
            model: 2
            Rectangle {
                width: torsoRoot.dogState === "sitting" ? 12 : 9
                height: torsoRoot.dogState === "lying" || torsoRoot.dogState === "sleeping" ? 7 : (torsoRoot.dogState === "sitting" ? 14 : 10)
                radius: 4; color: "#BA4A00"; border.color: "#873600"; border.width: 1
                Rectangle { width: parent.width * 0.8; height: 3; radius: 1.5; color: "#FFFFFF"; anchors.bottom: parent.bottom; anchors.horizontalCenter: parent.horizontalCenter }
            }
        }
    }

    // 2. Khớp đuôi nâng cao lên và dời sang phải một chút (gắn khít mông)
    DogTail {
        dogState: torsoRoot.dogState; isBarking: torsoRoot.isBarking
        anchors.bottom: torsoRect.bottom; anchors.right: torsoRect.left; z: -1
        anchors.rightMargin: torsoRoot.dogState === "sleeping" ? -9 : -12
        anchors.bottomMargin: torsoRoot.dogState === "sleeping" ? 6 : (torsoRoot.dogState === "sitting" ? 8 : 12)
    }

    // 3. Thân mình 3D với bóng đổ và highlight
    Rectangle {
        id: torsoRect
        width: torsoRoot.dogState === "lying" || torsoRoot.dogState === "sleeping" ? 54 : (torsoRoot.dogState === "sitting" ? 42 : 38)
        height: (torsoRoot.dogState === "lying" || torsoRoot.dogState === "sleeping" ? 22 : (torsoRoot.dogState === "sitting" ? 32 : 36)) * torsoRoot.squashY
        radius: torsoRoot.dogState === "lying" || torsoRoot.dogState === "sleeping" ? 11 : 16
        color: "#E59866"; border.color: "#A04000"; border.width: 1.2
        anchors.horizontalCenter: parent.horizontalCenter; anchors.bottom: parent.bottom; anchors.bottomMargin: 4
        scale: torsoRoot.chestPuff

        // Đổ bóng đáy thân mình
        Rectangle { anchors.bottom: parent.bottom; anchors.horizontalCenter: parent.horizontalCenter; width: parent.width * 0.9; height: 4; radius: 2; color: "#935116"; opacity: 0.35 }
        // Đốm trắng ở ngực nhỏ gọn, nổi khối 3D có độ bóng mượt mà (Glossy 3D Chest Patch)
        Rectangle {
            id: chestBib; radius: width / 2; color: "#FFFFFF"; anchors.horizontalCenter: parent.horizontalCenter
            width: torsoRoot.dogState === "lying" || torsoRoot.dogState === "sleeping" ? 18 : 13
            height: parent.height * (torsoRoot.dogState === "lying" ? 0.52 : 0.56)
            anchors.bottom: parent.bottom; anchors.bottomMargin: 3
            Rectangle { anchors.fill: parent; anchors.margins: -1.2; z: -1; radius: parent.radius + 1.2; color: "#C66D35"; opacity: 0.45 }
            Rectangle { anchors.top: parent.top; anchors.topMargin: 1.5; x: 2.5; width: parent.width * 0.45; height: 3; radius: 1.5; color: "#FFFFFF"; opacity: 0.95 }
            Rectangle { anchors.bottom: parent.bottom; anchors.horizontalCenter: parent.horizontalCenter; width: parent.width * 0.7; height: 2; radius: 1; color: "#E0D0C5"; opacity: 0.75 }
        }
        // Vòng cổ da thời trang tích hợp thẻ tên BAM (nằm trên ức ngực, tránh cằm che)
        DogNameTag {
            dogState: torsoRoot.dogState; chestPuff: torsoRoot.chestPuff
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.top: parent.top
            anchors.topMargin: torsoRoot.dogState === "lying" || torsoRoot.dogState === "sleeping" ? 5 : (torsoRoot.dogState === "sitting" ? 5 : 4); z: 3
        }
    }

    // 4. Hai chân trước 3D chuyên sâu (Forelegs & Paws)
    DogFrontPaws {
        dogState: torsoRoot.dogState
        legLiftLeft: torsoRoot.legLiftLeft; legLiftRight: torsoRoot.legLiftRight; legStride: torsoRoot.legStride
        anchors.horizontalCenter: torsoRect.horizontalCenter; anchors.bottom: parent.bottom; z: 1
    }
}
