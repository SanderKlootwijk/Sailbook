import QtQuick 2.9
import QtQuick.Controls 2.2
import QtQuick.Layouts 1.3
import Ubuntu.Components.Popups 1.3
import Ubuntu.Components 1.3 as UT
import "components/settingspage"

Dialog {
    id: settingsDialog

    title: i18n.tr("Sailbook settings")

         Component.onCompleted: {
            selector.selectedIndex = appSettings.selectedIndex
        }

        UT.OptionSelector {
            id: selector
            expanded: true
            containerHeight: parent.height * 0.75
            anchors.horizontalCenter: parent.horizontalCenter
            model: [i18n.tr("Small"),i18n.tr("Normal"),i18n.tr("Large")]
            onSelectedIndexChanged: {
                switch(selector.selectedIndex) {
                case 0: {
                    webview.zoomFactor = 1.25
                    appSettings.facebookZoomFactor = 1.25
                    appSettings.selectedIndex = 0
                    webview.zoomFactor = 1.25
                    break;
                }
                case 1: {
                    webview.zoomFactor = 1.75
                    appSettings.facebookZoomFactor = 1.75
                    appSettings.selectedIndex = 1
                    webview.zoomFactor = 1.75
                    break;
                }
                case 2: {
                    webview.zoomFactor = 2.75
                    appSettings.facebookZoomFactor = 2.75
                    appSettings.selectedIndex = 2
                    webview.zoomFactor = 2.75
                    break;
                }
                }
            }
        }        

            Button {
                Layout.alignment: Qt.AlignVCenter | Qt.AlignHCenter
                text: i18n.tr('Close')
                onClicked: PopupUtils.close(settingsDialog)
            }
        }  
