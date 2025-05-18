#ifndef CANCONTROLLER_H
#define CANCONTROLLER_H

#include "QObject"
#include "QtSerialBus/QCanBus"
#include "QtSerialBus/QCanBusDevice"
#include "QtSerialBus/QCanBusFrame"

class CanController : public QObject
{
    Q_OBJECT
    Q_PROPERTY(int gear READ gear NOTIFY gearChanged)
    Q_PROPERTY(int speed READ speed NOTIFY speedChanged)
    Q_PROPERTY(int light READ light NOTIFY lightChanged)
    Q_PROPERTY(float temperature READ temperature NOTIFY temperatureChanged)
    Q_PROPERTY(int humidity READ humidity NOTIFY humidityChanged)
    Q_PROPERTY(int distance READ distance NOTIFY distanceChanged)
    Q_PROPERTY(int buzzerMode READ buzzerMode NOTIFY buzzerModeChanged)
    Q_PROPERTY(bool leftTurn READ leftTurn NOTIFY leftTurnChanged)
    Q_PROPERTY(bool rightTurn READ rightTurn NOTIFY rightTurnChanged)
    Q_PROPERTY(int headlight READ headlight NOTIFY headlightChanged) // 0=Off, 1=Low, 2=High
    Q_PROPERTY(bool autoMode READ autoMode NOTIFY autoModeChanged)

private:
    QCanBusDevice *m_canDevice;
    int m_gear;
    int m_speed;
    int m_light;
    float m_temperature;
    int m_humidity;
    int m_distance;
    bool m_buzzerMode;
    bool m_leftTurn;
    bool m_rightTurn;
    int m_headlight;
    bool m_autoMode;

    void sendCanMessage(quint32 id, const QByteArray &data);
    void updateHeadlightInAutoMode();
    void updateBuzzerMode();

public:
    explicit CanController(QObject *parent = nullptr);
    ~CanController();

    int gear() const
    {
        return m_gear;
    }

    int speed() const
    {
        return m_speed;
    }

    int light() const
    {
        return m_light;
    }

    float temperature() const
    {
        return m_temperature;
    }

    int humidity() const
    {
        return m_humidity;
    }

    int distance() const
    {
        return m_distance;
    }

    int buzzerMode() const
    {
        return m_buzzerMode;
    }

    bool leftTurn() const
    {
        return m_leftTurn;
    }

    bool rightTurn() const
    {
        return m_rightTurn;
    }

    int headlight() const
    {
        return m_headlight;
    }

    bool autoMode() const
    {
        return m_autoMode;
    }

    bool initialize();

public slots:
    void toggleLeftTurn();
    void toggleRightTurn();
    void toggleLowBeam();
    void toggleHighBeam();
    void toggleAutoMode();

signals:
    void gearChanged();
    void speedChanged();
    void lightChanged();
    void temperatureChanged();
    void humidityChanged();
    void distanceChanged();
    void buzzerModeChanged();
    void leftTurnChanged();
    void rightTurnChanged();
    void headlightChanged();
    void autoModeChanged();

private slots:
    void receiveCanFrame();
    void handleCanError(QCanBusDevice::CanBusError error);
};

#endif // CANCONTROLLER_H
