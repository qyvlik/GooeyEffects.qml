import QtQuick 2.4
import QtQuick.Controls 1.3
import QtQuick.Window 2.2
import QtQuick.Dialogs 1.2

ApplicationWindow {
    title: qsTr("Gooey Drag")
    width: 400
    height: 400
    visible: true

    color: "transparent"

    GooeyDrag {
        id: canvas
        anchors.fill: parent
    }
}
