import QtQuick
import QtQuick.Controls

ListView {
    id: listRoot
    clip: true
    spacing: 10
    model: ListModel { id: messageModel }

    function addUserMessage(txt) {
        messageModel.append({ "isUser": true, "content": txt });
        messageModel.append({ "isUser": false, "content": "" });
        listRoot.positionViewAtEnd();
    }

    Connections {
        target: appController
        function onTokenReceived(token) {
            if (messageModel.count === 0) return;
            var lastIdx = messageModel.count - 1;
            var current = messageModel.get(lastIdx).content;
            messageModel.setProperty(lastIdx, "content", current + token);
            listRoot.positionViewAtEnd();
        }
    }

    delegate: Item {
        width: listRoot.width
        height: textBubble.implicitHeight + 16

        Rectangle {
            id: textBubble
            anchors.right: model.isUser ? parent.right : undefined
            anchors.left: model.isUser ? undefined : parent.left
            width: Math.min(parent.width * 0.8, textContent.implicitWidth + 24)
            height: textContent.implicitHeight + 16
            radius: 12
            color: model.isUser ? "#3584e4" : "#323232"

            Text {
                id: textContent
                anchors.centerIn: parent
                width: parent.width - 24
                wrapMode: Text.Wrap
                color: "#ffffff"
                text: model.content
                font.pixelSize: 13
            }
        }
    }
}
