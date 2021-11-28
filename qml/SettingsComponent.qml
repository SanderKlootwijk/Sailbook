import QtQuick 2.9
import Qt.labs.settings 1.0

Item{
    id: settingsComponent
    
    //Settings page
    property alias zoomFactor: settings.zoomFactor
    property alias facebookZoomFactor: settings.facebookZoomFactor
    property alias selectedIndex: settings.selectedIndex
    
    //User data
    property alias firstRun: settings.firstRun
    
    Settings {
        id: settings
    
        //Settings page
        property real zoomFactor: 1.75
        property real facebookZoomFactor: 1.75
        property real selectedIndex: 1
        
        //User data
        property bool firstRun: true
    }
}
