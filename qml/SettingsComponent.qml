import QtQuick 2.9
import Qt.labs.settings 1.0

Item{
    id: settingsComponent
    
    //Settings page
    property alias zoomFactor: settings.zoomFactor
    property alias facebookZoomFactor: settings.facebookZoomFactor
    
    //User data
    property alias firstRun: settings.firstRun
    
    Settings {
        id: settings
    
        //Settings page
        property real zoomFactor: 2.00
        property real facebookZoomFactor: 2.00
        
        //User data
        property bool firstRun: true
    }
}
