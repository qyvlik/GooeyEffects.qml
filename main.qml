import QtQuick 2.4
import QtQuick.Controls 1.3
import QtQuick.Window 2.2
import QtQuick.Dialogs 1.2

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

    }

    //color: "transparent"





}

