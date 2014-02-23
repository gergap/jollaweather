# The name of your app.
# NOTICE: name defined in TARGET has a corresponding QML filename.
#         If name defined in TARGET is changed, following needs to be
#         done to match new name:
#         - corresponding QML filename must be changed
#         - desktop icon filename must be changed
#         - desktop filename must be changed
#         - icon definition filename in desktop file must be changed
TARGET = JWeather

CONFIG += sailfishapp
#CONFIG+=qml_debug

SOURCES += src/JollaWeather.cpp \
    src/weathersettings.cpp

OTHER_FILES += qml/JollaWeather.qml \
    qml/cover/CoverPage.qml \
    qml/pages/FirstPage.qml \
    rpm/JWeather.spec \
    rpm/JWeather.yaml \
    JWeather.desktop \
    qml/pages/SettingsPage.qml \
    qml/pages/LocationDialog.qml \
    qml/pages/wettercom.js \
    qml/pages/WeatherDelegate.qml \
    qml/pages/WeatherPage.qml

icons.files = wetter.com_icons/*.png
icons.files += wetter.com_icons_wind/*.png
icons.files += wettercom_92x18.png
icons.path = $$DEPLOYMENT_PATH/usr/share/JWeather/icons
INSTALLS += icons

TRANSLATIONS = jweather_de.ts

#RESOURCES += jollaweather.qrc

HEADERS += \
    src/weathersettings.h

