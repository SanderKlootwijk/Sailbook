import QtQuick 2.4
import Ubuntu.Components 1.3
import Ubuntu.Components.Popups 1.3 as Popups

Popups.Dialog {
    id: dialog
    title: i18n.tr("Authentication required.")
    // TRANSLATORS: %1 refers to the URL of the current website and %2 is a string that the website sends with more information about the authentication challenge (technically called "realm")
    text: request ? i18n.tr("The website at %1 requires authentication. The website says \"%2\"").arg(request.host).arg(request.realm) : ""

    property QtObject request: null

    Connections {
        target: request
        onCancelled: PopupUtils.close(dialog)
    }

    TextField {
        id: usernameInput
        objectName: "username"
        placeholderText: i18n.tr("Username")
        onAccepted: {
            request.allow(usernameInput.text, passwordInput.text)
            PopupUtils.close(dialog)
        }
    }

    TextField {
        id: passwordInput
        objectName: "password"
        placeholderText: i18n.tr("Password")
        echoMode: TextInput.Password
        onAccepted: {
            request.allow(usernameInput.text, passwordInput.text)
            PopupUtils.close(dialog)
        }
    }

    Button {
        objectName: "allow"
        text: i18n.tr("OK")
        color: theme.palette.normal.positive
        onClicked: {
            request.allow(usernameInput.text, passwordInput.text)
            PopupUtils.close(dialog)
        }
    }

    Button {
        objectName: "deny"
        text: i18n.tr("Cancel")
        onClicked: {
            request.deny()
            PopupUtils.close(dialog)
        }
    }
}
