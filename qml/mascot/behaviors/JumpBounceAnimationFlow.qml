import QtQuick

Item {
    id: jumpFlowRoot
    property var target: null
    signal finished()

    function play() {
        jumpTimeline.restart();
    }

    SequentialAnimation {
        id: jumpTimeline
        // 1. Chuẩn bị bật nhảy (Anticipation / Co chân nhún xuống)
        ParallelAnimation {
            NumberAnimation { target: jumpFlowRoot.target; property: "squashY"; to: 0.78; duration: 95; easing.type: Easing.InQuad }
            NumberAnimation { target: jumpFlowRoot.target; property: "jumpY"; to: 5; duration: 95; easing.type: Easing.InQuad }
        }
        // 2. Bật nhảy cao lên, 2 chân giơ lên (dơ lên 2 chân và nhún mạnh)
        ParallelAnimation {
            NumberAnimation { target: jumpFlowRoot.target; property: "jumpY"; to: -22; duration: 170; easing.type: Easing.OutQuad }
            NumberAnimation { target: jumpFlowRoot.target; property: "squashY"; to: 1.22; duration: 170; easing.type: Easing.OutQuad }
            NumberAnimation { target: jumpFlowRoot.target; property: "bothPawsLift"; to: 13; duration: 130; easing.type: Easing.OutBack }
            NumberAnimation { target: jumpFlowRoot.target; property: "headTilt"; to: -10; duration: 150; easing.type: Easing.OutQuad }
        }
        // 3. Rơi xuống tiếp đất (Nhún một nhún)
        ParallelAnimation {
            NumberAnimation { target: jumpFlowRoot.target; property: "jumpY"; to: 4; duration: 140; easing.type: Easing.InQuad }
            NumberAnimation { target: jumpFlowRoot.target; property: "squashY"; to: 0.82; duration: 140; easing.type: Easing.OutQuad }
        }
        // 4. Nhún nhẹ đàn hồi (Secondary Bounce / Overlapping Action)
        ParallelAnimation {
            NumberAnimation { target: jumpFlowRoot.target; property: "jumpY"; to: -5; duration: 110; easing.type: Easing.OutQuad }
            NumberAnimation { target: jumpFlowRoot.target; property: "squashY"; to: 1.06; duration: 110; easing.type: Easing.OutQuad }
        }
        // 5. Trả về trạng thái bình thường êm ái
        ParallelAnimation {
            NumberAnimation { target: jumpFlowRoot.target; property: "jumpY"; to: 0; duration: 130; easing.type: Easing.OutSine }
            NumberAnimation { target: jumpFlowRoot.target; property: "squashY"; to: 1.0; duration: 130; easing.type: Easing.OutSine }
            NumberAnimation { target: jumpFlowRoot.target; property: "bothPawsLift"; to: 0; duration: 150; easing.type: Easing.OutQuad }
            NumberAnimation { target: jumpFlowRoot.target; property: "headTilt"; to: 0; duration: 150; easing.type: Easing.OutQuad }
        }
        ScriptAction { script: jumpFlowRoot.finished() }
    }
}
