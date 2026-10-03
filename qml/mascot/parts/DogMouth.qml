import QtQuick

Item {
    id: mouthRoot
    property string dogState: "active"
    property bool isBarking: false
    property bool isLicking: false
    width: 28; height: 19

    // Khối mõm chó bo tròn 3D
    Rectangle {
        id: muzzleBase
        width: 26; height: 16; radius: 8; color: "#FFFFFF"
        border.color: "#E2E8F0"; border.width: 1
        anchors.horizontalCenter: parent.horizontalCenter; anchors.top: parent.top

        // Bóng đổ nhẹ dưới cằm tạo chiều sâu
        Rectangle {
            anchors.bottom: parent.bottom; anchors.horizontalCenter: parent.horizontalCenter
            width: parent.width * 0.85; height: 2.5; radius: 1.25; color: "#CBD5E1"; opacity: 0.55
        }

        // Mũi chó đen bóng 3D đặc trưng (Canine Truffle)
        Rectangle {
            id: nose
            width: 8.5; height: 6; radius: 2.8; color: "#0F172A"
            anchors.horizontalCenter: parent.horizontalCenter; y: 1
            Rectangle { width: 3; height: 1.5; radius: 0.75; color: "#FFFFFF"; opacity: 0.85; x: 1.5; y: 1 }
            Rectangle { width: 1.4; height: 1.2; radius: 0.6; color: "#020617"; x: 1.6; y: 3.6 }
            Rectangle { width: 1.4; height: 1.2; radius: 0.6; color: "#020617"; x: 5.5; y: 3.6 }
        }

        // Rãnh nhân trung mảnh mai màu nâu socola đậm ấm áp
        Rectangle {
            width: 1.1; height: 2.8; radius: 0.55; color: "#4A2810"
            opacity: 0.85
            anchors.horizontalCenter: parent.horizontalCenter; anchors.top: nose.bottom
        }

    // Nụ cười khép miệng chữ 'w' màu nâu đậm (#4A2810) khi không sủa
        Canvas {
            anchors.horizontalCenter: parent.horizontalCenter
            y: 9.8; width: 10.5; height: 4
            visible: !mouthRoot.isBarking
            onPaint: {
                var ctx = getContext("2d"); ctx.reset(); ctx.lineWidth = 1.35; ctx.strokeStyle = "#4A2810";
                ctx.lineCap = "round"; ctx.beginPath(); ctx.moveTo(1, 1);
                ctx.quadraticCurveTo(3.0, 3.2, 5.25, 2.5); ctx.quadraticCurveTo(7.5, 3.2, 9.5, 1); ctx.stroke();
            }
        }

        // Lưỡi hồng thè ra liếm liếm nũng nịu lấy lòng chủ nhân khi đưa chuột lại gần
        Rectangle {
            id: lickingTongue
            visible: mouthRoot.isLicking && !mouthRoot.isBarking
            width: 5.5; height: 5.5; radius: 2.75; color: "#FB7185"
            border.color: "#E11D48"; border.width: 0.6
            anchors.horizontalCenter: parent.horizontalCenter; y: 11.2
            SequentialAnimation on height {
                running: lickingTongue.visible; loops: Animation.Infinite
                NumberAnimation { to: 7.2; duration: 180; easing.type: Easing.OutSine }
                NumberAnimation { to: 4.5; duration: 160; easing.type: Easing.InOutSine }
            }
        }

        // Khi sủa (barking): khoang miệng mở ra dứt khoát
        Rectangle {
            id: barkMouth
            visible: mouthRoot.isBarking
            width: 11; height: 6; radius: 3; color: "#450A0A"
            anchors.horizontalCenter: parent.horizontalCenter; y: 8.5
            Rectangle {
                width: 7; height: 3.5; radius: 1.75; color: "#FB7185"
                anchors.horizontalCenter: parent.horizontalCenter; anchors.bottom: parent.bottom; anchors.bottomMargin: 0.5
            }
        }
    }
}
