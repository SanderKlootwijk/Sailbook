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

    focus: true

    anchors {
        fill: parent
    }

    applicationName: "sailbook.sailbook"
    anchorToKeyboard: true
    automaticOrientation: true
    property bool blockOpenExternalUrls: false
    property bool runningLocalApplication: false
    property bool openExternalUrlInOverlay: false
    property bool popupBlockerEnabled: true
    property bool fullscreen: false

    property string appVersion : "v3.2"
    property var myScreenPixelDensity: Screen.pixelDensity

    Page {
        id: page
        header: Rectangle {
          color: "#000000"
          width: parent.width
          height: units.dp(.5)
          z: 1
        }

        anchors {
          fill: parent
          bottom: parent.bottom
        }

        WebEngineView {
            id: webview

            property var currentWebview: webview

            settings.fullScreenSupportEnabled: false

            ScrollPositioner{z: 5; mode: "Down";}

            WebEngineProfile {
                id: webContext

                property alias userAgent: webContext.httpUserAgent
                property alias dataPath: webContext.persistentStoragePath
                property string myMobileUA: "Mozilla/5.0 (Linux; U; Android 4.1.1; es-; AVA-V470 Build/GRK39F) AppleWebKit/533.1 (KHTML, like Gecko) Version/4.0 Mobile Safari/533.1"

                dataPath: dataLocation

                userAgent: myUA

                persistentCookiesPolicy: WebEngineProfile.ForcePersistentCookies
            }

            anchors {
                fill: parent
                right: parent.right
                bottom: parent.bottom
                margins: units.gu(0)
                bottomMargin: units.gu(4)
            }
            
                zoomFactor: String(webview.url).indexOf("https://www.facebook.com/") >= 0 ? appSettings.facebookZoomFactor : appSettings.zoomFactor
                url: "https://www.facebook.com/"

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

            onJavaScriptDialogRequested: function(request) {

                switch (request.type){
                    case JavaScriptDialogRequest.DialogTypeAlert:
                    request.accepted = true;
                    var alertDialog = PopupUtils.open(Qt.resolvedUrl("AlertDialog.qml"));
                    alertDialog.message = request.message;
                    alertDialog.accept.connect(request.dialogAccept);
                    break;

                    case JavaScriptDialogRequest.DialogTypeConfirm:
                    request.accepted = true;
                    var confirmDialog = PopupUtils.open(Qt.resolvedUrl("ConfirmDialog.qml"));
                    confirmDialog.message = request.message;
                    confirmDialog.accept.connect(request.dialogAccept);
                    confirmDialog.reject.connect(request.dialogReject);
                    break;

                    case JavaScriptDialogRequest.DialogTypePrompt:
                    request.accepted = true;
                    var promptDialog = PopupUtils.open(Qt.resolvedUrl("PromptDialog.qml"));
                    promptDialog.message = request.message;
                    promptDialog.defaultValue = request.defaultText;
                    promptDialog.accept.connect(request.dialogAccept);
                    promptDialog.reject.connect(request.dialogReject);
                    break;

                    case 3:
                    request.accepted = true;
                    var beforeUnloadDialog = PopupUtils.open(Qt.resolvedUrl("BeforeUnloadDialog.qml"));
                    beforeUnloadDialog.message = request.message;
                    beforeUnloadDialog.accept.connect(request.dialogAccept);
                    beforeUnloadDialog.reject.connect(request.dialogReject);
                    break;
                }

            }

            onFileDialogRequested: function(request) {
                switch (request.mode) {
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

            onAuthenticationDialogRequested: function(request) {
                switch (request.type)
                {
                //case WebEngineAuthenticationDialogRequest.AuthenticationTypeHTTP:
                    case 0:
                        request.accepted = true;
                        var authDialog = PopupUtils.open(Qt.resolvedUrl("HttpAuthenticationDialog.qml"), webview.currentWebview);
                        authDialog.host = UrlUtils.extractHost(request.url);
                        authDialog.realm = request.realm;
                        authDialog.accept.connect(request.dialogAccept);
                        authDialog.reject.connect(request.dialogReject);
                        break;

                //case WebEngineAuthenticationDialogRequest.AuthenticationTypeProxy:
                    case 1:
                        request.accepted = false;
                        break;
                }
            }

            onNewViewRequested: function(request) {
              if (root.settings.useInternalBrowser) {
                request.openIn(webview); 
            } else {  
                Qt.openUrlExternally(request.requestedUrl);
               }
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

        BottomMenu {
            id: bottomMenu
            width: parent.width
        }
      }
   }
