import QtQuick

Item {
    id: interactionRoot
    property var mascotRig: null
    property string dogState: "active"
    property int idleSeconds: 0
    property real pettingScore: 0
    signal clicked()

    function triggerWakeAndBark() {
        idleSeconds = 0; pettingScore = 0; petCooldownTimer.stop();
        dogState = "active";
        if (mascotRig) mascotRig.bark();
    }

    function recordPetting(delta) {
        if (dogState === "sleeping") return;
        pettingScore += delta;
        idleSeconds = 0;
        if (pettingScore >= 160) {
            dogState = "lying"; // Nằm xuống hưởng thụ
            petCooldownTimer.restart();
        }
    }

    Timer {
        id: petCooldownTimer
        interval: 3500; repeat: false
        onTriggered: {
            interactionRoot.pettingScore = 0;
            if (interactionRoot.dogState === "lying") interactionRoot.dogState = "sitting";
        }
    }

    Timer {
        id: idleTimer
        interval: 1000; repeat: true; running: true
        onTriggered: {
            if (petCooldownTimer.running) return; // Đang nằm hưởng thụ vuốt ve
            interactionRoot.idleSeconds++;
            if (interactionRoot.idleSeconds >= 600) interactionRoot.dogState = "sleeping";
            else if (interactionRoot.idleSeconds >= 300) interactionRoot.dogState = "lying";
            else if (interactionRoot.idleSeconds >= 180) interactionRoot.dogState = "sitting";
            else if (!mascotRig || !mascotRig.isBarking) interactionRoot.dogState = "active";
        }
    }
}
