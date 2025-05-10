#include "CanController.h"
#include <QDebug>

CanController::CanController(QObject *parent) : QObject(parent),
                                                m_canDevice(nullptr),
                                                m_gear(0),
                                                m_speed(0),
                                                m_light(0),
                                                m_temperature(0.0),
                                                m_humidity(0),
                                                m_distance(0),
                                                m_buzzerEnabled(false),
                                                m_ledOn(false)
{
}

CanController::~CanController()
{
    if (m_canDevice)
    {
        m_canDevice->disconnectDevice();
        delete m_canDevice;
    }
}

bool CanController::initialize()
{
    QStringList plugins = QCanBus::instance()->plugins();
    qDebug() << "Available QCanBus plugins:" << plugins;
    if (!plugins.contains("socketcan"))
    {
        qWarning() << "SocketCAN plugin not available. Ensure qtserialbus5-dev and libsocketcan-dev are installed.";
        return false;
    }

    QString errorString;
    m_canDevice = QCanBus::instance()->createDevice("socketcan", "vcan0", &errorString);
    if (!m_canDevice)
    {
        qWarning() << "Failed to create CAN device:" << errorString;
        return false;
    }

    //    m_canDevice->setConfigurationParameter(QCanBusDevice::BitRateKey, 500000);

    connect(m_canDevice, &QCanBusDevice::framesReceived, this, &CanController::receiveCanFrame);
    connect(m_canDevice, &QCanBusDevice::errorOccurred, this, &CanController::handleCanError);

    if (!m_canDevice->connectDevice())
    {
        qWarning() << "Failed to connect to CAN device:" << m_canDevice->errorString();
        delete m_canDevice;
        m_canDevice = nullptr;
        return false;
    }

    qDebug() << "CAN device state:" << m_canDevice->state();
    qDebug() << "CAN device initialized successfully on can0";



    // Gắn tín hiệu thay đổi speed/light để gọi logic điều khiển đèn pha
    connect(this, &CanController::speedChanged, this, &CanController::updateAutoHeadlight);
    connect(this, &CanController::lightChanged, this, &CanController::updateAutoHeadlight);

    return true;
}

void CanController::receiveCanFrame()
{
    if (!m_canDevice)
        return;

    while (m_canDevice->framesAvailable())
    {
        QCanBusFrame frame = m_canDevice->readFrame();
        if (!frame.isValid())
            continue;

        quint32 id = frame.frameId();
        QByteArray payload = frame.payload();

        // Log raw payload for debugging
        qDebug() << "Received CAN ID:" << QString::number(id, 16) << "Payload:" << payload.toHex();

        switch (id)
        {
        case 0x100: // Gear
            if (payload.size() >= 1)
            {
                int newGear = payload[0];
                if (newGear != m_gear)
                {
                    m_gear = newGear;
                    emit gearChanged();
                }
            }
            break;
        case 0x101: // Speed
            if (payload.size() >= 2)
            {
                int newSpeed = (static_cast<uint8_t>(payload[0]) << 8) | static_cast<uint8_t>(payload[1]);
                if (newSpeed != m_speed)
                {
                    m_speed = newSpeed;
                    qDebug() << "Speed updated to:" << m_speed;
                    emit speedChanged();
                    updateAutoHeadlight();
                }
            }
            break;
        case 0x102: // Light
            if (payload.size() >= 1)
            {
                int newLight = payload[0];
                if (newLight != m_light)
                {
                    m_light = newLight;
                    emit lightChanged();
                    updateAutoHeadlight();
                }
            }
            break;
        case 0x103: // Temperature
            if (payload.size() >= 2)
            {
                float newTemp = ((payload[0] << 8) | payload[1]) / 10.0;
                if (newTemp != m_temperature)
                {
                    m_temperature = newTemp;
                    emit temperatureChanged();
                }
            }
            break;
        case 0x104: // Humidity
            if (payload.size() >= 1)
            {
                int newHumidity = payload[0];
                if (newHumidity != m_humidity)
                {
                    m_humidity = newHumidity;
                    emit humidityChanged();
                }
            }
            break;
        case 0x105: // Distance
            if (payload.size() >= 2)
            {
                int newDistance = (payload[0] << 8) | payload[1];
                if (newDistance != m_distance)
                {
                    m_distance = newDistance;
                    emit distanceChanged();
                }
            }
            break;
        case 0x106: // Buzzer state
            if (payload.size() >= 1)
            {
                bool newBuzzer = payload[0] != 0;
                if (newBuzzer != m_buzzerEnabled)
                {
                    m_buzzerEnabled = newBuzzer;
                    emit buzzerEnabledChanged();
                }
            }
            break;
        case 0x107: // LED state
            if (payload.size() >= 1)
            {
                bool newLed = payload[0] != 0;
                if (newLed != m_ledOn)
                {
                    m_ledOn = newLed;
                    emit ledOnChanged();
                }
            }
            break;
        }
    }
}

void CanController::handleCanError(QCanBusDevice::CanBusError error)
{
    qWarning() << "CAN error:" << m_canDevice->errorString();
    if (error == QCanBusDevice::ConnectionError || error == QCanBusDevice::ConfigurationError)
    {
        qWarning() << "Attempting to reconnect CAN device";
        m_canDevice->disconnectDevice();
        if (m_canDevice->connectDevice())
        {
            qDebug() << "CAN device reconnected";
        }
        else
        {
            qWarning() << "Reconnection failed:" << m_canDevice->errorString();
        }
    }
}

void CanController::sendCanMessage(quint32 id, const QByteArray &data)
{
    if (!m_canDevice)
        return;

    QCanBusFrame frame(id, data);
    m_canDevice->writeFrame(frame);
    qDebug() << "Sent CAN ID:" << QString::number(id, 16) << "Payload:" << data.toHex();
}

void CanController::toggleBuzzer()
{
    m_buzzerEnabled = !m_buzzerEnabled;
    QByteArray data(1, m_buzzerEnabled ? 1 : 0);
    sendCanMessage(0x200, data);
    emit buzzerEnabledChanged();
}

void CanController::toggleLed()
{
    m_ledOn = !m_ledOn;
    QByteArray data(1, m_ledOn ? 1 : 0);
    sendCanMessage(0x202, data);
    emit ledOnChanged();
}


void CanController::setAutoBeamEnabled(bool enabled)
{
    if (m_autoBeamEnabled != enabled) {
        m_autoBeamEnabled = enabled;
        emit autoBeamEnabledChanged();
        updateAutoHeadlight();  // Gửi lại theo trạng thái mới
    }
}

void CanController::updateAutoHeadlight()
{
    int headlightValue;

    if (!m_autoBeamEnabled) {
        headlightValue = 1; // LOW beam mặc định
    } else {
        if (m_speed < 10 && m_light > 50)
            headlightValue = 0;
        else if (m_speed >= 10 && m_light < 30)
            headlightValue = 2;
        else
            headlightValue = 1;
    }

    if (headlightValue != m_headlightOutput) {
        m_headlightOutput = headlightValue;
        QByteArray data(1, static_cast<char>(m_headlightOutput));
        sendCanMessage(0x201, data);
        emit headlightOutputChanged();
    }
}

