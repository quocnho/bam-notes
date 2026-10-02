import QtQuick
import QtQuick.Controls

Row {
    id: inputRow
    height: 42
    spacing: 8

    signal sendPrompt(string text)

    TextField {
        id: textField
        width: parent.width - sendBtn.width - parent.spacing
        height: parent.height
        placeholderText: "Hỏi trợ lý hoặc nhập lệnh..."
        color: "#ffffff"
        background: Rectangle {
            color: "#303030"
            radius: 8
            border.color: textField.activeFocus ? "#3584e4" : "#454545"
        }
        onAccepted: sendBtn.clicked()
    }

    Button {
        id: sendBtn
        width: 68
        height: parent.height
        text: appController.isGenerating ? "Dừng" : "Gửi"
        highlighted: true
        onClicked: {
            if (appController.isGenerating) {
                appController.stopGeneration();
            } else if (textField.text.trim().length > 0) {
                inputRow.sendPrompt(textField.text.trim());
                textField.text = "";
            }
        }
    }
}
