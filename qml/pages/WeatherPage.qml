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
import QtQuick.XmlListModel 2.0
import "wettercom.js" as Wetter

Page {
    id: page
    property string weatherCondition: "0"
    property string weatherConditionText: ""
    property string temperature: "0"

    SilicaListView {
        id: view
        anchors.fill: parent
        model: xmlModel
        header: PageHeader {
            title: weatherSettings.location;
        }
        delegate: WeatherDelegate {}
        spacing: 5

        Component.onCompleted: {
            console.log(Wetter.weatherUrl(weatherSettings.cityCode));
            xmlModel.source = Wetter.weatherUrl(weatherSettings.cityCode);
        }

        // PullDownMenu and PushUpMenu must be declared in SilicaFlickable, SilicaListView or SilicaGridView
        PullDownMenu {
            MenuItem {
                text: "Settings"
                onClicked: pageStack.push(Qt.resolvedUrl("SettingsPage.qml"));
            }
            MenuItem {
                text: "Refresh"
                onClicked: {
                    console.log(Wetter.weatherUrl(weatherSettings.cityCode));
                    xmlModel.source = Wetter.weatherUrl(weatherSettings.cityCode);
                }
            }
        }

        BusyIndicator {
            running: opacity != 0
            anchors.centerIn: parent
            opacity: xmlModel.status === XmlListModel.Loading ? 1 : 0

            Behavior on opacity {
                FadeAnimation {}
            }
        }
    }

    /*
    d Lokale Zeit (Unix timestamp)
    p Gültigkeitszeitraum der Prognose
    w Code für den Wetterzustand
    w_txt Wetterzustand als Text
    tn min temp celsius
    tx max temp celsius
    pc niederschlagswahrscheinlichkeit
    wd windrichtung in grad
    wd_txt windricht als text ("SW", etc.)
    ws windgeschw in km/h
    */
    XmlListModel {
        id: xmlModel
        query: "/city/forecast/date"
        XmlRole { name: "date";  query: "@value/string()" }
        XmlRole { name: "d";     query: "d/string()" }
        XmlRole { name: "p";     query: "p/string()" }
        XmlRole { name: "w";     query: "w/string()" }
        XmlRole { name: "w_txt"; query: "w_txt/string()" }
        XmlRole { name: "tn";    query: "tn/string()" }
        XmlRole { name: "tx";    query: "tx/string()" }
        XmlRole { name: "pc";    query: "pc/string()" }
        XmlRole { name: "wd";    query: "wd/string()" }
        XmlRole { name: "wd_txt"; query: "wd_txt/string()" }
        XmlRole { name: "ws";    query: "ws/string()" }
        onSourceChanged: {
            console.log("new source");
        }
        onStatusChanged: {
            if (status === XmlListModel.Ready) {
                if (xmlModel.count > 0) {
                    console.log("weatherCondition: "+xmlModel.get(0).w);
                    page.weatherCondition = xmlModel.get(0).w;
                    page.weatherConditionText = xmlModel.get(0).w_txt;
                    page.temperature = xmlModel.get(0).tx;
                }
            }
        }
    }

    Image {
        anchors.bottom: parent.bottom
        anchors.bottomMargin: Theme.paddingMedium
        anchors.right: parent.right
        anchors.rightMargin: Theme.paddingMedium
        source: "/usr/share/JWeather/icons/wettercom_92x18.png"

        MouseArea {
            anchors.fill: parent
            onClicked: {
                Qt.openUrlExternally("http://www.wetter.com");
            }
        }
    }
}


