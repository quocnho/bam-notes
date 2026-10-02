import QtQuick
import "../components"


Rectangle {
    id: chatRoot
    property var controller: null
    radius: 16
    color: "#242424"
    border.color: "#383838"
    border.width: 1

    signal closeClicked()


    Rectangle {
        id: header
        height: 48
        anchors.top: parent.top
        anchors.left: parent.left
        anchors.right: parent.right
        color: "#2e2e2e"
        radius: 16

        Rectangle {
            anchors.bottom: parent.bottom
            width: parent.width
            height: 16
            color: "#2e2e2e"
        }

        DragHandler {
            target: null
            onActiveChanged: if (active) root.startSystemMove()
        }

        Row {
            anchors.left: parent.left
            anchors.leftMargin: 16
            anchors.verticalCenter: parent.verticalCenter
            spacing: 8

            StatusIndicator {
                anchors.verticalCenter: parent.verticalCenter
                status: (controller && controller.isGenerating) ? "streaming" : "idle"
            }

            Text {
                text: "Bam Trợ Lý (OpenClaw ReAct Agent)"
                color: "#ffffff"
                font.bold: true
                font.pixelSize: 13
            }
        }

        Rectangle {
            anchors.right: parent.right
            anchors.rightMargin: 12
            anchors.verticalCenter: parent.verticalCenter
            width: 28
            height: 28
            radius: 14
            color: closeMouse.containsMouse ? "#404040" : "transparent"

            Text {
                anchors.centerIn: parent
                text: "✕"
                color: "#cccccc"
                font.pixelSize: 14
            }

            MouseArea {
                id: closeMouse
                anchors.fill: parent
                hoverEnabled: true
                cursorShape: Qt.PointingHandCursor
                onClicked: chatRoot.closeClicked()
            }
        }
    }

    MessageList {
        id: msgList
        anchors.top: header.bottom
        anchors.bottom: promptInput.top
        anchors.left: parent.left
        anchors.right: parent.right
        anchors.margins: 12
    }

    PromptInput {
        id: promptInput
        controller: chatRoot.controller
        anchors.bottom: parent.bottom
        anchors.left: parent.left
        anchors.right: parent.right
        anchors.margins: 12
        onSendPrompt: (txt) => {
            msgList.addUserMessage(txt);
            if (chatRoot.controller) chatRoot.controller.sendMessage(txt);
        }
    }
}

