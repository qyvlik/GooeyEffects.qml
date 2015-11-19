/*!
 * author: qyvlik
*/
import QtQuick 2.0

Canvas {
    id: gooeyDrag

    width: 400
    height: 400

    clip: false

    property real bigRadius: 20
    property real smallRasius: bigRadius * 0.8
    property point bigCirclePoint: Qt.point(bigCircle.x + bigCircle.radius,
                                            bigCircle.y + bigCircle.radius)
    property point smallCirclePoint: Qt.point(width/2, height/2)

    Circle {
        id: smallCircle
        x: gooeyDrag.smallCirclePoint.x - smallCircle.radius
        y: gooeyDrag.smallCirclePoint.y - smallCircle.radius
        radius: gooeyDrag.smallRasius
        color: "red"
    }

    Circle {
        id: bigCircle
        x: gooeyDrag.width / 2 - bigCircle.radius
        y: gooeyDrag.height / 2 - bigCircle.radius
        radius: gooeyDrag.bigRadius
        color: "red"

        states: [
            State {
                name: "back"
                PropertyChanges {
                    target: bigCircle
                    x: gooeyDrag.width / 2- bigCircle.radius
                    y: gooeyDrag.height / 2- bigCircle.radius
                }
            }
        ]

        transitions: Transition {
            PropertyAnimation {
                properties: "x,y";
                easing.type: Easing.OutBack
            }
        }

        MouseArea {
            anchors.fill: parent
            drag.target: bigCircle

            onPressed: {
                bigCircle.state = ""
            }

            onReleased: {
                bigCircle.state = "back";
            }
        }

    }


    onBigCirclePointChanged: {
        // console.log(bigCircle)
        gooeyDrag.requestPaint();
    }

    onPaint: {
        var ctx = getContext("2d");

        ctx.clearRect(0, 0, width, height);

        // 两圆心距离
        var distance = centerDistance(bigCirclePoint, smallCirclePoint);

        // 圆心距越大，小圆半径越小
        var k = smallRasius * ((width - distance * 2) / width);

        k = k < 0 ? 0: k;

        // 绘制小圆
        smallCircle.radius = k;

        // 获取小圆信息
        var x1 = smallCirclePoint.x;
        var y1 = smallCirclePoint.y;
        var r1 = k;

        // 绘制大圆
        bigCircle.radius = bigRadius;
        // 获取大圆信息
        var x2 = bigCirclePoint.x;
        var y2 = bigCirclePoint.y;
        var r2 = bigRadius ;


        var sinA = (y2 - y1) / distance;
        var cosA = (x2 - x1) / distance;

        var pointA = Qt.point(x1 - sinA*r1, y1 + cosA * r1);
        var pointB = Qt.point(x1 + sinA*r1, y1 - cosA * r1);
        var pointC = Qt.point(x2 + sinA*r2, y2 - cosA * r2);
        var pointD = Qt.point(x2 - sinA*r2, y2 + cosA * r2);

        //  获取控制点，以便画出曲线
        var pointO = Qt.point(pointA.x + distance / 2 * cosA ,
                              pointA.y + distance / 2 * sinA);

        var pointP = Qt.point(pointB.x + distance / 2 * cosA ,
                              pointB.y + distance / 2 * sinA);


        ctx.lineWidth = 0;
        ctx.fillStyle = "red";

        // Adds a quadratic bezier curve between the current point and the endpoint (x, y)
        // with the control point specified by (cpx, cpy).
        // quadraticCurveT(real cpx, real cpy, real x, real y)
        // 第一二个是控制点，第三四个是终点。

        ctx.beginPath();
        ctx.moveTo(pointA.x, pointA.y);

        ctx.lineTo(pointB.x, pointB.y);
        ctx.quadraticCurveTo(pointP.x, pointP.y,
                             pointC.x , pointC.y);

        ctx.lineTo(pointD.x, pointD.y);

        ctx.quadraticCurveTo(pointO.x, pointO.y,
                             pointA.x , pointA.y);



        ctx.fill();
    }

    // 圆心距
    function centerDistance(point0, point1){
        return Math.abs(Math.sqrt(Math.pow(point0.x-point1.x, 2)
                                  +
                                  Math.pow(point0.y-point1.y, 2)));
    }
}

