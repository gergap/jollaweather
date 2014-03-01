import QtQuick 2.0
import Sailfish.Silica 1.0
import "wettercom.js" as Wetter

Component {
    id: delegate
    Rectangle {
        height: Theme.itemSizeExtraLarge*2
        width: ListView.view.width
        radius: 5
        gradient: Gradient {
            GradientStop { position: 0.0; color: "#80ffffff" }
            GradientStop { position: 1.0; color: "#10000000" }
        }

        Image {
            id: imgWeather
            x: Theme.paddingMedium
            anchors.verticalCenter: parent.verticalCenter
            source: Wetter.icondir+"d_"+w+"_L.png";
        }

        Image {
            id: imgWind
            anchors.verticalCenter: txtWind.verticalCenter
            anchors.right: txtWind.left
            anchors.rightMargin: Theme.paddingMedium
            source: Wetter.icondir+wd_txt+".png";
        }

        Text {
            id: txtDate
            x: Theme.paddingMedium
            y: Theme.paddingMedium
            color: "#ffffff"
            text: Qt.formatDate(date, "dddd") // longDayName
            style: Text.Raised
            font.pixelSize: Theme.fontSizeMedium
        }

        Text {
            id: txtTempMin
            anchors.bottom: txtTempMax.top
            anchors.bottomMargin: Theme.paddingMedium
            anchors.right: parent.right
            anchors.rightMargin: Theme.paddingLarge
            color: "#ffffff"
            text: qsTr("Min: ") + tn + "°C"
            style: Text.Raised
            font.pixelSize: Theme.fontSizeLarge
        }

        Text {
            id: txtTempMax
            anchors.verticalCenter: parent.verticalCenter
            anchors.right: parent.right
            anchors.rightMargin: Theme.paddingLarge
            color: "#ffffff"
            text: qsTr("Max: ") + tx + "°C"
            style: Text.Raised
            font.pixelSize: Theme.fontSizeExtraLarge
        }

        Text {
            id: txtWind
            anchors.top: txtTempMax.bottom
            anchors.right: parent.right
            anchors.rightMargin: Theme.paddingLarge
            color: "#ffffff"
            text: wd_txt
            style: Text.Raised
            font.pixelSize: Theme.fontSizeMedium
        }

        Text {
            id: txtWindSpeed
            anchors.top: txtWind.bottom
            anchors.right: parent.right
            anchors.rightMargin: Theme.paddingLarge
            color: "#ffffff"
            text: ws + "km/h"
            style: Text.Raised
            font.pixelSize: Theme.fontSizeMedium
        }

        Text {
            id: txtWeatherCondition
            anchors.horizontalCenter: imgWeather.horizontalCenter
            anchors.bottom: parent.bottom
            anchors.bottomMargin: Theme.paddingMedium
            color: "#ffffff"
            text: w_txt
            font.pixelSize: Theme.fontSizeSmall
            style: Text.Raised
        }
        states: [
            State {
                name: "compact"
            }
        ]
    }
}
