import QtQuick

Rectangle {
    id: statusRoot
    property string status: "idle"
    width: 8
    height: 8
    radius: 4
    color: status === "streaming" ? "#2ecc71" : (status === "reasoning" ? "#f1c40f" : "#95a5a6")

    SequentialAnimation on opacity {
        running: statusRoot.status !== "idle"
        loops: Animation.Infinite
        NumberAnimation { to: 0.3; duration: 400 }
        NumberAnimation { to: 1.0; duration: 400 }
    }
}
