import QtQuick 2.9
import Ubuntu.Components 1.3
import Ubuntu.Components.Popups 1.3
import QtQuick.Layouts 1.3

Dialog {
            id: aboutDialog
            visible: false
            title: i18n.tr("About Sailbook "+root.appVersion)
            text: i18n.tr("This is a unofficial Facebook Client for Ubuntu Touch.")

            Image {
                anchors.horizontalCenter: parent     
                source: '../img/icon.png'
                fillMode: Image.PreserveAspectFit 
            }

            Text {
                wrapMode: Text.WordWrap
                text: i18n.tr('Copyright (c) 2018-2021 by <br> Rudi Timmermans  <br><br> E-Mail: <a href=\"mailto://rudi.timmer@gmx.com\">rudi.timmer@gmx.com</a>')
            }

            Text {
                wrapMode: Text.WordWrap
                text: i18n.tr('Special thanks to Alain Molteni for the icon and splash screen.')
            }

            Text {
                wrapMode: Text.WordWrap
                text: i18n.tr('Special thanks to testers, Tomas Öqvist, Sander Klootwijk, Joan CiberSheep, Mathijs Veen.')
            }

            Text {
                wrapMode: Text.WordWrap
                text: i18n.tr('<b>The Sailbook app is not affiliated with Facebook inc.</b>')
            }

            Button {
                Layout.alignment: Qt.AlignVCenter | Qt.AlignHCenter

                color: UbuntuColors.orange
                text: i18n.tr('Donate')
                onClicked: Qt.openUrlExternally('https://www.paypal.com/paypalme/RudiTimmermans')
            }

            Button {
                Layout.alignment: Qt.AlignVCenter | Qt.AlignHCenter

                color: UbuntuColors.green
                text: i18n.tr('OK')
                onClicked: PopupUtils.close(aboutDialog)
            }
        }
