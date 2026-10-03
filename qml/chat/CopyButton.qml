import QtQuick

Rectangle {
    id: copyBtnRoot
    property string textToCopy: ""
    property var controller: null
    property bool copied: false

    width: 26; height: 26; radius: 6
    color: copyArea.containsMouse ? "#3d3d3d" : "#282828"
    border.color: copied ? "#2ecc71" : (copyArea.containsMouse ? "#555555" : "#383838")
    border.width: 1

    Text {
        anchors.centerIn: parent
        text: copyBtnRoot.copied ? "✔" : "📋"
        font.pixelSize: copyBtnRoot.copied ? 11 : 12
        color: copyBtnRoot.copied ? "#2ecc71" : "#b0b0b0"
    }

    Timer {
        id: resetTimer
        interval: 2000
        onTriggered: copyBtnRoot.copied = false
    }

    MouseArea {
        id: copyArea
        anchors.fill: parent
        hoverEnabled: true
        cursorShape: Qt.PointingHandCursor
        onClicked: {
            if (copyBtnRoot.controller) {
                copyBtnRoot.controller.copyToClipboard(copyBtnRoot.textToCopy);
                copyBtnRoot.copied = true;
                resetTimer.restart();
            }
        }
    }
}
