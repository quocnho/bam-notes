import QtQuick

Item {
    id: bubbleRoot
    property string rawContent: ""
    property bool isUser: false
    property var controller: null
    width: parent ? parent.width : 360
    height: bubbleRect.height + 8

    function formatMarkdown(txt) {
        if (!txt) return "";
        var res = txt.replace(/&/g, "&amp;").replace(/</g, "&lt;").replace(/>/g, "&gt;");
        res = res.replace(/\*\*(.*?)\*\*/g, "<b>$1</b>");
        res = res.replace(/\*(.*?)\*/g, "<i>$1</i>");
        res = res.replace(/`([^`]+)`/g, "<font color='#e5c07b' face='Monospace'><b>$1</b></font>");
        res = res.replace(/\n/g, "<br/>");
        return res;
    }

    readonly property bool isDark: !controller || controller.isDarkTheme

    Rectangle {
        id: bubbleRect
        anchors.right: bubbleRoot.isUser ? parent.right : undefined
        anchors.left: bubbleRoot.isUser ? undefined : parent.left
        width: Math.min(bubbleRoot.width * 0.92, 350)
        height: contentCol.height + 24
        radius: 12
        color: bubbleRoot.isUser ? "#1e60b5" : (bubbleRoot.isDark ? "#2d2d2d" : "#ffffff")
        border.color: bubbleRoot.isUser ? "#3584e4" : (bubbleRoot.isDark ? "#404040" : "#d8d8dc"); border.width: 1

        Column {
            id: contentCol
            anchors.top: parent.top
            anchors.topMargin: 12
            anchors.left: parent.left
            anchors.leftMargin: 12
            anchors.right: parent.right
            anchors.rightMargin: 12
            spacing: 8

            Repeater {
                model: bubbleRoot.rawContent.split("```")
                delegate: Column {
                    width: contentCol.width
                    property bool isCode: (index % 2) === 1
                    property string chunkText: modelData

                    CodeBlockView {
                        visible: isCode; width: parent.width; controller: bubbleRoot.controller
                        codeContent: isCode ? chunkText.split("\n").slice(1).join("\n") : ""
                        codeLang: isCode ? (chunkText.split("\n")[0].trim() || "code") : "text"
                    }

                    Text {
                        visible: !isCode && chunkText.trim().length > 0
                        width: parent.width
                        wrapMode: Text.Wrap; textFormat: Text.RichText
                        color: bubbleRoot.isUser ? "#ffffff" : (bubbleRoot.isDark ? "#f0f0f0" : "#1a1a1c")
                        font.pixelSize: 13
                        lineHeight: 1.25; text: formatMarkdown(chunkText)
                        onLinkActivated: (link) => Qt.openUrlExternally(link)
                    }
                }
            }
        }

        CopyButton {
            visible: !bubbleRoot.isUser && bubbleRoot.rawContent.trim().length > 0
            anchors { right: parent.right; bottom: parent.bottom; margins: 6 }
            textToCopy: bubbleRoot.rawContent
            controller: bubbleRoot.controller
        }
    }
}
