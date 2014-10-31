import QtQuick 1.1
import org.kde.plasma.core 0.1 as PlasmaCore
import org.kde.plasma.components 0.1 as PlasmaComponents
import org.kde.plasma.extras 0.1 as PlasmaExtras
import "plasmapackage:/code/xdate.js" as Jxd

Item {
  property QtObject statusModel
  PlasmaExtras.Title {
    id: hostnameTitle
    anchors.horizontalCenter: parent.horizontalCenter
    text: parent.statusModel.hostname
  }
  Column {
    anchors {
      top: hostnameTitle.bottom
      left: parent.left
    }
    Text {
      property string firstTitle: parent.parent.statusModel.upcoming.count >= 1 ? parent.parent.statusModel.upcoming.get(0).title : "..."
      text: "next recording: " + firstTitle
    }
    Text {
      property string lastTitle: parent.parent.statusModel.recorded.count >= 1 ? parent.parent.statusModel.recorded.get(0).title : "..."
      text: "last recording: " + lastTitle
    }
  }
}