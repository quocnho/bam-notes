import QtQuick

Item {
    id: radialView
    width: 280; height: 280
    property bool isExpanded: false
    property var controller: null
    property var calculatedAngles: [170, 143, 117, 90, 63, 37, 10]
    signal requestClose()
    signal actionTriggered(string actionId)

    readonly property real centerX: width / 2
    readonly property real centerY: height / 2
    readonly property real radius: 105

    readonly property var menuItems: [
        { id: "openclaw", icon: "🐾", label: "OpenClaw AI", color: "#FF6B6B" },
        { id: "kimi", icon: "🌙", label: "Kimi Assistant", color: "#4D96FF" },
        { id: "editor", icon: "💻", label: "Code Editor", color: "#6BCB77" },
        { id: "terminal", icon: "📟", label: "Bam Terminal", color: "#FFD93D" },
        { id: "clock", icon: "⏰", label: "Đồng hồ & Giờ", color: "#00F5FF" },
        { id: "settings", icon: "⚙️", label: "Thiết lập", color: "#B983FF" },
        { id: "about", icon: "ℹ️", label: "Giới thiệu Bam", color: "#FF9F45" }
    ]

    MouseArea { anchors.fill: parent; onClicked: radialView.requestClose() }

    Repeater {
        model: radialView.menuItems
        delegate: RadialMenuItem {
            required property var modelData
            required property int index
            iconText: modelData.icon
            labelText: modelData.label
            accentColor: modelData.color
            isExpanded: radialView.isExpanded

            readonly property real angleDeg: (radialView.calculatedAngles && radialView.calculatedAngles.length > index)
                                                ? radialView.calculatedAngles[index] : (180 - index * 30)
            readonly property real rad: angleDeg * Math.PI / 180.0

            x: radialView.centerX + radialView.radius * Math.cos(rad) - width / 2
            y: radialView.centerY - radialView.radius * Math.sin(rad) - height / 2

            Behavior on x { NumberAnimation { duration: 250; easing.type: Easing.OutBack } }
            Behavior on y { NumberAnimation { duration: 250; easing.type: Easing.OutBack } }

            onTriggered: {
                radialView.actionTriggered(modelData.id)
                radialView.requestClose()
            }
        }
    }
}
