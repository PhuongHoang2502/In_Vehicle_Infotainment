#ifndef CANCONTROLLER_H
#define CANCONTROLLER_H

#include "QObject"
#include "QtSerialBus/QCanBus"
#include "QtSerialBus/QCanBusDevice"
#include "QtSerialBus/QCanBusFrame"

class CanController : public QObject {
    Q_OBJECT
    Q_PROPERTY(int gear READ gear NOTIFY gearChanged)
    Q_PROPERTY(int speed READ speed NOTIFY speedChanged)
    Q_PROPERTY(int light READ light NOTIFY lightChanged)
    Q_PROPERTY(float temperature READ temperature NOTIFY temperatureChanged)
    Q_PROPERTY(int humidity READ humidity NOTIFY humidityChanged)
    Q_PROPERTY(int distance READ distance NOTIFY distanceChanged)
    Q_PROPERTY(bool buzzerEnabled READ buzzerEnabled NOTIFY buzzerEnabledChanged)
    Q_PROPERTY(bool ledOn READ ledOn NOTIFY ledOnChanged)
    Q_PROPERTY(bool autoBeamEnabled READ autoBeamEnabled WRITE setAutoBeamEnabled NOTIFY autoBeamEnabledChanged)

private:
    QCanBusDevice *m_canDevice;
    int m_gear;
    int m_speed;
    int m_light;
    float m_temperature;
    int m_humidity;
    int m_distance;
    bool m_buzzerEnabled;
    bool m_ledOn;
    int m_headlightOutput = 0;  // 0 = OFF, 1 = LOW, 2 = HIGH
    bool m_autoBeamEnabled;

    void sendCanMessage(quint32 id, const QByteArray &data);
    void updateAutoHeadlight();


public:
    explicit CanController(QObject *parent = nullptr);
    ~CanController();

    int gear() const {
        return m_gear;
    }

    int speed() const {
        return m_speed;
    }

    int light() const {
        return m_light;
    }

    float temperature() const {
        return m_temperature;
    }

    int humidity() const {
        return m_humidity;
    }

    int distance() const {
        return m_distance;
    }

    bool buzzerEnabled() const {
        return m_buzzerEnabled;
    }

    bool ledOn() const {
        return m_ledOn;
    }
    bool autoBeamEnabled() const { return m_autoBeamEnabled; }
    bool initialize();
    void setAutoBeamEnabled(bool enabled);

public slots:
    void toggleBuzzer();
    void toggleLed();

signals:
    void gearChanged();
    void speedChanged();
    void lightChanged();
    void temperatureChanged();
    void humidityChanged();
    void distanceChanged();
    void buzzerEnabledChanged();
    void ledOnChanged();
    void autoBeamEnabledChanged();
    void headlightOutputChanged();


private slots:
    void receiveCanFrame();
    void handleCanError(QCanBusDevice::CanBusError error);
};

#endif // CANCONTROLLER_H
