import QtQuick 2.4
import QtQuick.Controls 1.3

ApplicationWindow {
    title: qsTr("Gooey Example")
    width: 800
    height: 600
    visible: true

    TabView {
        anchors.fill: parent

        Tab {
            title: "gooey drag"
            source: "./show_gooey_drag.qml"
        }

        Tab {
            title: "gooey tail"
            source: "./show_gooey_tail.qml"
        }

        Tab {
            title: "gooey tail"
            source: "./show_gooey_effect_01.qml"
        }

    }

    //color: "transparent"
}

