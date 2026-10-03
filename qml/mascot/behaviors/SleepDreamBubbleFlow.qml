import QtQuick

Item {
    id: dreamRoot
    width: 82; height: 48
    property bool active: false
    visible: active; opacity: active ? 1.0 : 0.0
    Behavior on opacity { NumberAnimation { duration: 320 } }

    // Dải sương mây mỏng rộng, ngẫu nhiên lơ lửng bồng bềnh
    Item {
        id: cloudCluster
        anchors.horizontalCenter: parent.horizontalCenter
        y: 14; width: 72; height: 16
        SequentialAnimation on x {
            running: dreamRoot.active; loops: Animation.Infinite
            NumberAnimation { to: cloudCluster.x + 3.0; duration: 2400; easing.type: Easing.InOutSine }
            NumberAnimation { to: cloudCluster.x - 3.0; duration: 2400; easing.type: Easing.InOutSine }
        }
        Repeater {
            model: [
                { cx: 0,  cy: 4, cw: 24, ch: 11, op: 0.16 },
                { cx: 16, cy: 1, cw: 28, ch: 14, op: 0.22 },
                { cx: 36, cy: 3, cw: 26, ch: 13, op: 0.20 },
                { cx: 52, cy: 5, cw: 20, ch: 10, op: 0.14 },
                { cx: 24, cy: 6, cw: 22, ch: 9,  op: 0.18 }
            ]
            Rectangle {
                x: modelData.cx; y: modelData.cy; width: modelData.cw; height: modelData.ch
                radius: height / 2; color: "#E0F2FE"
                border.color: "#BAE6FD"; border.width: 0.5
                opacity: modelData.op
            }
        }
    }

    // Ký tự Z bay lượn ngẫu nhiên nhẹ nhàng qua dải sương mây
    Repeater {
        model: [
            { text: "z", size: 9.0,  startX: 28, endX: 24, startY: 36, endY: 12, dur: 2200, delay: 0 },
            { text: "z", size: 11.5, startX: 42, endX: 46, startY: 32, endY: 6,  dur: 2500, delay: 750 },
            { text: "Z", size: 14.5, startX: 52, endX: 58, startY: 28, endY: -2, dur: 2700, delay: 1500 }
        ]
        Text {
            id: zLetter
            text: modelData.text; font.pixelSize: modelData.size; font.bold: true
            font.family: "Monospace"; color: "#38BDF8"
            x: modelData.startX; y: modelData.startY; opacity: 0
            SequentialAnimation {
                running: dreamRoot.active; loops: Animation.Infinite
                PauseAnimation { duration: modelData.delay }
                ParallelAnimation {
                    NumberAnimation { target: zLetter; property: "y"; from: modelData.startY; to: modelData.endY; duration: modelData.dur; easing.type: Easing.OutSine }
                    SequentialAnimation {
                        NumberAnimation { target: zLetter; property: "x"; to: (modelData.startX + modelData.endX) / 2 + 3; duration: modelData.dur * 0.5; easing.type: Easing.InOutSine }
                        NumberAnimation { target: zLetter; property: "x"; to: modelData.endX; duration: modelData.dur * 0.5; easing.type: Easing.InOutSine }
                    }
                    SequentialAnimation {
                        NumberAnimation { target: zLetter; property: "opacity"; from: 0; to: 0.60; duration: modelData.dur * 0.35 }
                        NumberAnimation { target: zLetter; property: "opacity"; from: 0.60; to: 0; duration: modelData.dur * 0.65 }
                    }
                }
            }
        }
    }
}
