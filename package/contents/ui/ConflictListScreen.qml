import QtQuick 1.1
import org.kde.plasma.components 0.1 as PlasmaComponents
import org.kde.plasma.extras 0.1 as PlasmaExtras

PlasmaExtras.ScrollArea {
  property QtObject conflictListModel
  ListView {
    id: conflictListView
    model: parent.conflictListModel
    delegate: RecordingItem { }
    // highlight item
    currentIndex: -1
    // expanded item
    property int i: -1
    clip: true
    snapMode: ListView.SnapToItem
    highlight: PlasmaComponents.Highlight {
      hover: true
    }
  }
} 
