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

            Button {
                color: UbuntuColors.green
                text: i18n.tr('Close')
                onClicked: PopupUtils.close(settingsDialog)
            }
        }  
