import QtQuick

Rectangle {
    id: blockRoot
    property string codeContent: ""
    property string codeLang: "bash"
    property var controller: null
    property bool copied: false
    width: parent ? parent.width : 280
    height: Math.max(76, codeHeader.height + codeText.implicitHeight + 20)
    radius: 8; color: "#1e1e1e"; border.color: "#3d3d3d"; border.width: 1

    Rectangle {
        id: codeHeader
        anchors.top: parent.top; width: parent.width; height: 28
        color: "#282828"; radius: 8
        Rectangle { anchors.bottom: parent.bottom; width: parent.width; height: 8; color: "#282828" }

        Text {
            anchors.left: parent.left; anchors.leftMargin: 10
            anchors.verticalCenter: parent.verticalCenter
            text: blockRoot.codeLang; color: "#9da5b4"; font.pixelSize: 11; font.family: "Monospace"
        }

        Rectangle {
            anchors.right: parent.right; anchors.rightMargin: 6
            anchors.verticalCenter: parent.verticalCenter
            width: 64; height: 20; radius: 4
            color: copyMouse.containsMouse ? "#3c4048" : "#2f333a"
            border.color: "#4b5263"; border.width: 0.8

            Text {
                anchors.centerIn: parent
                text: blockRoot.copied ? "✔ Đã chép" : "📋 Chép"
                color: blockRoot.copied ? "#2ecc71" : "#dcdfe4"; font.pixelSize: 10; font.bold: true
            }

            MouseArea {
                id: copyMouse; anchors.fill: parent; hoverEnabled: true; cursorShape: Qt.PointingHandCursor
                onClicked: {
                    if (blockRoot.controller) blockRoot.controller.copyToClipboard(blockRoot.codeContent);
                    blockRoot.copied = true;
                    resetTimer.restart();
                }
            }
        }
    }

    Timer { id: resetTimer; interval: 1800; onTriggered: blockRoot.copied = false }

    Flickable {
        anchors.top: codeHeader.bottom; anchors.bottom: parent.bottom
        anchors.left: parent.left; anchors.right: parent.right
        anchors.margins: 8; clip: true; contentWidth: codeText.implicitWidth
        contentHeight: codeText.implicitHeight

        TextEdit {
            id: codeText
            text: blockRoot.codeContent
            readOnly: true; selectByMouse: true; color: "#e5c07b"
            font.family: "Monospace"; font.pixelSize: 12
            selectionColor: "#3e4451"; selectedTextColor: "#ffffff"
        }
    }
}
