import QtQuick

Item {
    id: animRoot
    property var target: null
    property var barkBubble: null
    signal barkFinished()

    function play() {
        barkTimeline.restart();
    }

    // Hoạt cảnh sủa Gâu gâu: Há ngậm miệng nhanh nhịp kép (Double Snap)
    SequentialAnimation {
        id: barkTimeline
        // 1. Chuẩn bị phồng ngực & ngửa đầu há to (Tiếng 1)
        ParallelAnimation {
            ScriptAction { script: if (target) target.isBarking = true }
            NumberAnimation { target: animRoot.target; property: "headTilt"; to: -12; duration: 60; easing.type: Easing.OutQuad }
            NumberAnimation { target: animRoot.target; property: "chestPuff"; to: 1.1; duration: 60; easing.type: Easing.OutQuad }
            NumberAnimation { target: animRoot.target; property: "squashY"; to: 1.05; duration: 60; easing.type: Easing.OutQuad }
        }
        // 2. Đóng sập miệng nhanh (Gâu 1)
        ParallelAnimation {
            ScriptAction { script: if (barkBubble) barkBubble.visible = true }
            NumberAnimation { target: animRoot.target; property: "headTilt"; to: 4; duration: 45; easing.type: Easing.OutBounce }
            NumberAnimation { target: animRoot.target; property: "chestPuff"; to: 0.95; duration: 45; easing.type: Easing.OutBounce }
            NumberAnimation { target: animRoot.target; property: "squashY"; to: 0.92; duration: 45; easing.type: Easing.OutBounce }
        }
        // 3. Há nhanh tiếp (Tiếng 2)
        ParallelAnimation {
            NumberAnimation { target: animRoot.target; property: "headTilt"; to: -10; duration: 50; easing.type: Easing.OutQuad }
            NumberAnimation { target: animRoot.target; property: "chestPuff"; to: 1.08; duration: 50; easing.type: Easing.OutQuad }
        }
        // 4. Đóng sập miệng nhanh (Gâu 2)
        ParallelAnimation {
            NumberAnimation { target: animRoot.target; property: "headTilt"; to: 2; duration: 45; easing.type: Easing.OutBounce }
            NumberAnimation { target: animRoot.target; property: "chestPuff"; to: 0.96; duration: 45; easing.type: Easing.OutBounce }
        }
        // 5. Trở lại trạng thái bình thường mượt mà
        ParallelAnimation {
            NumberAnimation { target: animRoot.target; property: "headTilt"; to: 0; duration: 140; easing.type: Easing.OutBack }
            NumberAnimation { target: animRoot.target; property: "chestPuff"; to: 1.0; duration: 140; easing.type: Easing.OutBack }
            NumberAnimation { target: animRoot.target; property: "squashY"; to: 1.0; duration: 140; easing.type: Easing.OutBack }
        }
        PauseAnimation { duration: 400 }
        ScriptAction {
            script: {
                if (target) target.isBarking = false;
                if (barkBubble) barkBubble.visible = false;
                animRoot.barkFinished();
            }
        }
    }
}
