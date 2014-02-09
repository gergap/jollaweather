import QtQuick 2.0
import Sailfish.Silica 1.0
import QtQuick.XmlListModel 2.0

Dialog {
    id: page
    property string location
    property string city_code
    property string search
    canAccept: city_code != ""

    SilicaListView {
        id: view
        anchors.fill: parent
        model: xmlModel
        header: DialogHeader {
            title: "Choose Location"
            acceptText: "Accept"
        }
        delegate: BackgroundItem {
            id: background
            property bool selected: page.city_code === model.city_code
            onClicked: {
                page.location = model.name;
                page.city_code = model.city_code;
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
        //source: "http://api.wetter.com/location/index/search/nürnberg/project/kde/cs/4fd63506846eb01b94f944cb706abbac"
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
        var project = "kde";
        var apiKey = "14747763f53dc0e27f42c945e96532ef";
        var input = project+apiKey+search;
        var md5 = Qt.md5(input);
        var url = "http://api.wetter.com/location/index/search/"+search+"/project/"+project+"/cs/"+md5;
        xmlModel.source = url;
    }

    onDone: {
        if (result === DialogResult.Accepted) {
            name = view.currentItem.city_code;
        }
    }
}
