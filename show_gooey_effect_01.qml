import QtQuick 2.0
import QtGraphicalEffects 1.0

Item {
    id: root

    Text {
        text: "优化无果，无法做到粘连效果"
    }

    Canvas {
        id: canvas

        visible: false

        property real distance: 1

        anchors.fill: parent

        NumberAnimation on distance {
            id: animation
            duration: 5000
            easing.type: Easing.OutQuad
            running: true
            from: 1
            to: 400
//            to: 280
            loops: Animation.Infinite
        }

        onDistanceChanged: {
            canvas.requestPaint();
        }

        onPaint: {
            getContext("2d").clearRect(0, 0, canvas.width, canvas.height);

            var circle_radius = 50;

            var yPos = canvas.height / 2;
            var xPos = canvas.width / 2;

            // 左边
            var x0Pos = xPos - canvas.distance / 2;

            // 右边
            var x1Pos = xPos + canvas.distance / 2;

            draw_circle(x0Pos, yPos, circle_radius);

            var k =  2 * circle_radius * ((width - distance * 2) / width);
            k = k<=0 ? 1 : k;
            draw_rect_to_link_circles(x0Pos ,
                                      yPos-(k/2),
                                      canvas.distance ,
                                      k);

            draw_circle(x1Pos, yPos, circle_radius);

        }


        function draw_circle(xPos, yPos, radius) {
            var ctx = canvas.getContext("2d");
            ctx.lineWidth = 1;
            ctx.strokeStyle = "black";
            ctx.fillStyle = "black";

            ctx.beginPath();

            ctx.arc(xPos, yPos, radius, 0, Math.PI * 2);
            ctx.fill();
        }

        // 圆心距
        function centerDistance(point0, point1){
            return Math.abs(Math.sqrt(Math.pow(point0.x-point1.x, 2)
                                      +
                                      Math.pow(point0.y-point1.y, 2)));
        }
        function draw_rect_to_link_circles(xPos,
                                           yPos,
                                           w,
                                           h
                                           )
        {
            var ctx = canvas.getContext("2d");
            ctx.lineWidth = 1;
            ctx.strokeStyle = "black";
            ctx.fillStyle = "black";

            ctx.rect( xPos, yPos, w , h);
            ctx.fill();
        }


        function inverse_proportinal(k,x,b) {
            return x === 0 ? b: k/x+b;
        }
    }

    FastBlur {

        id: fastBlur
        anchors.fill: canvas
        source: canvas
        radius: 40
        transparentBorder: true

       //  visible: false
    }

    //! [PhotoShop的自动色阶功能的实现]
    //!(http://www.cnblogs.com/laviewpbt/archive/2009/05/31/1492431.html)
    LevelAdjust {
        anchors.fill: fastBlur
        source: fastBlur
//        minimumOutput: "#ff000000"
//        maximumOutput: "#00ffffff"
        minimumOutput: "#00000000"
        maximumOutput: "#ff000000"
    }



}

