import QtQuick 2.9
import QtQuick.Layouts 1.3
import Ubuntu.Components 1.3
import Ubuntu.Components.Popups 1.3
import Qt.labs.settings 1.0
import Ubuntu.Components.ListItems 1.0 as ListItems

Dialog {
    id: settingsDialog

    title: i18n.tr("Sailbook settings")

            ListItems.Header {
                Layout.alignment: Qt.AlignVCenter | Qt.AlignHCenter  
                text: i18n.tr("Opening external link in")
            }

            OptionSelector {
                expanded: true
                model: [
                    i18n.tr("External browser"),
                    i18n.tr("Sailbook")
                    ]

                    Component.onCompleted: selectedIndex = root.settings.useInternalBrowser
                    onSelectedIndexChanged: root.settings.useInternalBrowser = selectedIndex
            }

            Text {
                Layout.alignment: Qt.AlignVCenter | Qt.AlignHCenter  
                wrapMode: Text.WordWrap
                font.pointSize: 20
                text: i18n.tr('<b>* When you choose Sailbook, you always need to use the Home key to return to your facebook feed.</b>')
            }

            Button {
                Layout.alignment: Qt.AlignVCenter | Qt.AlignHCenter
                color: UbuntuColors.green
                text: i18n.tr('Close')
                onClicked: PopupUtils.close(settingsDialog)
            }
        }  
