import QtQuick

Item {
    id: earsRoot
    property string dogState: "active"
    property real earTwitch: 0; property real earFlap: 0
    width: 60; height: 38

    Timer {
        interval: 2600; running: earsRoot.dogState !== "sleeping"; repeat: true
        onTriggered: earTwitchAnim.restart()
    }

    SequentialAnimation {
        id: earTwitchAnim
        NumberAnimation { target: earsRoot; property: "earTwitch"; to: -8; duration: 75; easing.type: Easing.OutQuad }
        NumberAnimation { target: earsRoot; property: "earTwitch"; to: 10; duration: 85; easing.type: Easing.InOutQuad }
        NumberAnimation { target: earsRoot; property: "earTwitch"; to: 0; duration: 90; easing.type: Easing.OutQuad }
    }

    // Tai cụp / vểnh dáng chó đặc trưng (dáng dài tam giác bo tròn, rủ xuống 2 bên má)
    component DogEarPart: Item {
        width: 16; height: 32
        property bool isLeft: true
        property real baseRot: isLeft ?
            (earsRoot.dogState === "sleeping" ? -48 : (earsRoot.dogState === "sitting" ? -18 : -26)) :
            (earsRoot.dogState === "sleeping" ? 48 : (earsRoot.dogState === "sitting" ? 18 : 26))

        transformOrigin: isLeft ? Item.TopRight : Item.TopLeft
        rotation: baseRot + (isLeft ? (earsRoot.earTwitch + earsRoot.earFlap) : (-earsRoot.earTwitch * 0.8 - earsRoot.earFlap))
        Behavior on rotation { NumberAnimation { duration: 180; easing.type: Easing.OutBack } }

        // Vành tai ngoài dáng chó (tam giác bo tròn rủ xuống má)
        Rectangle {
            width: parent.width; height: parent.height
            radius: 8; color: "#C66900"; border.color: "#8A3B00"; border.width: 1.2
            // Đổ bóng 3D mặt trong nếp gấp tai
            Rectangle {
                width: 3; height: parent.height * 0.7; radius: 1.5; color: "#6E2C00"; opacity: 0.4
                anchors.right: isLeft ? parent.right : undefined
                anchors.left: isLeft ? undefined : parent.left
                anchors.top: parent.top; anchors.topMargin: 4
            }
            // Lòng tai hồng mềm mại
            Rectangle {
                width: 7; height: 20; radius: 3.5; color: "#F5CBA7"; opacity: 0.8
                anchors.centerIn: parent
            }
        }
    }

    DogEarPart { id: leftEar; isLeft: true; x: 2; y: 2 }
    DogEarPart { id: rightEar; isLeft: false; x: 42; y: 2 }
}
