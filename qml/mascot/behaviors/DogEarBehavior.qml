import QtQuick

Item {
    id: earsAnimRoot
    property var earsTarget: null
    property bool isSleeping: false

    Timer {
        interval: 2800; running: !earsAnimRoot.isSleeping; repeat: true
        onTriggered: {
            var r = Math.random();
            if (r < 0.28) {
                halfFoldAnim.restart();     // Cụp 1 nửa tai ngộ nghĩnh
            } else if (r < 0.52) {
                curiousAnim.restart();      // Nghiêng tai tò mò
            } else if (r < 0.76) {
                twitchAnim.restart();       // Giật tai nhẹ
            } else {
                perkAnim.restart();         // Vểnh cao chú ý
            }
        }
    }

    SequentialAnimation {
        id: twitchAnim
        NumberAnimation { target: earsAnimRoot.earsTarget; property: "earTwitch"; to: -4; duration: 55 }
        NumberAnimation { target: earsAnimRoot.earsTarget; property: "earTwitch"; to: 5; duration: 65 }
        NumberAnimation { target: earsAnimRoot.earsTarget; property: "earTwitch"; to: 0; duration: 75 }
    }

    SequentialAnimation {
        id: halfFoldAnim
        // Cụp 1 nửa tai trái hoặc phải ngẫu nhiên đáng yêu
        ParallelAnimation {
            NumberAnimation { target: earsAnimRoot.earsTarget; property: "halfFoldL"; to: 0.5; duration: 220; easing.type: Easing.OutBack }
            NumberAnimation { target: earsAnimRoot.earsTarget; property: "randomTiltL"; to: 16; duration: 220; easing.type: Easing.OutBack }
        }
        PauseAnimation { duration: 1400 }
        ParallelAnimation {
            NumberAnimation { target: earsAnimRoot.earsTarget; property: "halfFoldL"; to: 0.0; duration: 260; easing.type: Easing.InOutQuad }
            NumberAnimation { target: earsAnimRoot.earsTarget; property: "randomTiltL"; to: 0; duration: 260; easing.type: Easing.InOutQuad }
        }
    }

    SequentialAnimation {
        id: curiousAnim
        ParallelAnimation {
            NumberAnimation { target: earsAnimRoot.earsTarget; property: "randomTiltL"; to: 8; duration: 220; easing.type: Easing.OutBack }
            NumberAnimation { target: earsAnimRoot.earsTarget; property: "randomTiltR"; to: -12; duration: 220; easing.type: Easing.OutBack }
            NumberAnimation { target: earsAnimRoot.earsTarget; property: "halfFoldR"; to: 0.35; duration: 220; easing.type: Easing.OutQuad }
        }
        PauseAnimation { duration: 1200 }
        ParallelAnimation {
            NumberAnimation { target: earsAnimRoot.earsTarget; property: "randomTiltL"; to: 0; duration: 250; easing.type: Easing.InOutQuad }
            NumberAnimation { target: earsAnimRoot.earsTarget; property: "randomTiltR"; to: 0; duration: 250; easing.type: Easing.InOutQuad }
            NumberAnimation { target: earsAnimRoot.earsTarget; property: "halfFoldR"; to: 0.0; duration: 250; easing.type: Easing.InOutQuad }
        }
    }

    SequentialAnimation {
        id: perkAnim
        ParallelAnimation {
            NumberAnimation { target: earsAnimRoot.earsTarget; property: "randomTiltL"; to: -6; duration: 180; easing.type: Easing.OutQuad }
            NumberAnimation { target: earsAnimRoot.earsTarget; property: "randomTiltR"; to: 6; duration: 180; easing.type: Easing.OutQuad }
        }
        PauseAnimation { duration: 800 }
        ParallelAnimation {
            NumberAnimation { target: earsAnimRoot.earsTarget; property: "randomTiltL"; to: 0; duration: 220; easing.type: Easing.InOutQuad }
            NumberAnimation { target: earsAnimRoot.earsTarget; property: "randomTiltR"; to: 0; duration: 220; easing.type: Easing.InOutQuad }
        }
    }
}
