import QtQuick 2.0
import QtQuick.Controls 1.4
import QtQuick.Layouts 1.1
import QtGraphicalEffects 1.0

Item {
    id: root
    anchors.fill: parent

    Text {
        anchors.centerIn: parent
        text: qsTr("点击查看效果")
    }


    GooeyTail {
        id: gooeyTail
        width: 160
        height: 40
        anchors.verticalCenter: parent.verticalCenter
    }




    state: "left"

    states: [
        State {
            name: "left"
            PropertyChanges {
                target: gooeyTail
                x: 0
                // 收缩
                state: "shrink"
            }
        },

        State {
            name: "right"
            PropertyChanges {
                target: gooeyTail
                x: root.width - gooeyTail.width
                // 伸展
                state: "stretch"
            }
        }
    ]

    transitions: [
        Transition {
            id: left_to_right
            from: "left"
            to: "right"
            NumberAnimation {
                property: "x"
                easing.type: Easing.InCubic
                duration: 500
            }
            onRunningChanged: {
                // console.log(left_to_right.running);
                if(!left_to_right.running) {
                    gooeyTail.state = "shrink"
                }
            }

        },
        Transition {
            id: right_to_left
            from: "right"
            to: "left"
            NumberAnimation {
                property: "x"
                duration: 500
            }
        }
    ]

    MouseArea {
        anchors.fill: parent
        onClicked: {
            if(root.state != "left") {
                root.state = "left";
            } else {
                root.state = "right";
            }
        }
    }

}
