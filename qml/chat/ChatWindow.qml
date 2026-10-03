import QtQuick

Rectangle {
    id: chatRoot
    property var controller: null
    radius: 16
    readonly property bool isDark: !controller || controller.isDarkTheme
    color: isDark ? "#242424" : "#f7f7f8"
    border.color: isDark ? "#383838" : "#d8d8dc"
    border.width: 1

    property var targetWindow: null
    property bool isPinned: true
    signal closeClicked()
    signal minimizeClicked()
    signal pinClicked()
    function focusInput() { promptInput.focusInput() }
    function clearHistory() { msgList.clearMessages() }
    onVisibleChanged: if (visible) Qt.callLater(focusInput)

    ChatHeader {
        id: header
        anchors.top: parent.top
        anchors.left: parent.left
        anchors.right: parent.right
        targetWindow: chatRoot.targetWindow
        controller: chatRoot.controller
        isPinned: chatRoot.isPinned
        onPinClicked: chatRoot.pinClicked()
        onCloseClicked: chatRoot.closeClicked()
        onMinimizeClicked: chatRoot.minimizeClicked()
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
