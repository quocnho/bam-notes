import QtQuick
import "mascot"
import "chat"
import "common"

import "menu"

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
        if (menuWin && menuWin.visible) menuWin.realignToDog();
    }
    onYChanged: {
        if (initialized) savePosTimer.restart();
        if (chatWin && chatWin.visible && !syncingWinPos) chatWin.realignToDog();
        if (menuWin && menuWin.visible) menuWin.realignToDog();
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

    Shortcut { sequence: "s"; onActivated: mascotDog.setDogState("sleeping") }
    Shortcut { sequence: "w"; onActivated: mascotDog.wakeUp() }

    DogMascotHost {
        id: mascotDog; anchors.fill: parent; targetWindow: dogWindow
        appController: dogWindow.appController
        onRequestShowMenu: menuWin.openMenu()
        onHoverExited: menuWin.scheduleClose(650)
        onDogStateChanged: if ((dogState === "lying" || dogState === "sleeping") &&
                               appController && appController.isExpanded) appController.isExpanded = false
        onClicked: if (appController) {
            menuWin.closeMenu()
            appController.isExpanded = !appController.isExpanded
            if (appController.isExpanded) Qt.callLater(chatWin.focusInput)
        }
    }

    FloatingChatWindow {
        id: chatWin
        visible: !!(appController && appController.isExpanded)
        appController: dogWindow.appController
        dogWindow: dogWindow
        isPinned: dogWindow.isPinned
        onPinToggled: dogWindow.isPinned = !dogWindow.isPinned
    }

    RadialMenuWindow {
        id: menuWin
        dogWindow: dogWindow
        appController: dogWindow.appController
        onActionSelected: (act) => console.log("[Bam Menu] Selected:", act)
    }
}
