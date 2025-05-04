import QtQuick 2.12
import QtQuick.Controls 2.12
import QtGraphicalEffects 1.0

ApplicationWindow{
    visible: true
    width: 800
    height: 600
    title: qsTr("CAN bus demo")

    RadialGradient {
            z: 1
            visible: enableGradient
            anchors.fill: parent
            gradient: Gradient {
                GradientStop {
                    position: 0.0
                    color: "#00000000"
                }
                GradientStop {
                    position: 0.72
                    color: "#000000"
                }
            }
        }


//    Column{
//        anchors.centerIn: parent
//        width: parent.width * 0.5
//        spacing: 16

//        TextField{
//            id: inputField
//            placeholderText: "Enter message"
//            width: parent.width * 0.8
//        }

//        Button{
//            text: "Send CAN frame"
//            onClicked: canController.sendMessage(inputField.text)
//        }

//        TextArea{
//            id: logBox
//            width: parent.width * 0.8
//            height: 150
//            readOnly: true
//            wrapMode: TextArea.Wrap  // Add this to wrap text
//            clip: true               // Add this to ensure text stays within bounds
//        }
//    }

//    Connections{
//        target: canController
//        onMessageReceived: {
//            logBox.text += "Received: " + msg + "\n"
//        }
//    }

//    Button {
//        text: "Test TextArea"
//        onClicked: {
//            logBox.text = "Test: Hello World - This is a test message\n";
//        }
//    }
}
