import QtQuick 2.4
import Ubuntu.Components 1.3

ModalDialog {
    objectName: "alertDialog"
    title: i18n.tr("JavaScript Alert")

    signal accept()
    
    onAccept: hide()

    Button {
        text: i18n.tr("OK")
        color: theme.palette.normal.positive
        objectName: "okButton"
        onClicked: accept()
    }
}
