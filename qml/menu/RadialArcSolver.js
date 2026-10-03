// Thuật toán tính góc xoay: Xoay xuống dưới khi mở chat hoặc cấn mép trên
.pragma library

function solveArcLayout(dogX, dogY, dogW, dogH, screenW, screenH, radius, isChatOpen) {
    var pad = radius + 30;
    var targetDogX = dogX;
    var targetDogY = dogY;

    var cX = dogX + dogW / 2;
    var cY = dogY + dogH / 2;

    var leftSpace = cX;
    var rightSpace = screenW - cX;
    var topSpace = cY;
    var bottomSpace = screenH - cY;

    // Đẩy nhẹ chú cún nếu bị kẹt sát góc
    if (leftSpace < pad && topSpace < pad) {
        targetDogX = Math.max(dogX, pad - dogW / 2);
        targetDogY = Math.max(dogY, pad - dogH / 2);
    } else if (rightSpace < pad && topSpace < pad) {
        targetDogX = Math.min(dogX, screenW - pad - dogW / 2);
        targetDogY = Math.max(dogY, pad - dogH / 2);
    } else if (rightSpace < pad && bottomSpace < pad) {
        targetDogX = Math.min(dogX, screenW - pad - dogW / 2);
        targetDogY = Math.min(dogY, screenH - pad - dogH / 2);
    } else if (leftSpace < pad && bottomSpace < pad) {
        targetDogX = Math.max(dogX, pad - dogW / 2);
        targetDogY = Math.min(dogY, screenH - pad - dogH / 2);
    }

    cX = targetDogX + dogW / 2;
    cY = targetDogY + dogH / 2;
    leftSpace = cX; rightSpace = screenW - cX;
    topSpace = cY; bottomSpace = screenH - cY;

    // Xác định góc trung tâm: Nếu mở chat -> chúc xuống dưới (270 độ)
    var centerAngle = 90;
    if (isChatOpen) {
        centerAngle = 270;
    } else if (topSpace < pad) {
        if (bottomSpace >= pad) centerAngle = 270;
        else if (leftSpace > rightSpace) centerAngle = 180;
        else centerAngle = 0;
    } else if (rightSpace < pad) {
        centerAngle = 135;
    } else if (leftSpace < pad) {
        centerAngle = 45;
    }

    var totalSpan = 160;
    var count = 7;
    var step = totalSpan / (count - 1);
    var startAngle = centerAngle + (totalSpan / 2);
    var angles = [];

    for (var i = 0; i < count; i++) {
        angles.push(startAngle - i * step);
    }

    return {
        targetX: targetDogX,
        targetY: targetDogY,
        angles: angles
    };
}
