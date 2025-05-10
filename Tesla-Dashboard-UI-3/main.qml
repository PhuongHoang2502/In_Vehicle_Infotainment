import QtQuick 2.9
import QtQuick.Controls 2.5
import QtQuick.Layouts 1.3
import Style 1.0
import QtGraphicalEffects 1.12
import "Components"
import "qrc:/LayoutManager.js" as Responsive

ApplicationWindow {
    id: root
    width: 1840
    height: 800
    maximumHeight: height
    minimumHeight: height
    maximumWidth: width
    minimumWidth: width
    visible: true
    title: qsTr("Tesla Model 3")
    onWidthChanged: {
        if(adaptive)
            adaptive.updateWindowWidth(root.width)
    }

    onHeightChanged: {
        if(adaptive)
            adaptive.updateWindowHeight(root.height)
    }
    property var adaptive: new Responsive.AdaptiveLayoutManager(root.width,root.height, root.width,root.height)

    FontLoader {
        id: uniTextFont
        source: "qrc:/Fonts/Unitext Regular.ttf"
    }

    background: Loader {
        anchors.fill: parent
        sourceComponent: Style.mapAreaVisible ? backgroundRect : backgroundImage
    }

    Header {
        z: 99
        id: headerLayout
    }

    footer: Footer{
        id: footerLayout
        onOpenLauncher: launcher.open()
    }

//    TopLeftButtonIconColumn {
//        z: 99
//        anchors.left: parent.left
//        anchors.top: headerLayout.bottom
//        anchors.leftMargin: 18
//    }

    Shortcut {
        sequence: "Ctrl+Q"
        onActivated: Qt.quit()
    }

    RowLayout {
        id: mapLayout
        visible: Style.mapAreaVisible
        spacing: 0
        anchors.fill: parent
        Item {
            Layout.preferredWidth: 620
            Layout.fillHeight: true
//            Image {
//                anchors.centerIn: parent
//                source: Style.isDark ? "qrc:/icons/light/sidebar.png" : "qrc:/icons/dark/sidebar-light.png"
//            }
            RowLayout{
                anchors.fill: parent
                spacing: 0
            Page{
                id:leftArea
                Layout.fillHeight: true
                Layout.preferredWidth: 620
                background: Rectangle{
                    anchors.fill: parent
                    color: Style.background
                }
                header: Rectangle{
                    width: parent.width
                    height: 60
                    color: "transparent"

//                    IconButton{
//                        setIcon: "qrc:/icons/tire pressure.svg"
//                        anchors.verticalCenter: parent.verticalCenter
//                        anchors.left: parent.left
//                        anchors.leftMargin: 20
//                    }
//                    TopLeftButtonIconColumn {
//                        z: 60
//                        anchors.verticalCenter: parent.verticalCenter
//                        anchors.right: parent.right
//                        anchors.rightMargin: 20
//                        height: 60
//                    }
//                    RowLayout {
//                            anchors.fill: parent
//                            anchors.margins: 10
//                            spacing: 10

//                            IconButton {
//                                setIcon: "qrc:/icons/tire pressure.svg"
//                                Layout.alignment: Qt.AlignVCenter
//                            }

//                            Item { Layout.fillWidth: true } // Spacer

//                            TopLeftButtonIconColumn {
//                                Layout.alignment: Qt.AlignVCenter
//                            }
//                        }
                    RowLayout {
                            anchors.fill: parent
                            anchors.margins: 10
                            spacing: 10
                            RowLayout {
                                            Layout.alignment: Qt.AlignVCenter
                                            spacing: 5
                                            Image {
                                                Layout.alignment: Qt.AlignHCenter | Qt.AlignVCenter
                                                source: "qrc:/icons/top_header_icons/battery.svg"
                                            }
                                            Text {
                                                Layout.alignment: Qt.AlignHCenter | Qt.AlignVCenter
                                                color: Style.isDark ? Style.white : Style.black10
//                                                text: qsTr("%0 %").arg(batteryPercentage)
                                                text: "90" + "% "
                                                font.family: "Inter"
                                                font.bold: Font.Bold
                                                font.pixelSize: 18
                                            }
                                        }
                            IconButton {
                                setIcon: "qrc:/icons/tire pressure.svg"
                                Layout.alignment: Qt.AlignVCenter
                            }

                            Item { Layout.fillWidth: true } // Spacer

                            TopLeftButtonIconColumn {
                                Layout.alignment: Qt.AlignVCenter
                            }
                        }
                }

                contentItem: Page{
                    anchors.fill: parent
                    padding: 0
                    background: Rectangle{
                        anchors.fill: parent
                        color: "transparent"
                    }
                    header: Rectangle{
                        width: parent.width
                        height: 149
                        color: "transparent"
                        RowLayout {
                            id: gearSelector
                            spacing: 27
                            anchors {
                                bottom: parent.bottom
                                bottomMargin: 10
                                left: parent.left
                                leftMargin: 20
                            }

                            Repeater {
                                model: ["P", "R", "N", "D"]

                                delegate: Label {
                                    text: modelData
                                    opacity: {
                                        // Map CAN gear values to letters
                                        var gearMap = {0: "P", 1: "R", 2: "N", 3: "D"};
                                        return gearMap[canController.gear] === modelData ? 1.0 : 0.4;
                                    }
                                    font.pixelSize: 20
                                    font.family: "Montserrat"
                                    font.bold: Font.Normal
                                    color: Style.fontColor
                                    Layout.alignment: Qt.AlignVCenter
                                }
                            }
                        }

//                        RowLayout{
//                            spacing: 27
//                            anchors{
//                                bottom: parent.bottom
//                                bottomMargin: 10
//                                left: parent.left
//                                leftMargin: 20
//                            }

//                            Label{
//                                text: "R"
//                                opacity: 0.4
//                                font.pixelSize: 20
//                                font.family: "Montserrat"
//                                font.bold: Font.Normal
//                                color: Style.fontColor
//                                Layout.alignment: Qt.AlignVCenter
//                            }
//                            Label{
//                                text: "P"
//                                opacity: 0.4
//                                font.pixelSize: 20
//                                font.family: "Montserrat"
//                                font.bold: Font.Normal
//                                color: Style.fontColor
//                                Layout.alignment: Qt.AlignVCenter
//                            }
//                            Label{
//                                text: "N"
//                                opacity: 0.4
//                                font.pixelSize: 20
//                                font.family: "Montserrat"
//                                font.bold: Font.Normal
//                                color: Style.fontColor
//                                Layout.alignment: Qt.AlignVCenter
//                            }
//                            Label{
//                                text: "D"
//                                font.pixelSize: 20
//                                font.family: "Montserrat"
//                                font.bold: Font.Normal
//                                color: Style.fontColor
//                                Layout.alignment: Qt.AlignVCenter
//                            }
//                        }

//                        Label{
//                            text: "160"
//                            font.pixelSize: 45
//                            font.family: "Montserrat"
//                            font.bold: Font.Normal
//                            color: Style.fontColor
//                            anchors.horizontalCenter: parent.horizontalCenter
//                            anchors.bottom: mphLabel.top
//                            anchors.bottomMargin: 5
//                        }
                        Label {
                            id: speedLabel
                            text: canController.speed
                            font.pixelSize: 45
                            font.family: "Montserrat"
                            font.bold: Font.Normal
                            color: Style.fontColor
                            anchors.horizontalCenter: parent.horizontalCenter
                            anchors.bottom: mphLabel.top
                            anchors.bottomMargin: 5
                        }

                        Label{
                            id:mphLabel
                            text: "km/h"
                            opacity: 0.4
                            font.pixelSize: 20
                            font.family: "Montserrat"
                            font.bold: Font.Normal
                            color: Style.fontColor
                            anchors.horizontalCenter: parent.horizontalCenter
                            anchors.bottom: parent.bottom
                            anchors.bottomMargin: 10
                        }

                        Rectangle{
                            color: "grey"
                            height: 2
                            width: parent.width - 20
                            anchors.leftMargin: 10
                            anchors.rightMargin: 10
                            anchors.left: parent.left
                            anchors.right: parent.right
                            anchors.bottom: parent.bottom
                        }
                    }

                    contentItem:Page {
                        padding: 0
                        background: Rectangle{
                            anchors.fill: parent
                            color: "transparent"
                        }
                        header: Rectangle{
                            width: parent.width
                            height: 80
                            color: "transparent"

                            IconButton{
                                setIcon: "qrc:/icons/steering wheel.svg"
                                anchors.verticalCenter: parent.verticalCenter
                                anchors.left: parent.left
                                anchors.leftMargin: 20
                            }

                            RowLayout{
                                spacing: 10
                                anchors.centerIn: parent
                                IconButton{
                                    id:minus
                                    setIcon:Style.isDark ? "qrc:/icons/dark/minus.svg" : "qrc:/icons/light/minus.svg"
                                    Layout.alignment: Qt.AlignVCenter
                                    onClicked: {
                                        var number = parseInt(cruise_Control.text)
                                        number = number - 1
                                        cruise_Control.text = number
                                    }
                                }
                                Rectangle{
                                    border.width: 4
                                    border.color: "grey"
                                    color: "transparent"
                                    width: minus.width
                                    height: minus.height
                                    radius: height/2
                                    Layout.alignment: Qt.AlignVCenter
                                    Label{
                                        id:cruise_Control
                                        text: "30"
                                        opacity: 0.4
                                        font.pixelSize: 24
                                        font.family: "Montserrat"
                                        font.bold: Font.DemiBold
                                        color: Style.fontColor
                                        anchors.centerIn: parent
                                    }
                                }

                                IconButton{
                                    id:plus
                                    setIcon: Style.isDark ? "qrc:/icons/dark/plus.svg" : "qrc:/icons/light/plus.svg"
                                    Layout.alignment: Qt.AlignVCenter
                                    onClicked: {
                                        var number = parseInt(cruise_Control.text)
                                        number = number + 1
                                        cruise_Control.text = number
                                    }
                                }
                            }

                            IconButton{
                                setIcon: "qrc:/icons/Speed Limit.svg"
                                anchors.verticalCenter: parent.verticalCenter
                                anchors.right: parent.right
                                anchors.rightMargin: 20
                            }
                        }
                        contentItem:SwipeView {
                            id: view
                            currentIndex: 1
                            anchors.fill: parent

                            Page {
                                id: firstPage
                                padding: 0
                                background: Rectangle{
                                    anchors.fill: parent
                                    color: "transparent"
                                }
                                Image{
                                    source: Style.isDark ? "qrc:/icons/dark/Group.png" : "qrc:/icons/light/Group.png"
                                    anchors.centerIn: parent
                                }
                            }

                            Page {
                                id: secondPage
                                padding: 0
                                background: Rectangle{
                                    anchors.fill: parent
                                    color: "transparent"
                                }
                                Image{
                                    source: Style.isDark ? "qrc:/icons/dark/Group.png" : "qrc:/icons/light/Group.png"
                                    anchors.centerIn: parent
                                }
                            }

                            Page {
                                id: thirdPage
                                padding: 0
                                background: Rectangle{
                                    anchors.fill: parent
                                    color: "transparent"
                                }

                                TButton{
                                    text: "open"
                                    anchors.horizontalCenter: model3.horizontalCenter
                                    anchors.bottom: model3.top
                                }

                                Image{
                                    id:glow
                                    smooth: true
                                    visible: Style.isDarkMode
                                    source: "qrc:/icons/Cars/headlights.png"
                                    anchors.bottom: model3.top
                                    anchors.horizontalCenter: model3.horizontalCenter
                                    anchors.bottomMargin: - 60
                                }

                                Image{
                                    id:model3
                                    source: Style.isDark ? "qrc:/icons/Cars/model 3_new.svg" : "qrc:/icons/Cars/model 3-1_new.svg"
                                    anchors.centerIn: parent
                                }

                                TButton{
                                    text: "open"
                                    anchors.horizontalCenter: model3.horizontalCenter
                                    anchors.top: model3.bottom
                                }

                                TButton{
                                    property bool isGlow: Style.isDarkMode
                                    setIcon: Style.isDark ? "qrc:/icons/dark/scale.svg" : "qrc:/icons/light/scale.svg"
                                    anchors.verticalCenter: model3.verticalCenter
                                    anchors.right: model3.left
                                    anchors.leftMargin: 10
                                    onClicked: {
                                        isGlow = !isGlow
                                        if(!isGlow){
                                            glow.visible = false
                                            model3.source = "qrc:/icons/Cars/model 3-1_new.svg"
                                        }else{
                                            glow.visible =   Style.isDark
                                            model3.source =  Style.isDark ? "qrc:/icons/Cars/model 3_new.svg" : "qrc:/icons/Cars/model 3-1_new.svg"
                                        }
                                    }
                                }
                            }
                        }
                    }

//                    footer: Rectangle{
//                        width: parent.width
//                        height: 120
//                        color: "transparent"

//                        RowLayout{
//                            anchors.centerIn: parent
//                            spacing: 100
//                            IconButton{
//                                setIcon: Style.isDark ? "qrc:/icons/camera.svg" : "qrc:/icons/dark/camera.svg"
//                            }
//                            IconButton{
//                                setIcon: Style.isDark ? "qrc:/icons/power.svg" : "qrc:/icons/dark/power.svg"
//                            }

//                            IconButton{
//                                setIcon: Style.isDark ? "qrc:/icons/microphone.svg" : "qrc:/icons/dark/microphone.svg"
//                            }
//                        }
//                        footer:Item{
//                            width: parent.width
//                            height: 40
//                            PageIndicator {
//                                count: view.count
//                                currentIndex: view.currentIndex
//                                interactive: true
//                                anchors.centerIn: parent
//                            }
//                        }
//                    }


                }
            }
        }
    }
        NavigationMapHelperScreen {
            Layout.fillWidth: true
            Layout.fillHeight: true
            runMenuAnimation: true
        }
    }

    LaunchPadControl {
        id: launcher
        y: (root.height - height) / 2 + (footerLayout.height)
        x: (root.width - width ) / 2
    }

    Component {
        id: backgroundRect
        Rectangle {
            color: "#171717"
            anchors.fill: parent
        }
    }

    Component {
        id: backgroundImage
        Image {
            source: Style.getImageBasedOnTheme()
            Icon {
                icon.source: Style.isDark ? "qrc:/icons/car_action_icons/dark/lock.svg" : "qrc:/icons/car_action_icons/lock.svg"
                anchors.horizontalCenter: parent.horizontalCenter
                anchors.verticalCenter: parent.verticalCenter
                anchors.verticalCenterOffset: - 350
                anchors.horizontalCenterOffset: 37
            }

            Icon {
                icon.source: Style.isDark ? "qrc:/icons/car_action_icons/dark/Power.svg" : "qrc:/icons/car_action_icons/Power.svg"
                anchors.horizontalCenter: parent.horizontalCenter
                anchors.verticalCenter: parent.verticalCenter
                anchors.verticalCenterOffset: - 77
                anchors.horizontalCenterOffset: 550
            }

            ColumnLayout {
                anchors.horizontalCenter: parent.horizontalCenter
                anchors.verticalCenter: parent.verticalCenter
                anchors.verticalCenterOffset: - 230
                anchors.horizontalCenterOffset: 440

                Text {
                    Layout.alignment: Qt.AlignVCenter | Qt.AlignHCenter
                    text: "Trunk"
                    font.family: "Inter"
                    font.pixelSize: 14
                    font.bold: Font.DemiBold
                    color: Style.black20
                }
                Text {
                    Layout.alignment: Qt.AlignVCenter | Qt.AlignHCenter
                    text: "Open"
                    font.family: "Inter"
                    font.pixelSize: 16
                    font.bold: Font.Bold
                    color: Style.isDark ? Style.white : "#171717"
                }
            }

            ColumnLayout {
                anchors.horizontalCenter: parent.horizontalCenter
                anchors.verticalCenter: parent.verticalCenter
                anchors.verticalCenterOffset: - 180
                anchors.horizontalCenterOffset: - 350

                Text {
                    Layout.alignment: Qt.AlignVCenter | Qt.AlignHCenter
                    text: "Frunk"
                    font.family: "Inter"
                    font.pixelSize: 14
                    font.bold: Font.DemiBold
                    color: Style.black20
                }
                Text {
                    Layout.alignment: Qt.AlignVCenter | Qt.AlignHCenter
                    text: "Open"
                    font.family: "Inter"
                    font.pixelSize: 16
                    font.bold: Font.Bold
                    color: Style.isDark ? Style.white : "#171717"
                }
            }
        }
    }
}
