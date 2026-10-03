import QtQuick

Item {
    id: eyesRoot
    property string dogState: "active"
    property real gazeX: 0; property real gazeY: 0
    property bool isBlinking: false; property bool isTrackingMouse: false
    width: 38; height: 16

    Behavior on gazeX { NumberAnimation { duration: 90; easing.type: Easing.OutQuad } }
    Behavior on gazeY { NumberAnimation { duration: 90; easing.type: Easing.OutQuad } }

    SequentialAnimation {
        running: eyesRoot.dogState !== "sleeping" && !eyesRoot.isTrackingMouse; loops: Animation.Infinite
        PauseAnimation { duration: 2500 }
        ScriptAction { script: { eyesRoot.gazeX = 1.4; eyesRoot.gazeY = -0.5 } }
        PauseAnimation { duration: 1800 }
        ScriptAction { script: { eyesRoot.gazeX = -1.4; eyesRoot.gazeY = 0.4 } }
        PauseAnimation { duration: 2200 }
        ScriptAction { script: { eyesRoot.gazeX = 0; eyesRoot.gazeY = 0 } }
    }

    Timer { interval: 3500; running: eyesRoot.dogState !== "sleeping"; repeat: true; onTriggered: blinkAnim.restart() }
    SequentialAnimation {
        id: blinkAnim
        ScriptAction { script: eyesRoot.isBlinking = true }
        PauseAnimation { duration: 110 }
        ScriptAction { script: eyesRoot.isBlinking = false }
    }

    component DetailedEyeUnit: Item {
        width: 14; height: 15
        readonly property bool isSleeping: eyesRoot.dogState === "sleeping" || eyesRoot.dogState === "lying" || eyesRoot.isBlinking

        // Mí mắt nhắm cong mềm mại khi ngủ
        Item {
            anchors.centerIn: parent; width: 13; height: 7; visible: parent.isSleeping
            Rectangle {
                anchors.centerIn: parent; width: 12; height: 7; radius: 3.5
                color: "transparent"; border.color: "#1E293B"; border.width: 1.8; clip: true
                Rectangle { width: 14; height: 5; y: 3.2; color: "#E59866"; anchors.horizontalCenter: parent.horizontalCenter }
            }
        }

        // Đôi mắt xám đen hoạt hình long lanh (Charcoal Slate Eyes)
        Rectangle {
            anchors.centerIn: parent; width: parent.width; height: parent.height
            radius: width / 2; color: "#FFFFFF"; border.color: "#0F172A"; border.width: 1.2
            visible: !parent.isSleeping; clip: true

            Rectangle {
                width: 9.5; height: 9.5; radius: width / 2; color: "#1E293B"
                x: 2.25 + eyesRoot.gazeX; y: 2.75 + eyesRoot.gazeY
                Rectangle {
                    anchors.centerIn: parent; width: parent.width * 0.88; height: parent.height * 0.88
                    radius: width / 2; color: "#334155"
                    Rectangle {
                        anchors.centerIn: parent; width: parent.width * 0.72; height: parent.height * 0.72
                        radius: width / 2; color: "#020617"
                        Rectangle {
                            width: 2.8; height: 2.8; radius: 1.4; color: "#FFFFFF"
                            anchors.right: parent.right; anchors.top: parent.top; anchors.margins: 0.5
                        }
                        Rectangle {
                            width: 1.4; height: 1.4; radius: 0.7; color: "#FFFFFF"; opacity: 0.9
                            anchors.left: parent.left; anchors.bottom: parent.bottom; anchors.margins: 0.6
                        }
                    }
                }
            }
        }
    }

    Row {
        anchors.centerIn: parent; spacing: 7
        DetailedEyeUnit { id: leftEye }
        DetailedEyeUnit { id: rightEye }
    }
}
