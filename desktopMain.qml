import QtQuick 2.3
import QtQuick.Controls 1.2
import QtMultimedia 5.0
import QtQuick.Layouts 1.1
import QtQuick.Controls.Styles 1.0

ApplicationWindow {
    id: mainWindow
    width: 1024
    height: 768
    title: qsTr("Game Of Thrones boardgame assister")
    visible: true


    Item
    {
        //App Window не содержит States
        id: root
        anchors.fill: parent
        property bool timerSettings: false
        property bool wildingsSettings: false
        property bool westerosCardsSettings: false
        Component.onCompleted: state = "options"
        states:
            [
                State
                {
                    name: "options"
                    PropertyChanges
                    {
                        target: options
                        visible: true
                    }
                    PropertyChanges
                    {
                        target: nextRoundButton
                        onClicked: root.state = "pick"
                    }
                    PropertyChanges
                    {
                        target: nextRoundButtonText
                        text: "Start the game"
                    }
                },
                State
                {
                    name: "pick"
                    PropertyChanges
                    {
                        target: picker
                        visible: true
                    }
                    PropertyChanges
                    {
                        target: nextRoundButton
                        enabled: false
                        onClicked: root.state = "map preparation"
                    }
                    PropertyChanges
                    {
                        target: nextRoundButtonText
                        text: "Next"
                    }
                },
                State
                {
                    name: "map preparation"
                    PropertyChanges {
                        target: mapPreparation
                        visible: true
                    }
                    PropertyChanges
                    {
                        target: nextRoundButtonText
                        text: "Next"
                    }
                    PropertyChanges
                    {
                        target: nextRoundButton
                        onClicked: root.state = "planning phase"
                    }
                },
                State
                {
                    name: "planning phase"
                    PropertyChanges {
                        target: planningPhaseDescription
                        visible: true
                    }
                    PropertyChanges
                    {
                        target: nextRoundButton
                        onClicked: root.state = "action phase 1"
                    }
                },
                State
                {
                    name: "action phase 1"
                    PropertyChanges {
                        target: stub
                        visible: true
                    }
                }

            ]

        Item
        {
            id: options
            visible: false
            anchors.fill: contentBlock
            anchors.margins: 10
            z: contentBlock.z + 1
            Rectangle
            {
                anchors.fill: parent
                color: "#80F0E68C"
                ColumnLayout
                {
                    CheckBox
                    {
                        text: "timer"
                        onCheckedChanged: root.timerSettings = checked
                    }
                    CheckBox
                    {
                        text: "wildings"
                        onCheckedChanged: root.wildingsSettings = checked
                    }
                    CheckBox
                    {
                        text: "westerosCards"
                        onCheckedChanged: root.westerosCardsSettings = checked
                    }
                }
            }
        }


        Picker
        {
            id: picker
            visible: false
            anchors.fill: contentBlock
            anchors.margins: 10
            z: contentBlock.z + 1
            property var ravenPlaces :
            {
                "Lannister": 0,
                "Stark": 1,
                "Martell": 2,
                "Baratheon": 3,
                "Tyrell": 4,
                "GreyJoy": 5
            }
            property var swordPlaces :
            {
                "GreyJoy": 0,
                "Tyrell": 1,
                "Martell": 2,
                "Stark": 3,
                "Baratheon": 4,
                "Lannister": 5
            }
            property var thronePlaces :
            {
                "Baratheon": 0,
                "Lannister": 1,
                "Stark": 2,
                "Martell": 3,
                "GreyJoy": 4,
                "Tyrell": 5
            }

            function moveTokenToInfluenceTrack(name, track, place)
            {
                var token = track.factions[name]
                token.x = -token.parent.x -contentBlock.width + picker.anchors.margins + picker.animationph.x - token.width/2
                token.y = picker.anchors.margins + picker.animationph.y - token.height/2
                token.visible = true
                track.putFaction(token, ravenTrack.slots[place])
            }

            onFactionPicked:
            {
                moveTokenToInfluenceTrack(name, ravenTrack, ravenPlaces[name])
                moveTokenToInfluenceTrack(name, swordTrack, swordPlaces[name])
                moveTokenToInfluenceTrack(name, throneTrack, thronePlaces[name])
            }
            onPickFinished:
            {
                nextRoundButton.enabled = true
                picker.visible = false
            }
        }

        MapPrep
        {
            id: mapPreparation
            anchors.fill: contentBlock
            anchors.margins: 10
            visible: false
            z: contentBlock.z + 1
        }
        PlanningPhaseDescription
        {
            id: planningPhaseDescription
            anchors.fill: contentBlock
            anchors.margins: 10
            visible: false
            z: contentBlock.z + 1
        }

        Item
        {
            id: stub
            anchors.fill: contentBlock
            anchors.margins: 10
            visible: false
            z: contentBlock.z + 1
            Text
            {
                height: parent.height
                width: parent.width
                text: "В РАЗРАБОТКЕ"
                font.bold: true
                fontSizeMode: Text.Fit
                font.pixelSize: height
                horizontalAlignment: Text.AlignHCenter
                verticalAlignment: Text.AlignVCenter
            }
        }

        Item
        {
            id: leftColumn
            anchors.top: parent.top
            anchors.bottom: parent.bottom
            anchors.left: parent.left
            width: parent.width * 0.28
            Item
            {
                id: roundBlock
                anchors.top: parent.top
                anchors.left: parent.left
                anchors.right: parent.right
                height: parent.height * 0.23
                Rectangle
                {
                    anchors.fill: parent
                    color: "#915F19"
                }

                ColumnLayout
                {
                    anchors.centerIn: parent
                    width: parent.width * 0.9
                    height: parent.height * 0.8
                    Item
                    {
                        Layout.fillWidth: true
                        Layout.fillHeight: true
                        Text
                        {
                            height: parent.height
                            width: parent.width
                            text: "- Round 1 -"
                            font.bold: true
                            fontSizeMode: Text.Fit
                            font.pixelSize: height
                            horizontalAlignment: Text.AlignHCenter
                            verticalAlignment: Text.AlignVCenter
                        }
                    }

                    Item
                    {
                        Layout.fillWidth: true
                        Layout.fillHeight: true
                        Rectangle
                        {
                            color: "#29A5E3"
                            anchors.fill: parent
                            Text
                            {
                                id: nextRoundButtonText
                                height: parent.height
                                width: parent.width
                                text: "Next Round"
                                font.bold: true
                                fontSizeMode: Text.Fit
                                font.pixelSize: height
                                horizontalAlignment: Text.AlignHCenter
                                verticalAlignment: Text.AlignVCenter
                                MouseArea
                                {
                                    id: nextRoundButton
                                    anchors.fill: parent
                                }
                            }
                        }
                    }
                }
            }
            Item
            {
                anchors.left: parent.left
                anchors.right: parent.right
                anchors.bottom: parent.bottom
                anchors.top: roundBlock.bottom
                ColumnLayout
                {
                    anchors.fill: parent
                    spacing: 0
                    id: statusTrack
                    StatusPosition
                    {
                        source: "qrc:/images/Houses/greyjoy.png"
                        name: "greyJoy"
                        castles: 5
                        supplies: 2
                        Layout.fillWidth: true
                        Layout.fillHeight: true
                    }
                    StatusPosition
                    {
                        source: "qrc:/images/Houses/stark.png"
                        name: "stark"
                        castles: 7
                        supplies: 5
                        Layout.fillWidth: true
                        Layout.fillHeight: true
                    }
                    StatusPosition
                    {
                        source: "qrc:/images/Houses/lannister.png"
                        name: "lannister"
                        castles: 6
                        supplies: 3
                        Layout.fillWidth: true
                        Layout.fillHeight: true
                    }
                    StatusPosition
                    {
                        source: "qrc:/images/Houses/martell.png"
                        name: "martell"
                        castles: 4
                        supplies: 4
                        Layout.fillWidth: true
                        Layout.fillHeight: true
                    }
                    StatusPosition
                    {
                        source: "qrc:/images/Houses/baratheon.png"
                        name: "baratheon"
                        castles: 1
                        supplies: 2
                        Layout.fillWidth: true
                        Layout.fillHeight: true
                    }
                    StatusPosition
                    {
                        source: "qrc:/images/Houses/tyrel.png"
                        name: "Tyrell"
                        castles: 0
                        supplies: 0
                        Layout.fillWidth: true
                        Layout.fillHeight: true
                    }
                }
            }
        }
        Item
        {
            z: parent.z + 2
            id: rightColumn
            anchors.top: parent.top
            anchors.bottom: parent.bottom
            anchors.right: parent.right
            width: parent.width * 0.3
            RowLayout
            {
                anchors.fill: parent
                spacing: 0

                InfluenceTrack
                {
                    id: throneTrack
                    Layout.fillWidth: true
                    Layout.fillHeight: true
                    imageSrc: "qrc:/images/throne.png"
                    verticalOrientation: true
                    Component.onCompleted: hideTokens()
                }
                InfluenceTrack
                {
                    id: swordTrack
                    Layout.fillWidth: true
                    Layout.fillHeight: true
                    imageSrc: "qrc:/images/sword.png"
                    Component.onCompleted: hideTokens()
                    verticalOrientation: true
                }
                InfluenceTrack
                {
                    id: ravenTrack
                    Layout.fillWidth: true
                    Layout.fillHeight: true
                    imageSrc: "qrc:/images/raven.png"
                    verticalOrientation: true
                    Component.onCompleted: hideTokens()
                }

            }
        }
        Item
        {
            id: contentBlock
            anchors.left: leftColumn.right
            anchors.top: parent.top
            anchors.bottom: parent.bottom
            anchors.right: rightColumn.left
            Image
            {
                anchors.fill: parent
                source: "qrc:/images/background.png"
            }
        }

    }

















}
