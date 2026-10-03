import QtQuick

Item {
    id: introRoot
    property var targetWindow: null
    property var controller: null
    property bool introFinished: false
    signal finished()

    function startRunAnimation() {
        var screenW = Screen.desktopAvailableWidth > 0 ? Screen.desktopAvailableWidth : Screen.width;
        var screenH = Screen.desktopAvailableHeight > 0 ? Screen.desktopAvailableHeight : Screen.height;
        var defaultX = screenW - (targetWindow ? targetWindow.width : 96) - 24;
        var defaultY = screenH - (targetWindow ? targetWindow.height : 96) - 24;

        var targetX = defaultX;
        var targetY = defaultY;

        if (controller) {
            var savedPos = controller.getSavedPosition(defaultX, defaultY);
            targetX = savedPos.x;
            targetY = savedPos.y;
        }

        if (targetWindow) {
            targetWindow.x = screenW + 150;
            targetWindow.y = targetY;
        }

        runAnim.from = screenW + 150;
        runAnim.to = targetX;
        runAnim.start();
    }

    NumberAnimation {
        id: runAnim
        target: introRoot.targetWindow
        property: "x"
        duration: 1800
        easing.type: Easing.OutQuad
        onFinished: {
            introRoot.introFinished = true;
            introRoot.finished();
        }
    }
}
