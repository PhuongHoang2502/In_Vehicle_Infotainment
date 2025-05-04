//#include "cancontroller.h"
//#include <QtSerialBus/QCanBus>
//#include <QtSerialBus/QCanBusFrame>
//#include <QDebug>

//CanController::CanController(QObject *parent) : QObject(parent){
//    canDevice =QCanBus::instance()->createDevice("socketcan", "vcan0");
//    if(!canDevice || !canDevice->connectDevice()){
//        qWarning("Failed to connect to CAN device");
//        return;
//    }

//    connect(canDevice, &QCanBusDevice::framesReceived, this, &CanController::receiveCanFrame);
//}

//void CanController::sendMessage(const QString &message){
//    if(!canDevice)
//        return;

//    QByteArray payload = message.toUtf8();
//    QCanBusFrame frame(0x123, payload);
//    canDevice->writeFrame(frame);
//}

//void CanController::receiveCanFrame(){
//    if (!canDevice)
//            return;

//        while (canDevice->framesAvailable()) {
//            QCanBusFrame frame = canDevice->readFrame();
//            QByteArray payload = frame.payload();

//            qDebug() << "Raw payload:" << payload.toHex();  // 🔥 Print raw hex

//            QString message = QString::fromUtf8(payload);
//            qDebug() << message;
//            emit messageReceived(message);
//        }
//}
