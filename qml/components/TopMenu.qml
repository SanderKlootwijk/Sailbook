import QtQuick 2.4
import Ubuntu.Web 0.2
import Ubuntu.Components 1.3
import QtQuick.LocalStorage 2.0
import Ubuntu.Components.Popups 1.3
import Ubuntu.Content 1.1

Rectangle {
    id: topMenu
    z: 100000
    width: parent.width
    height: units.gu(6)
    color: "#3b5998"
    anchors {
        top: parent.top
    }

    Rectangle {
        width: parent.width
        height: units.gu(0.1)
        color: UbuntuColors.lightGrey
    }

    Row {
        width: parent.width
        height: parent.height-units.gu(0.2)
        anchors {
            centerIn: parent
        }

        Item {
            width: parent.width/6
            height: parent.height

            Icon {
                anchors.centerIn: parent
                width: units.gu(3.2)
                height: width
                source: "icons/icon-newsfeed.svg"
                color: "#FFFFFF"
            }

            MouseArea {
                anchors.fill: parent
                onClicked: {
                    webview.url = 'https://touch.facebook.com/home.php?sk='
                }
            }
        }

        Item {
            width: parent.width/6
            height: parent.height

            Icon {
                anchors.centerIn: parent
                width: units.gu(3.2)
                height: width
                source: "icons/icon-requests.svg"
                color: "#FFFFFF"
            }

            MouseArea {
                anchors.fill: parent
                onClicked: {
                    webview.url = 'https://touch.facebook.com/friends'
                }
            }
        }

        Item {
            width: parent.width/6
            height: parent.height

            Icon {
                anchors.centerIn: parent
                width: units.gu(3.2)
                height: width
                source: "icons/icon-messages.svg"
                color: "#FFFFFF"
            }

            MouseArea {
                anchors.fill: parent
                onClicked: {
                    webview.url = 'https://touch.facebook.com/messages'
                }
            }
        }

        Item {
            width: parent.width/6
            height: parent.height

            Icon {
                anchors.centerIn: parent
                width: units.gu(3.2)
                height: width
                source: "icons/icon-notifications.svg"
                color: "#FFFFFF"
            }

            MouseArea {
                anchors.fill: parent
                onClicked: {
                    webview.url = 'https://touch.facebook.com/notifications'
                }
            }
        }

        Item {
            width: parent.width/6
            height: parent.height

            Icon {
                anchors.centerIn: parent
                width: units.gu(3.2)
                height: width
                source: "icons/icon-search.svg"
                color: "#FFFFFF"
            }

            MouseArea {
                anchors.fill: parent
                onClicked: {
                    webview.url = 'https://touch.facebook.com/search/top?soft=search'
                }
            }
        }

        Item {
            width: parent.width/6
            height: parent.height

            Icon {
                anchors.centerIn: parent
                width: units.gu(3.2)
                height: width
                source: "icons/icon-settings.svg"
                color: "#FFFFFF"
            }

            MouseArea {
                anchors.fill: parent
                onClicked: {
                    webview.url = 'https://touch.facebook.com/settings/?entry_point=bookmark'
                }
            }
        }
     }
  }
