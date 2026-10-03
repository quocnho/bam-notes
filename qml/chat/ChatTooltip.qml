import QtQuick

Rectangle {
    id: tipBox
    property string text: ""
    width: tipLabel.width + 16
    height: 26
    radius: 6
    color: "#18181b"
    border.color: "#3f3f46"
    border.width: 1
    z: 99

    Text {
        id: tipLabel
        anchors.centerIn: parent
        text: tipBox.text
        color: "#a1a1aa"
        font.pixelSize: 11
    }
}
