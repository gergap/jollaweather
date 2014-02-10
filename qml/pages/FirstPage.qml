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

    // To enable PullDownMenu, place our content in a SilicaFlickable
    SilicaFlickable {
        anchors.fill: parent

        // PullDownMenu and PushUpMenu must be declared in SilicaFlickable, SilicaListView or SilicaGridView
        PullDownMenu {
            MenuItem {
                text: "Settings"
                onClicked: pageStack.push(Qt.resolvedUrl("SettingsPage.qml"));
            }
            MenuItem {
                text: "Refresh"
                onClicked: {
                    xmlModel.source = Wetter.weatherUrl("DE0007131");
                }
            }
        }

        // Tell SilicaFlickable the height of its content.
        contentHeight: column.height

        // Place our content in a Column.  The PageHeader is always placed at the top
        // of the page, followed by our content.
        Column {
            id: column

            width: page.width
            spacing: Theme.paddingLarge
            PageHeader {
                title: "Weather forecast"
            }
            Label {
                x: Theme.paddingLarge
                text: "Nuremberg"
                color: Theme.secondaryHighlightColor
                font.pixelSize: Theme.fontSizeExtraLarge
            }
            Label {
                id: one
                x: Theme.paddingLarge
            }
            Label {
                id: two
                x: Theme.paddingLarge
            }
            Label {
                id: three
                x: Theme.paddingLarge
            }
            Label {
                id: four
                x: Theme.paddingLarge
            }
            Label {
                id: five
                x: Theme.paddingLarge
            }
            Label {
                id: six
                x: Theme.paddingLarge
            }
            Label {
                id: seven
                x: Theme.paddingLarge
            }
            Image {
                id: imgWeather
                source: "/usr/share/JollaWeather/icons/d_0_L.png"
                smooth: true
            }
            Image {
                id: imgWind
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
    tn min temp celsius
    tx max temp celsius
    pc niederschlagswahrscheinlichkeit
    wd windrichtung in grad
    ws windgeschw in km/h
    */
    XmlListModel {
        id: xmlModel
        query: "/city/forecast/date"
        XmlRole { name: "w";     query: "w/string()" }
        XmlRole { name: "tn";    query: "tn/string()" }
        XmlRole { name: "tx";    query: "tx/string()" }
        XmlRole { name: "d";     query: "d/string()" }
        XmlRole { name: "dn";    query: "dn/string()" }
        XmlRole { name: "p";     query: "p/string()" }
        XmlRole { name: "pc";    query: "pc/string()" }
        XmlRole { name: "w_txt"; query: "w_txt/string()" }
        XmlRole { name: "wd_txt"; query: "wd_txt/string()" }
        onSourceChanged: {
            console.log("new source");
        }
        onStatusChanged: {
            if (status === XmlListModel.Ready) {
                if (xmlModel.count > 0) {
                    one.text   = "Min: "+xmlModel.get(0).tn+"°C";
                    two.text   = "Max: "+xmlModel.get(0).tx+"°C";
                    three.text = "Niederschlag: "+xmlModel.get(0).pc+"%";
                    four.text  = "Wind: "+xmlModel.get(0).ws+"km/h";
                    five.text  = xmlModel.get(0).p;
                    six.text   = xmlModel.get(0).w_txt;
                    seven.text   = xmlModel.get(0).wd_txt;

                    imgWeather.source = "/usr/share/JollaWeather/icons/d_"+xmlModel.get(0).w+"_L.png";
                    imgWind.source = "/usr/share/JollaWeather/icons/"+xmlModel.get(0).wd_txt+".png";
                }
            }
        }
    }
}


