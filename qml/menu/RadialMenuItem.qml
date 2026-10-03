import QtQuick

Item {
    id: itemRoot
    width: 42; height: 42
    property string iconText: "⭐"
    property string labelText: ""
    property color accentColor: "#00F5FF"
    property real animDelay: 0
    property bool isExpanded: false
    signal triggered()

    scale: isExpanded ? 1.0 : 0.0
    opacity: isExpanded ? 1.0 : 0.0
    Behavior on scale { NumberAnimation { duration: 320; easing.type: Easing.OutBack } }
    Behavior on opacity { NumberAnimation { duration: 250 } }

    Rectangle {
        id: bgCircle
        anchors.fill: parent; radius: width / 2
        color: btnMouse.containsMouse ? "#2A374A" : "#1A2234"
        border.color: btnMouse.containsMouse ? itemRoot.accentColor : "#4A5D78"
        border.width: btnMouse.containsMouse ? 2 : 1
        scale: btnMouse.containsMouse ? 1.15 : 1.0
        Behavior on scale { NumberAnimation { duration: 150; easing.type: Easing.OutQuad } }

        Text {
            anchors.centerIn: parent
            text: itemRoot.iconText
            font.pixelSize: 18
        }
    }

    // Nhãn Title được ưu tiên tuyệt đối (z: 100), nổi bật hơn mọi icon
    Rectangle {
        id: tooltip
        z: 100
        anchors.bottom: bgCircle.top; anchors.bottomMargin: 7
        anchors.horizontalCenter: bgCircle.horizontalCenter
        width: titleText.implicitWidth + 18; height: 26
        radius: 8; color: "#0A0E17"
        border.color: itemRoot.accentColor; border.width: 1.5
        visible: btnMouse.containsMouse && itemRoot.labelText.length > 0
        scale: visible ? 1.0 : 0.7
        opacity: visible ? 1.0 : 0.0
        Behavior on scale { NumberAnimation { duration: 180; easing.type: Easing.OutBack } }
        Behavior on opacity { NumberAnimation { duration: 150 } }

        Text {
            id: titleText
            anchors.centerIn: parent; text: itemRoot.labelText
            font.pixelSize: 12; font.bold: true; color: "#FFFFFF"
            style: Text.Outline; styleColor: "#000000"
        }
    }

    MouseArea {
        id: btnMouse; anchors.fill: parent; hoverEnabled: true
        cursorShape: Qt.PointingHandCursor
        onClicked: itemRoot.triggered()
    }
}
