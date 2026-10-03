import QtQuick

Item {
    id: hoverSequenceRoot
    property var mascotRig: null

    function triggerHoverFlow() {
        if (!mascotRig || hoverTimeline.running) return;
        hoverTimeline.restart();
    }

    SequentialAnimation {
        id: hoverTimeline
        // Giai đoạn 1: Giơ 1 chân chào (Anticipation / Secondary Action)
        ParallelAnimation {
            NumberAnimation { target: mascotRig; property: "randomPawLift"; to: 9; duration: 180; easing.type: Easing.OutBack }
            NumberAnimation { target: mascotRig; property: "headTilt"; to: 6; duration: 180; easing.type: Easing.OutQuad }
        }
        PauseAnimation { duration: 250 }
        // Giai đoạn 2: Hạ 1 chân xuống để chuẩn bị nhún bật nhảy 2 chân
        ParallelAnimation {
            NumberAnimation { target: mascotRig; property: "randomPawLift"; to: 0; duration: 120; easing.type: Easing.InOutQuad }
            NumberAnimation { target: mascotRig; property: "headTilt"; to: 0; duration: 120; easing.type: Easing.InOutQuad }
        }
        // Giai đoạn 3: Bật nhảy 2 chân lên (JumpBounceAnimationFlow)
        ScriptAction {
            script: if (mascotRig) mascotRig.jumpAndBounce()
        }
    }
}
