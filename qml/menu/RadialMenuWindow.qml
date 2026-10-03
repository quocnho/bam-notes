import QtQuick
import "RadialArcSolver.js" as Solver

Window {
    id: radialWin
    property var dogWindow: null
    property var appController: null
    property bool isHoveringMenu: false
    signal actionSelected(string actionId)

    width: 280; height: 280; color: "transparent"
    flags: Qt.Window | Qt.FramelessWindowHint | Qt.WindowStaysOnTopHint
    transientParent: dogWindow

    function realignToDog() {
        if (!dogWindow) return;
        x = dogWindow.x + (dogWindow.width - width) / 2;
        y = dogWindow.y + (dogWindow.height - height) / 2;
        if (visible) radialWin.raise();
    }

    function openMenu() {
        if (!dogWindow) return;
        var sW = Screen.desktopAvailableWidth > 0 ? Screen.desktopAvailableWidth : Screen.width;
        var sH = Screen.desktopAvailableHeight > 0 ? Screen.desktopAvailableHeight : Screen.height;
        var isChatOpen = !!(appController && appController.isExpanded);

        var sol = Solver.solveArcLayout(dogWindow.x, dogWindow.y, dogWindow.width, dogWindow.height, sW, sH, radialView.radius, isChatOpen);

        if (Math.abs(dogWindow.x - sol.targetX) > 1 || Math.abs(dogWindow.y - sol.targetY) > 1) {
            dogWindow.x = sol.targetX; dogWindow.y = sol.targetY;
        }

        realignToDog();
        radialView.calculatedAngles = sol.angles;
        visible = true;
        radialWin.raise();
        radialView.isExpanded = true;
        closeGraceTimer.stop();
    }

    function scheduleClose(delayMs) {
        closeGraceTimer.interval = delayMs ? delayMs : 700;
        closeGraceTimer.restart();
    }

    function closeMenu() {
        radialView.isExpanded = false;
        closeAnimTimer.restart();
    }

    Timer { id: closeGraceTimer; repeat: false; onTriggered: if (!radialWin.isHoveringMenu) radialWin.closeMenu() }
    Timer { id: closeAnimTimer; interval: 220; repeat: false; onTriggered: radialWin.visible = false }

    RadialMenuView {
        id: radialView
        anchors.fill: parent
        controller: radialWin.appController
        onRequestClose: radialWin.closeMenu()
        onActionTriggered: (actionId) => radialWin.actionSelected(actionId)
    }

    HoverHandler {
        onHoveredChanged: {
            radialWin.isHoveringMenu = hovered;
            if (hovered) { closeGraceTimer.stop(); radialWin.raise(); }
            else radialWin.scheduleClose(600);
        }
    }
}
