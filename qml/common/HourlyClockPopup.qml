import QtQuick

Rectangle {
    id: clockPopupRoot
    width: 120; height: 36
    radius: 10; color: "#0F172A"
    border.color: "#00F5FF"; border.width: 1.5

    property string timeString: "17:00"
    signal finished()

    function triggerTime(customTime) {
        if (customTime) timeString = customTime;
        else {
            var d = new Date();
            var h = String(d.getHours()).padStart(2, '0');
            var m = String(d.getMinutes()).padStart(2, '0');
            timeString = h + ":" + m;
        }
        showAnim.restart();
    }

    SequentialAnimation {
        id: showAnim
        ParallelAnimation {
            NumberAnimation { target: clockPopupRoot; property: "scale"; from: 0.7; to: 1.0; duration: 250; easing.type: Easing.OutBack }
            NumberAnimation { target: clockPopupRoot; property: "opacity"; from: 0.0; to: 1.0; duration: 200 }
        }
        PauseAnimation { duration: 4500 }
        ParallelAnimation {
            NumberAnimation { target: clockPopupRoot; property: "scale"; to: 0.8; duration: 250; easing.type: Easing.InQuad }
            NumberAnimation { target: clockPopupRoot; property: "opacity"; to: 0.0; duration: 250 }
        }
        ScriptAction { script: clockPopupRoot.finished() }
    }

    // Viền phát sáng 3D ngoài
    Rectangle {
        anchors.fill: parent; anchors.margins: -2; radius: 12
        color: "transparent"; border.color: "#4400F5FF"; border.width: 1.5; z: -1
    }

    Row {
        anchors.centerIn: parent; spacing: 7
        Text { text: "⏰"; font.pixelSize: 14; anchors.verticalCenter: parent.verticalCenter }
        Text {
            text: clockPopupRoot.timeString
            font.bold: true; font.pixelSize: 16; font.family: "Monospace"
            color: "#00F5FF"; anchors.verticalCenter: parent.verticalCenter
            style: Text.Outline; styleColor: "#005577"
        }
    }
}
