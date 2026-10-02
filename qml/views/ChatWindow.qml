import QtQuick
import QtQuick.Controls
import "../components"

Rectangle {
    id: chatRoot
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
                status: appController.isGenerating ? "streaming" : "idle"
            }

            Text {
                text: "Bam Trợ Lý (OpenClaw ReAct Agent)"
                color: "#ffffff"
                font.bold: true
                font.pixelSize: 13
            }
        }

        Button {
            anchors.right: parent.right
            anchors.rightMargin: 12
            anchors.verticalCenter: parent.verticalCenter
            text: "✕"
            flat: true
            onClicked: chatRoot.closeClicked()
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
        anchors.bottom: parent.bottom
        anchors.left: parent.left
        anchors.right: parent.right
        anchors.margins: 12
        onSendPrompt: (txt) => {
            msgList.addUserMessage(txt);
            appController.sendMessage(txt);
        }
    }
}
