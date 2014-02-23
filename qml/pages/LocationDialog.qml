import QtQuick 2.0
import Sailfish.Silica 1.0
import QtQuick.XmlListModel 2.0
import "wettercom.js" as Wetter

Dialog {
    id: page
    property string location
    property string cityCode
    property string search
    canAccept: cityCode != ""

    SilicaListView {
        id: view
        anchors.fill: parent
        model: xmlModel
        header: DialogHeader {
            title: qsTr("Choose Location")
            //acceptText: "Accept"
        }
        delegate: BackgroundItem {
            id: background
            property bool selected: page.cityCode === model.city_code
            onClicked: {
                console.log("page.location="+model.name);
                page.location = model.name;
                page.cityCode = model.city_code;
            }
            Column {
                anchors.left: parent.left; anchors.leftMargin: Theme.paddingMedium
                anchors.top: parent.top; anchors.bottom: parent.bottom
                spacing: 0
                Row {
                    spacing: Theme.paddingSmall
                    Label {
                        text: plz
                        color: background.selected ? Theme.highlightColor
                                                    : Theme.primaryColor
                    }
                    Label {
                        text: name
                        color: background.selected ? Theme.highlightColor
                                                    : Theme.primaryColor
                    }
                }
                Label {
                    text: quarter
                    color: background.selected ? Theme.secondaryHighlightColor
                                                : Theme.secondaryColor
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

    XmlListModel {
        id: xmlModel
        query: "/search/result/item"
        XmlRole { name: "city_code"; query: "city_code/string()" }
        XmlRole { name: "plz"; query: "plz/string()" }
        XmlRole { name: "name"; query: "name/string()" }
        XmlRole { name: "quarter"; query: "quarter/string()" }
        onSourceChanged: {
            console.log("new source");
        }
    }

    onSearchChanged: {
        xmlModel.source = Wetter.mixedSearchUrl(search);
    }
}
