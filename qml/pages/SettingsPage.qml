/*
  Copyright (C) 2013 Jolla Ltd.
  Contact: Thomas Perl <thomas.perl@jollamobile.com>
  All rights reserved.

  You may use this file under the terms of BSD license as follows:

  Redistribution and use in source and binary forms, with or without
  modification, are permitted provided that the following conditions are met:
    * Redistributions of source code must retain the above copyright
      notice, this list of conditions and the following disclaimer.
    * Redistributions in binary form must reproduce the above copyright
      notice, this list of conditions and the following disclaimer in the
      documentation and/or other materials provided with the distribution.
    * Neither the name of the Jolla Ltd nor the
      names of its contributors may be used to endorse or promote products
      derived from this software without specific prior written permission.

  THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS" AND
  ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED
  WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE
  DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT HOLDERS OR CONTRIBUTORS BE LIABLE FOR
  ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES
  (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES;
  LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND
  ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
  (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS
  SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
*/

import QtQuick 2.0
import Sailfish.Silica 1.0


Dialog {
    id: page
    property string cityCode: weatherSettings.cityCode
    property string location: weatherSettings.location
    property int interval: weatherSettings.updateInverval

    onIntervalChanged: {
        switch (weatherSettings.updateInverval) {
        case 1:
            cmbUpdateInterval.currentIndex = 0; break;
        case 5:
            cmbUpdateInterval.currentIndex = 1; break;
        case 10:
            cmbUpdateInterval.currentIndex = 2; break;
        case 15:
            cmbUpdateInterval.currentIndex = 3; break;
        case 30:
            cmbUpdateInterval.currentIndex = 4; break;
        case 60:
            cmbUpdateInterval.currentIndex = 5; break;
        case 6*60:
            cmbUpdateInterval.currentIndex = 6; break;
        case 12*60:
            cmbUpdateInterval.currentIndex = 7; break;
        case 24*60:
            cmbUpdateInterval.currentIndex = 8; break;
        }
    }

    SilicaFlickable {
        anchors.fill: parent

        // Tell SilicaFlickable the height of its content.
        contentHeight: column.height

        // Place our content in a Column.  The PageHeader is always placed at the top
        // of the page, followed by our content.
        Column {
            id: column

            width: page.width
            spacing: Theme.paddingLarge
            DialogHeader {
                title: qsTr("Settings")
                acceptText: qsTr("Accept")
            }
            Label {
                x: Theme.paddingLarge
                text: qsTr("Weather Station")
                color: Theme.secondaryHighlightColor
                font.pixelSize: Theme.fontSizeExtraLarge
            }
            TextField {
                id: location
                width: page.width
                placeholderText: qsTr("Enter Town / Location")
                label: qsTr("Location")
            }
            Button {
                text: qsTr("Search")
                onClicked: {
                   var dialog = pageStack.push(Qt.resolvedUrl("LocationDialog.qml"), {"search": location.text});
                   dialog.search = location.text;
                   dialog.accepted.connect(function() {
                       location.text = dialog.location;
                       page.cityCode = dialog.cityCode;
                       page.location = dialog.location;
                   })
               }

               anchors {
                   right: parent.right
                   margins: Theme.paddingLarge
               }
            }
            ComboBox {
                id: cmbUpdateInterval
                width: page.width
                label: qsTr("Update interval")
                menu: ContextMenu {
                    id: menu
                    MenuItem { text: "1 min" }
                    MenuItem { text: "5 min" }
                    MenuItem { text: "10 min" }
                    MenuItem { text: "15 min" }
                    MenuItem { text: "30 min" }
                    MenuItem { text: "60 min" }
                    MenuItem { text: "6 h" }
                    MenuItem { text: "12 h" }
                    MenuItem { text: "24 h" }
                }
            }
            Label {
                x: Theme.paddingLarge
                text: qsTr("Units")
                color: Theme.secondaryHighlightColor
                font.pixelSize: Theme.fontSizeExtraLarge
            }
            ComboBox {
                id: cmbTemperatureUnit
                width: page.width
                label: qsTr("Temperature")

                menu: ContextMenu {
                    MenuItem { text: "Celsius °C" }
                    MenuItem { text: "Fahrenheit °F" }
                    MenuItem { text: "Kelvin K" }
                }

            }
            ComboBox {
                id: cmbPressureUnit
                width: page.width
                label: qsTr("Pressure")

                menu: ContextMenu {
                    MenuItem { text: "Hectopascales hPa" }
                    MenuItem { text: "Kilopascals kPa" }
                    MenuItem { text: "Millibars mbar" }
                    MenuItem { text: "Inches for Mecury inHg" }
                }

            }
            ComboBox {
                id: cmbWindSpeedUnit
                width: page.width
                label: qsTr("Wind speed")

                menu: ContextMenu {
                    MenuItem { text: "Kilometers per Hour km/h" }
                    MenuItem { text: "Meters per second m/s" }
                    MenuItem { text: "Miles per Hour mph" }
                    MenuItem { text: "Knotes kt" }
                    MenuItem { text: "Beaufort scale bft" }
                }
            }
            ComboBox {
                id: cmbVisibilityUnit
                width: page.width
                label: qsTr("Visibility")

                menu: ContextMenu {
                    MenuItem { text: "Kilometers" }
                    MenuItem { text: "Miles" }
                }
            }
        }
    }

    onDone: {
        if (result === DialogResult.Accepted) {
            console.debug("Saving settings: "+page.location);
            switch (cmbUpdateInterval.value) {
            case "1 min":
                weatherSettings.updateInverval = 1;
                break;
            case "5 min":
                weatherSettings.updateInverval = 5;
                break;
            case "10 min":
                weatherSettings.updateInverval = 10;
                break;
            case "15 min":
                weatherSettings.updateInverval = 15;
                break;
            case "30 min":
                weatherSettings.updateInverval = 30;
                break;
            case "60 min":
                weatherSettings.updateInverval = 60;
                break;
            case "6 h":
                weatherSettings.updateInverval = 6*60;
                break;
            case "12 h":
                weatherSettings.updateInverval = 12*60;
                break;
            case "24 h":
                weatherSettings.updateInverval = 24*60;
                break;
            }
            weatherSettings.cityCode = page.cityCode;
            weatherSettings.location = page.location;
            weatherSettings.tempUnit = cmbTemperatureUnit.value;
            weatherSettings.pressureUnit = cmbPressureUnit.value;
            weatherSettings.windSpeedUnit = cmbWindSpeedUnit.value;
            weatherSettings.visibilityUnit = cmbVisibilityUnit.value;
            weatherSettings.save();
        }
    }

}





