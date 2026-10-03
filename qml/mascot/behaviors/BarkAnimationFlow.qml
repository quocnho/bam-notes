import QtQuick

Item {
    id: animRoot
    property var target: null
    property var barkBubble: null
    property bool showBubble: false
    signal barkFinished()

    function play(bubble) {
        if (typeof bubble === "boolean") showBubble = bubble;
        barkTimeline.restart();
    }

    // Hoạt cảnh sủa mượt mà chuẩn Disney: Nhịp nhàng mở miệng, không co giật bần bật
    SequentialAnimation {
        id: barkTimeline
        // 1. Há miệng ngửa đầu đón hơi (Anticipation)
        ParallelAnimation {
            ScriptAction { script: if (target) target.isBarking = true }
            NumberAnimation { target: animRoot.target; property: "headTilt"; to: -8; duration: 90; easing.type: Easing.OutQuad }
            NumberAnimation { target: animRoot.target; property: "chestPuff"; to: 1.06; duration: 90; easing.type: Easing.OutQuad }
            NumberAnimation { target: animRoot.target; property: "earFlap"; to: -5; duration: 90; easing.type: Easing.OutQuad }
        }
        // 2. Cất tiếng sủa thân thiện (Gâu)
        ParallelAnimation {
            ScriptAction { script: if (barkBubble && showBubble) barkBubble.visible = true }
            NumberAnimation { target: animRoot.target; property: "headTilt"; to: 2; duration: 110; easing.type: Easing.InOutQuad }
            NumberAnimation { target: animRoot.target; property: "chestPuff"; to: 0.98; duration: 110; easing.type: Easing.InOutQuad }
            NumberAnimation { target: animRoot.target; property: "earFlap"; to: 4; duration: 110; easing.type: Easing.InOutQuad }
        }
        // 3. Trở về trạng thái bình thường êm ái (Follow Through)
        ParallelAnimation {
            NumberAnimation { target: animRoot.target; property: "headTilt"; to: 0; duration: 150; easing.type: Easing.OutSine }
            NumberAnimation { target: animRoot.target; property: "chestPuff"; to: 1.0; duration: 150; easing.type: Easing.OutSine }
            NumberAnimation { target: animRoot.target; property: "earFlap"; to: 0; duration: 150; easing.type: Easing.OutSine }
        }
        PauseAnimation { duration: 300 }
        ScriptAction {
            script: {
                if (target) target.isBarking = false;
                if (barkBubble) barkBubble.visible = false;
                animRoot.barkFinished();
            }
        }
    }
}
