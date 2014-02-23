#ifndef WEATHERSETTINGS_H
#define WEATHERSETTINGS_H

#include <QObject>

class WeatherSettings : public QObject
{
    Q_OBJECT
    Q_PROPERTY(int updateInverval MEMBER m_updateInterval NOTIFY updateIntervalChanged)
    Q_PROPERTY(QString location MEMBER m_location NOTIFY locationChanged)
    Q_PROPERTY(QString cityCode MEMBER m_citycode NOTIFY cityCodeChanged)
    Q_PROPERTY(QString tempUnit MEMBER m_tempUnit NOTIFY tempUnitChanged)
    Q_PROPERTY(QString pressureUnit MEMBER m_pressureUnit NOTIFY pressureUnitChanged)
    Q_PROPERTY(QString windSpeedUnit MEMBER m_windSpeedUnit NOTIFY windSpeedUnitChanged)
    Q_PROPERTY(QString visibilityUnit MEMBER m_visibilityUnit NOTIFY visibilityUnitChanged)
public:
    explicit WeatherSettings(QObject *parent = 0);

signals:
    void updateIntervalChanged(int val);
    void locationChanged(const QString &val);
    void cityCodeChanged(const QString &val);
    void tempUnitChanged(const QString &val);
    void pressureUnitChanged(const QString &val);
    void windSpeedUnitChanged(const QString &val);
    void visibilityUnitChanged(const QString &val);

public slots:
    void load();
    void save();

private:
    int m_updateInterval;
    QString m_location;
    QString m_citycode;
    QString m_tempUnit;
    QString m_pressureUnit;
    QString m_windSpeedUnit;
    QString m_visibilityUnit;
};

#endif // WEATHERSETTINGS_H
