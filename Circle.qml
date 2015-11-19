import QtQuick 2.0

Canvas {
    id: circle

    transformOrigin: Item.Center

    width: radius * 2
    height: radius * 2

    readonly property point center: Qt.point(width / 2, height / 2)

    property real radius: 50
    property color color: "white"
    property real borderWidth: 0
    property color borderColor: "white"

    onPaint: {
        var ctx = circle.getContext("2d");
        ctx.lineWidth = circle.borderWidth;
        ctx.strokeStyle = circle.borderColor;
        ctx.fillStyle = circle.color;

        ctx.beginPath();

        ctx.arc(width / 2, height / 2, radius, 0, Math.PI * 2);

        // ctx.stroke();
        ctx.fill();
    }
}

