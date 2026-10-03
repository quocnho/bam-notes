import QtQuick

Row {
    id: inputRow
    property var controller: null
    height: 42
    spacing: 8

    signal sendPrompt(string text)
    function focusInput() { textInput.forceActiveFocus() }

    readonly property bool isDark: !controller || controller.isDarkTheme

    Rectangle {
        width: parent.width - sendBtn.width - parent.spacing
        height: parent.height
        color: inputRow.isDark ? "#303030" : "#ffffff"
        radius: 8
        border.color: textInput.activeFocus ? "#3584e4" : (inputRow.isDark ? "#454545" : "#d0d0d5")

        MouseArea {
            id: inputHoverArea
            anchors.fill: parent
            hoverEnabled: true
            cursorShape: Qt.IBeamCursor
            onClicked: textInput.forceActiveFocus()
        }

        TextInput {
            id: textInput
            anchors.fill: parent
            anchors.margins: 10
            verticalAlignment: TextInput.AlignVCenter
            color: inputRow.isDark ? "#ffffff" : "#1a1a1c"
            font.pixelSize: 13
            clip: true
            focus: true
            selectByMouse: true
            onAccepted: sendBtnMouse.clicked(null)

            Text {
                text: "Hỏi mọi thứ, @ để đề cập. / để hành động!"
                color: inputRow.isDark ? "#888888" : "#8e8e93"
                font.pixelSize: 12
                visible: !textInput.text && !textInput.activeFocus
                anchors.verticalCenter: parent.verticalCenter
            }
        }

        ChatTooltip {
            visible: inputHoverArea.containsMouse && !textInput.activeFocus
            anchors.bottom: parent.top
            anchors.bottomMargin: 6
            anchors.left: parent.left
            text: "💡 Hỏi mọi thứ, @ để đề cập. / để hành động!"
        }
    }

    Rectangle {
        id: sendBtn
        width: 68
        height: parent.height
        radius: 8
        color: (controller && controller.isGenerating) ? "#e74c3c" : "#3584e4"

        Text {
            anchors.centerIn: parent
            text: (controller && controller.isGenerating) ? "Dừng" : "Gửi"
            color: "#ffffff"
            font.bold: true
            font.pixelSize: 13
        }

        MouseArea {
            id: sendBtnMouse
            anchors.fill: parent
            cursorShape: Qt.PointingHandCursor
            onClicked: {
                if (controller && controller.isGenerating) {
                    controller.stopGeneration();
                } else if (textInput.text.trim().length > 0) {
                    inputRow.sendPrompt(textInput.text.trim());
                    textInput.text = "";
                }
            }
        }
    }
}
