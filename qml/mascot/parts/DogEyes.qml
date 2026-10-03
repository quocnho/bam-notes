import QtQuick

Item {
    id: eyesRoot
    property string dogState: "active"
    property real gazeX: 0; property real gazeY: 0; property bool isBlinking: false
    property bool isTrackingMouse: false
    width: 34; height: 14

    Behavior on gazeX { NumberAnimation { duration: 90; easing.type: Easing.OutQuad } }
    Behavior on gazeY { NumberAnimation { duration: 90; easing.type: Easing.OutQuad } }

    SequentialAnimation {
        running: eyesRoot.dogState !== "sleeping" && !eyesRoot.isTrackingMouse; loops: Animation.Infinite
        PauseAnimation { duration: 2400 }
        ScriptAction { script: { eyesRoot.gazeX = 1.8; eyesRoot.gazeY = -0.8 } }
        PauseAnimation { duration: 1600 }
        ScriptAction { script: { eyesRoot.gazeX = -1.8; eyesRoot.gazeY = 0.5 } }
        PauseAnimation { duration: 2200 }
        ScriptAction { script: { eyesRoot.gazeX = 0; eyesRoot.gazeY = 0 } }
    }

    Timer { interval: 3600; running: eyesRoot.dogState !== "sleeping"; repeat: true; onTriggered: blinkAnim.restart() }
    SequentialAnimation {
        id: blinkAnim
        ScriptAction { script: eyesRoot.isBlinking = true }
        PauseAnimation { duration: 110 }
        ScriptAction { script: eyesRoot.isBlinking = false }
    }

    component EyeUnit: Item {
        width: 12; height: 13
        readonly property bool isSleeping: eyesRoot.dogState === "sleeping" || eyesRoot.dogState === "lying" || eyesRoot.isBlinking

        // 1. Mí mắt nhắm cong mềm mại dễ thương khi ngủ (Cute curved sleepy eye)
        Item {
            anchors.centerIn: parent; width: 12; height: 6; visible: parent.isSleeping
            // Đường cong mí mắt hình vòng cung dịu dàng
            Rectangle {
                anchors.centerIn: parent; width: 11; height: 6; radius: 3
                color: "transparent"; border.color: "#3A2010"; border.width: 1.8
                clip: true
                Rectangle { width: 13; height: 4; y: 2.8; color: "#E59866"; anchors.horizontalCenter: parent.horizontalCenter }
            }
            // Điểm nhấn đuôi mắt cong nhẹ
            Rectangle { width: 2; height: 1.5; radius: 0.75; color: "#3A2010"; anchors.right: parent.right; anchors.top: parent.top; anchors.topMargin: 0.5 }
        }

        // 2. Mắt tròn lúng liếng khi thức
        Rectangle {
            anchors.centerIn: parent; width: parent.width
            height: eyesRoot.dogState === "lying" ? 5 : (eyesRoot.dogState === "sitting" ? 13 : 12)
            radius: 6; color: "#182026"; border.color: "#0F141A"; border.width: 1
            visible: !parent.isSleeping
            Behavior on height { NumberAnimation { duration: 80 } }

            Rectangle {
                width: 4.8; height: 4.8; radius: 2.4; color: "#FFFFFF"
                x: Math.max(1.5, Math.min(parent.width - width - 1.5, 3.5 + eyesRoot.gazeX))
                y: Math.max(1.5, Math.min(parent.height - height - 1.5, 2.5 + eyesRoot.gazeY))
                Rectangle { width: 2.4; height: 2.4; radius: 1.2; color: "#0B1014"; anchors.centerIn: parent }
            }
            Rectangle {
                width: 2; height: 2; radius: 1; color: "#FFFFFF"
                anchors.right: parent.right; anchors.top: parent.top; anchors.margins: 2; opacity: 0.85
            }
        }
    }

    Row {
        anchors.centerIn: parent; spacing: 10
        EyeUnit { id: leftEye }
        EyeUnit { id: rightEye }
    }
}
