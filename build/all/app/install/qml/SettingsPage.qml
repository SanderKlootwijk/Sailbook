import QtQuick 2.9
import QtQuick.Controls 2.2
import QtQuick.Layouts 1.3
import Ubuntu.Components.Popups 1.3
import Ubuntu.Components 1.3 as UT
import "components/settingspage"

Dialog {
    id: settingsDialog

    title: i18n.tr("Sailbook settings")

            SpinRange{
                title: i18n.tr("Zoom factor") + ":"
                valueRatio: 100
                value: appSettings.facebookZoomFactor
                onValueModified: {
                appSettings.facebookZoomFactor = newValue
             }
         }

            Text {
                Layout.alignment: Qt.AlignVCenter | Qt.AlignHCenter  
                wrapMode: Text.WordWrap
                font.pointSize: 24
                font.bold: true
                text: i18n.tr('* This settings takes effect after restarting Sailbook.')
            }         

            Button {
                Layout.alignment: Qt.AlignVCenter | Qt.AlignHCenter
                text: i18n.tr('Close')
                onClicked: PopupUtils.close(settingsDialog)
            }
        }  