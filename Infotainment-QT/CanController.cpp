#include "CanController.h"
#include <QDebug>

CanController::CanController(QObject *parent)
    : QObject(parent),
      m_canDevice(nullptr),
      m_gear(0),
      m_speed(0),
      m_light(0),
      m_temperature(25),
      m_humidity(80),
      m_distance(0),
      m_buzzerMode(0),
      m_leftTurn(false),
      m_rightTurn(false),
      m_headlight(0),
      m_autoMode(false)
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
    return true;
}

void CanController::receiveCanFrame()
{
    if (!m_canDevice)
    {
        return;
    }

    while (m_canDevice->framesAvailable())
    {
        QCanBusFrame frame = m_canDevice->readFrame();
        if (!frame.isValid())
        {
            continue;
        }

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
                    updateBuzzerMode();
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
                    if (m_autoMode)
                    {
                        updateHeadlightInAutoMode();
                    }
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
                    if (m_autoMode)
                    {
                        updateHeadlightInAutoMode();
                    }
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
                    updateBuzzerMode();
                }
            }
            break;

        case 0x106: // Buzzer state
            if (payload.size() >= 1)
            {
                int newBuzzerMode = payload[0] & 0x03;
                if (newBuzzerMode != m_buzzerMode)
                {
                    m_buzzerMode = newBuzzerMode;
                    emit buzzerModeChanged();
                }
            }
            break;

        case 0x201: // Lights state
            if (payload.size() >= 1)
            {
                bool newLeftTurn = payload[0] & 0x01;
                bool newRightTurn = (payload[0] >> 1) & 0x01;
                int newHeadlight = (payload[0] >> 2) & 0x03;
                if (newLeftTurn != m_leftTurn)
                {
                    m_leftTurn = newLeftTurn;
                    emit leftTurnChanged();
                }
                if (newRightTurn != m_rightTurn)
                {
                    m_rightTurn = newRightTurn;
                    emit rightTurnChanged();
                }
                if (newHeadlight != m_headlight)
                {
                    m_headlight = newHeadlight;
                    emit headlightChanged();
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
    {
        return;
    }

    QCanBusFrame frame(id, data);
    m_canDevice->writeFrame(frame);
    qDebug() << "Sent CAN ID:" << QString::number(id, 16) << "Payload:" << data.toHex();
}

void CanController::updateHeadlightInAutoMode()
{
    if (!m_autoMode)
        return;

    int newHeadlight;
    if (m_light > 50)
    {
        newHeadlight = 0; // Off
    }
    else if (m_speed <= 80)
    {
        newHeadlight = 1; // Low Beam
    }
    else
    {
        newHeadlight = 2; // High Beam
    }

    if (newHeadlight != m_headlight)
    {
        m_headlight = newHeadlight;
        QByteArray data(1, (m_leftTurn & 0x01) | ((m_rightTurn & 0x01) << 1) | ((m_headlight & 0x03) << 2));
        sendCanMessage(0x201, data);
        emit headlightChanged();
    }
}

void CanController::updateBuzzerMode()
{
    int newBuzzerMode;
    if (m_gear != 1)
    {                      // Not Reverse
        newBuzzerMode = 0; // Off
    }
    else
    { // Reverse
        if (m_distance > 50)
        {
            newBuzzerMode = 0; // Off
        }
        else if (m_distance > 30)
        {
            newBuzzerMode = 1; // Low
        }
        else if (m_distance > 10)
        {
            newBuzzerMode = 2; // Medium
        }
        else
        {
            newBuzzerMode = 3; // High
        }
    }

    if (newBuzzerMode != m_buzzerMode)
    {
        m_buzzerMode = newBuzzerMode;
        QByteArray data(1, m_buzzerMode & 0x03);
        sendCanMessage(0x200, data);
        emit buzzerModeChanged();
    }
}

void CanController::toggleLeftTurn()
{
    if (!m_leftTurn)
    {
        m_leftTurn = true;
        m_rightTurn = false;
    }
    else
    {
        m_leftTurn = false;
    }
    QByteArray data(1, (m_leftTurn & 0x01) | ((m_rightTurn & 0x01) << 1) | ((m_headlight & 0x03) << 2));
    sendCanMessage(0x201, data);
    emit leftTurnChanged();
    emit rightTurnChanged();
}

void CanController::toggleRightTurn()
{
    if (!m_rightTurn)
    {
        m_rightTurn = true;
        m_leftTurn = false;
    }
    else
    {
        m_rightTurn = false;
    }
    QByteArray data(1, (m_leftTurn & 0x01) | ((m_rightTurn & 0x01) << 1) | ((m_headlight & 0x03) << 2));
    sendCanMessage(0x201, data);
    emit rightTurnChanged();
    emit leftTurnChanged();
}

void CanController::toggleLowBeam()
{
    m_autoMode = false;
    m_headlight = (m_headlight == 1) ? 0 : 1;
    QByteArray data(1, (m_leftTurn & 0x01) | ((m_rightTurn & 0x01) << 1) | ((m_headlight & 0x03) << 2));
    sendCanMessage(0x201, data);
    emit headlightChanged();
    emit autoModeChanged();
}

void CanController::toggleHighBeam()
{
    m_autoMode = false;
    m_headlight = (m_headlight == 2) ? 0 : 2;
    QByteArray data(1, (m_leftTurn & 0x01) | ((m_rightTurn & 0x01) << 1) | ((m_headlight & 0x03) << 2));
    sendCanMessage(0x201, data);
    emit headlightChanged();
    emit autoModeChanged();
}

void CanController::toggleAutoMode()
{
    m_autoMode = !m_autoMode;
    if (m_autoMode)
    {
        updateHeadlightInAutoMode();
    }
    emit autoModeChanged();
}
