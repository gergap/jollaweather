#include "weathersettings.h"
#include <QSettings>
#include <QCoreApplication>
#include <QStandardPaths>
#include <QDir>


/** example from https://github.com/sailfish-sdk/xdg-helper/blob/master/README.qt5
 *
 * QString config_dir = QDir(QStandardPaths::writableLocation(QStandardPaths::ConfigLocation))
 *       .filePath(QCoreApplication::applicationName());
 * QString data_dir = QStandardPaths::writableLocation(QStandardPaths::DataLocation);
 * QString cache_dir = QStandardPaths::writableLocation(QStandardPaths::CacheLocation);
 */

WeatherSettings::WeatherSettings(QObject *parent) :
    QObject(parent)
{
    m_updateInterval = 60; // min
    m_tempUnit = "°C";
    m_pressureUnit = "mbar";
    m_windSpeedUnit = "km/h";
    m_visibilityUnit = "km";

    m_config_dir = QDir(QStandardPaths::writableLocation(QStandardPaths::ConfigLocation))
            .filePath(QCoreApplication::applicationName());
    load();
}

void WeatherSettings::load()
{
    QSettings s(m_config_dir, QSettings::IniFormat);

    m_updateInterval = s.value("updateInterval", m_updateInterval).toInt();
    m_location = s.value("location", m_location).toString();
    m_citycode = s.value("citycode", m_citycode).toString();
    m_tempUnit = s.value("tempUnit", m_tempUnit).toString();
    m_pressureUnit = s.value("pressureUnit", m_pressureUnit).toString();
    m_windSpeedUnit = s.value("windSpeedUnit", m_windSpeedUnit).toString();
    m_visibilityUnit = s.value("visibilityUnit", m_visibilityUnit).toString();

    emit updateIntervalChanged(m_updateInterval);
    emit locationChanged(m_location);
    emit cityCodeChanged(m_citycode);
    emit tempUnitChanged(m_tempUnit);
    emit pressureUnitChanged(m_pressureUnit);
    emit windSpeedUnitChanged(m_windSpeedUnit);
    emit visibilityUnitChanged(m_visibilityUnit);
}

void WeatherSettings::save()
{
    QSettings s(m_config_dir, QSettings::IniFormat);

    s.setValue("updateInterval", m_updateInterval);
    s.setValue("location", m_location);
    s.setValue("citycode", m_citycode);
    s.setValue("tempUnit", m_tempUnit);
    s.setValue("pressureUnit", m_pressureUnit);
    s.setValue("windSpeedUnit", m_windSpeedUnit);
    s.setValue("visibilityUnit", m_visibilityUnit);
}

void WeatherSettings::clear()
{
    QSettings s(m_config_dir, QSettings::IniFormat);
    s.clear();
}
