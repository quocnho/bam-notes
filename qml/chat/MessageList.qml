import QtQuick

ListView {

    id: listRoot
    clip: true
    spacing: 10
    model: ListModel {
        id: messageModel
        ListElement {
            isUser: false
            content: "Xin chào! Tôi là Trợ lý (BamOS).\nTôi có thể giúp bạn kiểm tra hệ thống, điều phối tác vụ hoặc giải đáp câu hỏi. Hãy nhập câu hỏi bên dưới!"
        }
    }

    function addUserMessage(txt) {
        messageModel.append({ "isUser": true, "content": txt });
        messageModel.append({ "isUser": false, "content": "" });
        listRoot.positionViewAtEnd();
    }

    function clearMessages() {
        messageModel.clear();
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
        height: bubble.height

        MessageBubble {
            id: bubble
            width: parent.width
            rawContent: model.content
            isUser: model.isUser
            controller: appController
        }
    }
}
