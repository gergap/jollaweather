import QtQuick 2.0
import Sailfish.Silica 1.0

Dialog {
    property string location
    property string search

    SilicaListView {
        id: view
        anchors.fill: parent
        model: xmlModel
        delegate: listItem
    }

    Component {
        id: listItem
        Item {
            x: 15
            width: ListView.view.width
            height: Theme.itemSizeSmall
            Row {
                Column {
                    spacing: Theme.paddingSmall
                    Label {
                        text: name
                        color: listItem.highlighted ? Theme.highlightColor
                                                    : Theme.primaryColor
                    }
                    Label {
                        text: plz
                        color: listItem.highlighted ? Theme.secondaryHighlightColor
                                                    : Theme.secondaryColor
                    }
                }
                Column {
                    spacing: Theme.paddingSmall
                    Label {
                        text: city_code
                        color: listItem.highlighted ? Theme.secondaryHighlightColor
                                                    : Theme.secondaryColor
                    }
                    Label {
                        text: quarter
                        color: listItem.highlighted ? Theme.secondaryHighlightColor
                                                    : Theme.secondaryColor
                    }
                }
            }
        }
    }

    ListModel {
        id: xmlModel
         ListElement {
             name: "Ariane"
             city_code: "abc"
             plz: "1234"
             quarter: "bla"
         }
         ListElement {
             name: "Bella"
             city_code: "abc"
             plz: "1234"
             quarter: "bla"
         }
         ListElement {
             name: "Corinna"
             city_code: "abc"
             plz: "1234"
             quarter: "bla"
         }
    }
/*
    XmlListModel {
        id: xmlModel
        source: "http://api.wetter.com/location/index/search/nürnberg/project/kde/cs/4fd63506846eb01b94f944cb706abbac"
        query: "/search/result/item"
        XmlRole { name: "city_code"; query: "city_code/string()" }
        XmlRole { name: "plz"; query: "plz/string()" }
        XmlRole { name: "name"; query: "name/string()" }
        XmlRole { name: "quarter"; query: "quarter/string()" }
    }

    onSearchChanged: {
        var project = "kde";
        var apiKey = "14747763f53dc0e27f42c945e96532ef";
        var input = project+apiKey+search;
        var md5 = Qt.md5(input);
        var url = "http://api.wetter.com/location/index/search/"+search+"/project/"+project+"/cs/"+md5;
        console.log(ur);
        xmlModel.source = url;
    }
*/
    /*
    onDone: {
        if (result === DialogResult.Accepted) {
            name = view.currentItem.city_code;
        }
    }
    */
}
