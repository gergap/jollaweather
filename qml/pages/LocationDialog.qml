import QtQuick 2.0
import Sailfish.Silica 1.0
import QtQuick.XmlListModel 2.0

Dialog {
    property string location
    property string search

    Row {
        TextEdit {
            id: log
            text: qsTr("log:")
        }
        SilicaListView {
            id: view
            anchors.fill: parent
            model: xmlModel
            delegate: listItem
        }
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
/*
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
*/
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
        onStatusChanged: {
            log.text += status + "\n";
            if (status === XmlListModel.Error) {
                log.text += "-"+errorString()+"-\n";
            }
        }
    }

    onSearchChanged: {
        log.text +=">onSearchChanged\n";
        var project = "kde";
        var apiKey = "14747763f53dc0e27f42c945e96532ef";
        var input = project+apiKey+search;
        log.text +="input="+input+"\n";
        var md5 = Qt.md5(input);
        log.text +="md5="+md5+"\n";
        var url = "http://api.wetter.com/location/index/search/"+search+"/project/"+project+"/cs/"+md5;
        log.text +="url="+url+"\n";
        xmlModel.source = url;
        log.text +="<onSearchChanged\n";
    }

    onDone: {
        if (result === DialogResult.Accepted) {
            name = view.currentItem.city_code;
        }
    }
}
