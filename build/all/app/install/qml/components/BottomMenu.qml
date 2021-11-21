import QtQuick 2.9
import Morph.Web 0.1
import Ubuntu.Components 1.3
import QtQuick.LocalStorage 2.0
import Ubuntu.Components.Popups 1.3
import Ubuntu.Content 1.1

Rectangle {
    id: bottomMenu
    z: 100000
    width: parent.width
    height: units.gu(5)
    color: "#3b5998"
    anchors {
        bottom: parent.bottom
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
            width: parent.width/4
            height: parent.height

            Icon {
                anchors.centerIn: parent
                width: units.gu(3.2)
                height: width
                name: "home"
                color: "#000000"
            }

            MouseArea {
                anchors.fill: parent
                onClicked: {
                    webview.url = 'https://www.facebook.com'
                }
            }
        }

        Item {
            width: parent.width/4
            height: parent.height

            Icon {
                anchors.centerIn: parent
                width: units.gu(3.2)
                height: width
                name: "reload"
                color: "#000000"
            }

            MouseArea {
                anchors.fill: parent
                onClicked: {
                    webview.reload()
                }
            }
        }

        Item {
            width: parent.width/4
            height: parent.height

            Icon {
                anchors.centerIn: parent
                width: units.gu(3.2)
                height: width
                name: "settings"
                color: "#000000"
            }

            MouseArea {
                anchors.fill: parent
                onClicked: {
                    PopupUtils.open(Qt.resolvedUrl("../SettingsPage.qml")
                    )
                }
            }
        }

        Item {
            width: parent.width/4
            height: parent.height

            Icon {
                anchors.centerIn: parent
                width: units.gu(3.2)
                height: width
                name: "info"
                color: "#000000"
            }

            MouseArea {
                anchors.fill: parent
                onClicked: {
                    PopupUtils.open(Qt.resolvedUrl("../AboutPage.qml")
                    )
                }
            }
        }
    }
}
