import QtQuick

Row {
    id: inputRow
    property var controller: null
    height: 42
    spacing: 8

    signal sendPrompt(string text)

    Rectangle {
        width: parent.width - sendBtn.width - parent.spacing
        height: parent.height
        color: "#303030"
        radius: 8
        border.color: textInput.activeFocus ? "#3584e4" : "#454545"

        TextInput {
            id: textInput
            anchors.fill: parent
            anchors.margins: 10
            verticalAlignment: TextInput.AlignVCenter
            color: "#ffffff"
            font.pixelSize: 13
            clip: true
            onAccepted: sendBtnMouse.clicked(null)

            Text {
                text: "Hỏi trợ lý hoặc nhập lệnh..."
                color: "#888888"
                font.pixelSize: 13
                visible: !textInput.text && !textInput.activeFocus
                anchors.verticalCenter: parent.verticalCenter
            }
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


