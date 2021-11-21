import QtQuick 2.4
import Ubuntu.Components 1.3

ModalDialog {
    objectName: "confirmDialog"
    title: i18n.tr("JavaScript Confirmation")
    
    signal accept()
    signal reject()
    
    onAccept: hide()
    onReject: hide()

    Button {
        text: i18n.tr("OK")
        color: theme.palette.normal.positive
        objectName: "okButton"
        onClicked: accept()
    }

    Button {
        objectName: "cancelButton"
        text: i18n.tr("Cancel")
        onClicked: reject()
    }
}
