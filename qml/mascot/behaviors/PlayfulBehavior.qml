import QtQuick

Item {
    id: playfulRoot
    property var mascotRig: null
    property string dogState: "active"

    Timer {
        id: randomPlayTimer
        interval: Math.floor(Math.random() * 5000) + 7000
        repeat: true
        running: playfulRoot.dogState === "active" || playfulRoot.dogState === "sitting"
        onTriggered: {
            if (playfulRoot.mascotRig && !playfulRoot.mascotRig.isTrackingMouse &&
                !playfulRoot.mascotRig.isBarking && pawActionAnim.running === false && jumpAndBarkAnim.running === false) {
                // 35% xác suất nhảy cao nhún người rồi sủa, 65% xác suất giơ 1 chân nghiêng đầu
                if (Math.random() < 0.35) {
                    jumpAndBarkAnim.restart();
                } else {
                    var isLeft = Math.random() < 0.5;
                    playfulRoot.mascotRig.isLeftPawAction = isLeft;
                    tiltAnim.to = isLeft ? -20 : 20;
                    pawActionAnim.restart();
                }
            }
            interval = Math.floor(Math.random() * 5000) + 7000;
        }
    }

    // 1. Hoạt cảnh giơ 1 chân + đầu nghiêng sâu ngộ nghĩnh chuẩn Disney (Squash & Arcs)
    SequentialAnimation {
        id: pawActionAnim
        ParallelAnimation {
            NumberAnimation { target: playfulRoot.mascotRig; property: "randomPawLift"; to: 15; duration: 240; easing.type: Easing.OutBack }
            NumberAnimation { id: tiltAnim; target: playfulRoot.mascotRig; property: "headTilt"; duration: 240; easing.type: Easing.OutBack }
            NumberAnimation { target: playfulRoot.mascotRig; property: "squashY"; to: 1.08; duration: 240; easing.type: Easing.OutSine }
        }
        PauseAnimation { duration: 650 }
        ParallelAnimation {
            NumberAnimation { target: playfulRoot.mascotRig; property: "randomPawLift"; to: 0; duration: 200; easing.type: Easing.InOutQuad }
            NumberAnimation { target: playfulRoot.mascotRig; property: "headTilt"; to: 0; duration: 200; easing.type: Easing.InOutQuad }
            NumberAnimation { target: playfulRoot.mascotRig; property: "squashY"; to: 1.0; duration: 200; easing.type: Easing.InOutQuad }
        }
    }

    // 2. Combo Disney: Nhún người (Anticipation) -> Nhảy cao dơ 2 chân -> Rơi xuống nhún -> Sủa gâu
    SequentialAnimation {
        id: jumpAndBarkAnim
        ScriptAction { script: if (playfulRoot.mascotRig) playfulRoot.mascotRig.jumpAndBounce() }
        PauseAnimation { duration: 650 } // Chờ tiếp đất đàn hồi xong
        ScriptAction { script: if (playfulRoot.mascotRig) playfulRoot.mascotRig.bark() }
    }
}
