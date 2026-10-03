import QtQuick

Item {
    id: interactionRoot
    property var mascotRig: null; property string dogState: "active"
    property int idleSeconds: 0; property real pettingScore: 0
    property int strokeCount: 0; property real lastStrokeDir: 0; property real lastPetX: -1
    property bool isBeingPetted: false
    signal clicked()

    function triggerWakeAndBark() {
        idleSeconds = 0; pettingScore = 0; strokeCount = 0; isBeingPetted = false; dogState = "active";
        if (mascotRig) mascotRig.bark(false);
    }

    function recordPetting(mouseX, mouseY, delta) {
        if (dogState === "sleeping") return;
        idleSeconds = 0;
        if (mouseY < 65) {
            if (lastPetX >= 0) {
                var dx = mouseX - lastPetX;
                if (Math.abs(dx) >= 5) {
                    var currentDir = dx > 0 ? 1 : -1;
                    if (lastStrokeDir !== 0 && currentDir !== lastStrokeDir) {
                        strokeCount++;
                        strokeResetTimer.restart();
                    }
                    lastStrokeDir = currentDir;
                }
            }
            lastPetX = mouseX;
            pettingScore += delta;
            // Chỉ khi rê tới lui ít nhất 2 lần và tích lũy đủ xoa đầu
            if (strokeCount >= 2 && pettingScore >= 40) {
                isBeingPetted = true;
                dogState = "lying"; // Nằm nhắm mắt hưởng thụ
            }
        }
    }

    function handleMouseLeave() {
        idleSeconds = 0; lastPetX = -1; lastStrokeDir = 0; strokeCount = 0;
        if (isBeingPetted || dogState === "lying") {
            isBeingPetted = false; pettingScore = 0;
            dogState = "active"; // Đứng dậy đòi vuốt ve tiếp
            if (mascotRig) {
                mascotRig.jumpAndBounce();
                mascotRig.bark(false);
            }
        }
    }

    Timer {
        id: strokeResetTimer
        interval: 1200; repeat: false
        onTriggered: {
            if (!interactionRoot.isBeingPetted) {
                interactionRoot.strokeCount = 0;
                interactionRoot.pettingScore = 0;
                interactionRoot.lastStrokeDir = 0;
            }
        }
    }

    Timer {
        id: idleTimer
        interval: 1000; repeat: true; running: true
        onTriggered: {
            if (interactionRoot.isBeingPetted) return;
            interactionRoot.idleSeconds++;
            if (interactionRoot.idleSeconds >= 600) interactionRoot.dogState = "sleeping";
            else if (interactionRoot.idleSeconds >= 300) interactionRoot.dogState = "lying";
            else if (interactionRoot.idleSeconds >= 180) interactionRoot.dogState = "sitting";
            else if (!mascotRig || !mascotRig.isBarking) interactionRoot.dogState = "active";
        }
    }
}
