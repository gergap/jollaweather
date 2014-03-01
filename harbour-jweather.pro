# The name of your app.
# NOTICE: name defined in TARGET has a corresponding QML filename.
#         If name defined in TARGET is changed, following needs to be
#         done to match new name:
#         - corresponding QML filename must be changed
#         - desktop icon filename must be changed
#         - desktop filename must be changed
#         - icon definition filename in desktop file must be changed
TARGET = harbour-jweather

CONFIG += sailfishapp
#CONFIG+=qml_debug

HEADERS += \
    src/weathersettings.h

SOURCES += src/JollaWeather.cpp \
    src/weathersettings.cpp

qml.files = qml
qml.path = /usr/share/$${TARGET}

desktop.files = $${TARGET}.desktop
desktop.path = /usr/share/applications

# app icon
icon.files = $${TARGET}.png
icon.path = /usr/share/icons/hicolor/86x86/app

# weather icons
icons.files += wetter.com_icons/*.png
icons.files += wetter.com_icons_wind/*.png
icons.files += wettercom_92x18.png
icons.path = /usr/share/$${TARGET}/icons

OTHER_FILES += rpm/$${TARGET}.spec \
               rpm/$${TARGET}.yaml

TRANSLATIONS = jweather_de.ts

INSTALLS += qml desktop icon icons

