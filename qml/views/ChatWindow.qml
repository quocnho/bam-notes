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
    signal rightClicked()
    function focusInput() { promptInput.focusInput() }
    function clearHistory() { msgList.clearMessages() }
    onVisibleChanged: if (visible) Qt.callLater(focusInput)

    ChatHeader {
        id: header
        anchors.top: parent.top
        anchors.left: parent.left
        anchors.right: parent.right
        controller: chatRoot.controller
        onCloseClicked: chatRoot.closeClicked()
        onRightClicked: chatRoot.rightClicked()
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
