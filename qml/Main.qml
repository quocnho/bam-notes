import QtQuick
import "mascot"
import "chat"
import "common"

Window {
    id: dogWindow
    property var appController: null
    property bool isPinned: true
    property bool syncingWinPos: false
    property bool initialized: false

    visible: true; width: 116; height: 116; color: "transparent"
    flags: isPinned ? (Qt.Window | Qt.FramelessWindowHint | Qt.WindowStaysOnTopHint)
                    : (Qt.Window | Qt.FramelessWindowHint)

    Timer { id: savePosTimer; interval: 350; repeat: false; onTriggered: if (appController) appController.savePosition(dogWindow.x, dogWindow.y) }
    onXChanged: {
        if (initialized) savePosTimer.restart();
        if (chatWin && chatWin.visible && !syncingWinPos) chatWin.realignToDog();
    }
    onYChanged: {
        if (initialized) savePosTimer.restart();
        if (chatWin && chatWin.visible && !syncingWinPos) chatWin.realignToDog();
    }

    function updateDogPos() {
        var sW = Screen.desktopAvailableWidth > 0 ? Screen.desktopAvailableWidth : Screen.width;
        var sH = Screen.desktopAvailableHeight > 0 ? Screen.desktopAvailableHeight : Screen.height;
        var defX = sW - width - 24; var defY = sH - height - 24;
        if (appController) {
            var p = appController.getSavedPosition(defX, defY);
            x = Math.max(0, Math.min(sW - width, p.x)); y = Math.max(0, Math.min(sH - height, p.y));
        } else { x = defX; y = defY; }
        initialized = true;
    }
    Component.onCompleted: { updateDogPos(); mascotDog.wakeUp(); }
    Screen.onWidthChanged: updateDogPos(); Screen.onHeightChanged: updateDogPos()

    DogMascotHost {
        id: mascotDog; anchors.fill: parent; targetWindow: dogWindow
        onRequestShowClock: {
            clockWin.x = dogWindow.x + (dogWindow.width - clockWin.width) / 2
            clockWin.y = dogWindow.y - clockWin.height - 10
            clockWin.visible = true; clockPopup.triggerTime();
        }
        onDogStateChanged: if ((dogState === "lying" || dogState === "sleeping") &&
                               appController && appController.isExpanded) appController.isExpanded = false
        onClicked: if (appController) {
            appController.isExpanded = !appController.isExpanded
            if (appController.isExpanded) Qt.callLater(chatWin.focusInput)
        }
    }

    Window {
        id: clockWin; visible: false; width: 124; height: 40; color: "transparent"
        flags: Qt.Window | Qt.FramelessWindowHint | Qt.WindowStaysOnTopHint
        HourlyClockPopup { id: clockPopup; anchors.centerIn: parent; onFinished: clockWin.visible = false }
    }

    FloatingChatWindow {
        id: chatWin
        visible: !!(appController && appController.isExpanded)
        appController: dogWindow.appController
        dogWindow: dogWindow
        isPinned: dogWindow.isPinned
        onPinToggled: dogWindow.isPinned = !dogWindow.isPinned
    }
}
