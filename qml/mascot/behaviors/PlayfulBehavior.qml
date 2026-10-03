import QtQuick

Item {
    id: playfulRoot
    property var mascotRig: null
    property string dogState: "active"

    property bool lastPawLeft: false

    Timer {
        id: randomPlayTimer
        interval: Math.floor(Math.random() * 2500) + 3500
        repeat: true
        running: playfulRoot.dogState === "active" || playfulRoot.dogState === "sitting"
        onTriggered: {
            if (playfulRoot.mascotRig && !playfulRoot.mascotRig.isHovered &&
                !playfulRoot.mascotRig.isBarking && !pawActionAnim.running && !jumpAndBarkAnim.running) {
                // 25% xác suất nhảy sủa mừng, 75% xác suất luân phiên dơ 1 chân đỡ mỏi + nghiêng đầu
                if (Math.random() < 0.25) {
                    jumpAndBarkAnim.restart();
                } else {
                    playfulRoot.lastPawLeft = !playfulRoot.lastPawLeft;
                    playfulRoot.mascotRig.isLeftPawAction = playfulRoot.lastPawLeft;
                    tiltAnim.to = playfulRoot.lastPawLeft ? -18 : 18;
                    pawActionAnim.restart();
                }
            }
            interval = Math.floor(Math.random() * 2500) + 3500;
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
