import QtQuick 2.9
import QtQuick.Controls 2.5
import QtQuick.Layouts 1.3
import Style 1.0


////ColumnLayout {
////    spacing: 3

////    // Property to track beam mode
////    property bool isLowBeamOn: false
////    property bool isAutoBeamOn: true

////    Icon {
////        id: lowBeamIcon
////        Layout.alignment: Qt.AlignVCenter
////        icon.source: "qrc:/light-icons/Headlight2.svg"
////        opacity: isLowBeamOn ? 1.0 : 0.3 // Dim when off
////        MouseArea {
////            anchors.fill: parent
////            onClicked: {
////                isLowBeamOn = !isLowBeamOn
////                if (isLowBeamOn) {
////                    isAutoBeamOn = false // Turn off auto beam when low beam is on
////                }
////            }
////        }
////    }

////    Icon {
////        id: autoBeamIcon
////        Layout.alignment: Qt.AlignVCenter
////        icon.source: "qrc:/light-icons/Property 1=Default.svg"
////        opacity: isAutoBeamOn && !isLowBeamOn ? 1.0 : 0.3 // Dim when off
////        MouseArea {
////            anchors.fill: parent
////            onClicked: {
////                if (!isLowBeamOn) {
////                    isAutoBeamOn = !isAutoBeamOn // Toggle auto beam only if low beam is off
////                }
////            }
////        }
////    }
////}
//RowLayout {
//    id: topLeftButtonRow
//    spacing: 4 // Giảm spacing
//    implicitWidth: lowBeamIcon.implicitWidth + autoBeamIcon.implicitWidth + spacing
//    implicitHeight: Math.max(lowBeamIcon.implicitHeight, autoBeamIcon.implicitHeight)
//            // Property to track beam mode
//            property bool isLowBeamOn: false
//            property bool isAutoBeamOn: true

//            Icon {
//                id: lowBeamIcon
//                Layout.alignment: Qt.AlignVCenter // Vertically center in RowLayout
//                icon.source: "qrc:/light-icons/Headlight2.svg"
//                opacity: isLowBeamOn ? 1.0 : 0.3 // Dim when off
//                MouseArea {
//                    anchors.fill: parent
//                    onClicked: {
//                        isLowBeamOn = !isLowBeamOn
//                        if (isLowBeamOn) {
//                            isAutoBeamOn = false // Turn off auto beam when low beam is on
//                        }
//                    }
//                }
//            }

//            Icon {
//                id: autoBeamIcon
//                Layout.alignment: Qt.AlignVCenter // Vertically center in RowLayout
//                icon.source: "qrc:/light-icons/Property 1=Default.svg"
//                opacity: isAutoBeamOn && !isLowBeamOn ? 1.0 : 0.3 // Dim when off
//                MouseArea {
//                    anchors.fill: parent
//                    onClicked: {
//                        if (!isLowBeamOn) {
//                            isAutoBeamOn = !isAutoBeamOn // Toggle auto beam only if low beam is off
//                        }
//                    }
//                }
//            }
//        }

import QtQuick 2.9
import QtQuick.Controls 2.5
import QtQuick.Layouts 1.3
import Style 1.0

RowLayout {
    id: topLeftButtonRow
    spacing: 4
    implicitWidth: lowBeamIcon.implicitWidth + autoBeamIcon.implicitWidth + spacing
    implicitHeight: Math.max(lowBeamIcon.implicitHeight, autoBeamIcon.implicitHeight)


    property bool isLowBeamOn: false
    property bool isAutoBeamOn: true


    function setBeamMode(lowBeam, autoBeam) {
        isLowBeamOn = lowBeam
        isAutoBeamOn = autoBeam
        canController.autoBeamEnabled = autoBeam
        console.log("Low Beam:", isLowBeamOn, "Auto Beam:", isAutoBeamOn)
    }

    Icon {
        id: lowBeamIcon
        Layout.alignment: Qt.AlignVCenter
        icon.source: "qrc:/light-icons/Headlight2.svg"
        opacity: isLowBeamOn ? 1.0 : 0.3 // Bright when on, dim when off
        MouseArea {
            anchors.fill: parent
            onClicked: {
                setBeamMode(true, false) // Low Beam on, Auto Beam off
            }
        }
    }

    Icon {
        id: autoBeamIcon
        Layout.alignment: Qt.AlignVCenter
        icon.source: "qrc:/light-icons/Property 1=Default.svg"
        opacity: isAutoBeamOn ? 1.0 : 0.3 // Bright when on, dim when off
        MouseArea {
            anchors.fill: parent
            onClicked: {
                setBeamMode(false, true) // Auto Beam on, Low Beam off
            }
        }
    }
}

