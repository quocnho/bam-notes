import QtQuick

Item {
    id: hoverSequenceRoot
    property var mascotRig: null
    property bool isHoverActive: false
    property string dogState: "active"
    property bool isBeingPetted: false

    function triggerHoverFlow() {
        if (!mascotRig || isActionRunning() || isBeingPetted || dogState === "lying") return;
        performRandomAction();
    }

    function isActionRunning() {
        return hoverTimeline.running || onePawAnim.running || (mascotRig && mascotRig.isBarking);
    }

    function performRandomAction() {
        if (!mascotRig || isBeingPetted || dogState === "lying") return;
        var isTwoLegs = Math.random() < 0.4;
        if (isTwoLegs) {
            hoverTimeline.restart();
            mascotRig.jumpAndBounce();
            mascotRig.bark(false);
        } else {
            // Giơ 1 chân êm ái, tò mò, đứng vững chãi không rung bần bật
            var isLeft = Math.random() < 0.5;
            mascotRig.isLeftPawAction = isLeft;
            onePawAnim.restart();
        }
    }

    Timer {
        id: playfulLoopTimer
        interval: Math.floor(Math.random() * 1400) + 2800
        repeat: true
        running: hoverSequenceRoot.isHoverActive &&
                 !hoverSequenceRoot.isBeingPetted &&
                 hoverSequenceRoot.dogState === "active"
        onTriggered: {
            if (!hoverSequenceRoot.isActionRunning()) {
                hoverSequenceRoot.performRandomAction();
            }
            interval = Math.floor(Math.random() * 1400) + 2800;
        }
    }

    SequentialAnimation {
        id: hoverTimeline
        PauseAnimation { duration: 800 }
    }

    // Hoạt cảnh giơ 1 chân chào mềm mại, đầu nghiêng tò mò tự nhiên chuẩn Disney
    SequentialAnimation {
        id: onePawAnim
        ParallelAnimation {
            NumberAnimation { target: mascotRig; property: "randomPawLift"; to: 12; duration: 280; easing.type: Easing.OutBack }
            NumberAnimation { target: mascotRig; property: "headTilt"; to: mascotRig && mascotRig.isLeftPawAction ? -12 : 12; duration: 280; easing.type: Easing.OutQuad }
        }
        PauseAnimation { duration: 550 }
        ParallelAnimation {
            NumberAnimation { target: mascotRig; property: "randomPawLift"; to: 0; duration: 240; easing.type: Easing.InOutSine }
            NumberAnimation { target: mascotRig; property: "headTilt"; to: 0; duration: 240; easing.type: Easing.InOutSine }
        }
    }
}
