import QtQuick 2.9
import Morph.Web 0.1
import QtWebEngine 1.7
import Ubuntu.Components 1.3
import Ubuntu.Components.Popups 1.3
import Qt.labs.settings 1.0
import QtQuick.Window 2.2
import "actions" as Actions
import "components"
import "."

MainView {
    id: root
    objectName: "mainView"
    theme.name: "Ubuntu.Components.Themes.Ambiance"

    anchors {
        fill: parent
    }

    applicationName: "sailbook.sailbook"
    automaticOrientation: true
    anchorToKeyboard: true
    focus: true
    property bool blockOpenExternalUrls: false
    property bool runningLocalApplication: false
    property bool openExternalUrlInOverlay: true
    property bool popupBlockerEnabled: true
    
    property string appVersion : "v3.1"

    property string myUA: "Mozilla/5.0 (Linux; U; Android 4.1.1; es-; AVA-V470 Build/GRK39F) AppleWebKit/533.1 (KHTML, like Gecko) Version/4.0 Mobile Safari/533.1"

  Page {
    header: PageHeader {
        id: header
        title: i18n.tr("Sailbook Mobile "+root.appVersion)

        trailingActionBar.actions: [
            Action {
                iconName: 'go-next'
                text: i18n.tr('Forward')
                onTriggered: webview.goForward()
            },
   
            Action {
                iconName: 'go-previous'
                text: i18n.tr('Back')
                onTriggered: webview.goBack()
            },

           Action {
                iconName: 'reload'
                text: i18n.tr('Reload')
                onTriggered: webview.reload()
            },

            Action {
                iconName: 'settings'
                text: i18n.tr('Settings')
                onTriggered: PopupUtils.open(Qt.resolvedUrl('SettingsPage.qml'))
            },

            Action {
                iconName: 'info'
                text: i18n.tr('About')
                onTriggered: PopupUtils.open(Qt.resolvedUrl('AboutPage.qml'))
            }
         ]
    }


        WebEngineView {
            id: webview
            
            ScrollPositioner{z: 5; mode: "Down";}

            WebEngineProfile {
            id: webContext

            property alias userAgent: webContext.httpUserAgent
            property alias dataPath: webContext.persistentStoragePath

            dataPath: dataLocation

            userAgent: myUA

            persistentCookiesPolicy: WebEngineProfile.ForcePersistentCookies

            }

                anchors {
                       top: header.bottom
                       left: parent.left
                       right: parent.right
                       bottom: parent.bottom
            }

                userScripts: [
                    WebEngineScript {
                       injectionPoint: WebEngineScript.DocumentCreation
                       sourceUrl: Qt.resolvedUrl('js/fb-no-appbanner.js')
                       worldId: WebEngineScript.MainWorld
            },
                    WebEngineScript {
                       injectionPoint: WebEngineScript.DocumentCreation
                       sourceUrl: Qt.resolvedUrl('js/sailbook.js')
                       worldId: WebEngineScript.MainWorld
            }
         ]
         
                function goToTop(){
                    runJavaScript("window.scrollTo(0, 0); ")
            }

                function goToBottom(){
                    runJavaScript("window.scrollTo(0, " + webview.contentsSize.height +"); ")
            }         

                zoomFactor: String(webview.url).indexOf("https://www.facebook.com/") >= 0 ? appSettings.facebookZoomFactor : appSettings.zoomFactor
                url: "https://www.facebook.com/"

            onFileDialogRequested: function(request) {

            switch (request.mode)
        {
            case FileDialogRequest.FileModeOpen:
                request.accepted = true;
                var fileDialogSingle = PopupUtils.open(Qt.resolvedUrl("ContentPickerDialog.qml"));
                fileDialogSingle.allowMultipleFiles = false;
                fileDialogSingle.accept.connect(request.dialogAccept);
                fileDialogSingle.reject.connect(request.dialogReject);
                break;

            case FileDialogRequest.FileModeOpenMultiple:
                request.accepted = true;
                var fileDialogMultiple = PopupUtils.open(Qt.resolvedUrl("ContentPickerDialog.qml"));
                fileDialogMultiple.allowMultipleFiles = true;
                fileDialogMultiple.accept.connect(request.dialogAccept);
                fileDialogMultiple.reject.connect(request.dialogReject);
                break;

            case FilealogRequest.FileModeUploadFolder:
            case FileDialogRequest.FileModeSave:
                request.accepted = false;
                break;
            }

        }

        onNewViewRequested: function(request) {
                Qt.openUrlExternally(request.requestedUrl);
            }

        Loader {
            anchors {
                fill: popupWebview
            }
            active: webProcessMonitor.crashed || (webProcessMonitor.killed && !popupWebview.currentWebview.loading)
            sourceComponent: SadPage {
                webview: popupWebview
                objectName: "overlaySadPage"
            }
            WebProcessMonitor {
                id: webProcessMonitor
                webview: popupWebview
            }
            asynchronous: true
          }
       }
       
            SettingsComponent{
                id: appSettings
            }       

            Loader {
                id: contentHandlerLoader
                source: "ContentHandler.qml"
                asynchronous: true
            }
         
            Loader {
                id: downloadLoader
                source: "Downloader.qml"
                asynchronous: true
            }
            
            Loader {
                id: filePickerLoader
                source: "ContentPickerDialog.qml"
                asynchronous: true
            }

            Loader {
                id: downloadDialogLoader
                source: "ContentDownloadDialog.qml"
                asynchronous: true
            }
         }
      }