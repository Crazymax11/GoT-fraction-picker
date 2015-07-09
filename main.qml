import QtQuick 2.3
import QtQuick.Controls 1.2
import QtMultimedia 5.0
import QtQuick.Layouts 1.1


ApplicationWindow {
    id: mainWindow
    visible: true
    width: 480
    height: 640
    title: qsTr("Faction picker")
    Image
    {
        anchors.fill: parent
        source: "qrc:/images/background.png"
    }

    Audio
    {
        id: audioBackground
        source: "qrc:/sounds/background.mp3"
        loops: Audio.Infinite
        volume: 0.5
        autoPlay: true
    }

    Rectangle
    {
        id: backButton
        anchors.top: parent.top
        anchors.right: parent.right
        width: parent.width/10
        height: parent.height/15

        visible: false
        color: "darkorange"
        z: 100
        Image
        {
            anchors.fill: parent
            source: "qrc:/images/backButton.png"
        }
        MouseArea
        {
            anchors.fill: parent
            onClicked:
            {
                mainMenuButtons.visible = true
                backButton.visible = false
                loder.source = ""
            }
        }
    }


    Rectangle
    {
        id: musicButton
        color: "cornflowerblue"
        border.width: 3
        border.color: "blue"
        z: 100
        anchors.right: backButton.left
        width: parent.width/10
        height: parent.height/15
        MouseArea
        {
            anchors.fill: parent
            property bool isAudioOn: true
            onClicked:
            {
                isAudioOn? audioBackground.pause() : audioBackground.play()
                isAudioOn = !isAudioOn
            }
            onIsAudioOnChanged:
            {
                isAudioOn? musicImage.source="qrc:/images/musicOn.png" : musicImage.source="qrc:/images/musicOff.png"
            }
        }

        Image
        {
            id: musicImage
            anchors.fill: parent
            source: "qrc:/images/musicOn.png"
        }
    }

    Loader
    {
        id: loder
        anchors.fill: parent
        source: ""
    }
    ColumnLayout
    {
        id: mainMenuButtons
        width: parent.width * 8/10
        height: parent.height * 9/10
        x: parent.width * 1/10
        y: parent.height * 1/10
        Rectangle
        {
            width: parent.width
            height: parent.height * 2/10
            Text
            {
                anchors.fill: parent
                text: "Пикер"
            }
            color: "blue"
            MouseArea
            {
                anchors.fill: parent
                onClicked:
                {
                    mainMenuButtons.visible = false
                    loder.source = "qrc:/FactionPicker.qml"
                    backButton.visible = true
                }

            }
        }
        Rectangle
        {
            y: parent.x + parent.height * 2/10 + 20
            width: parent.width
            height: parent.height * 2/10
            Text
            {
                anchors.fill: parent
                text: "Треки"
            }
            color: "red"

            MouseArea
            {
                anchors.fill: parent
                onClicked:
                {
                    mainMenuButtons.visible = false
                    loder.source = "qrc:/trackWindow.qml"
                    backButton.visible = true
                }

            }
        }
    }


}
