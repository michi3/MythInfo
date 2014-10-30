import QtQuick 1.1
import org.kde.plasma.core 0.1 as PlasmaCore
import org.kde.plasma.components 0.1 as PlasmaComponents
import org.kde.plasma.extras 0.1 as PlasmaExtras
import "plasmapackage:/code/xdate.js" as Jxd

Item {
  property QtObject statusModel
  PlasmaExtras.Title {
    id: title
    anchors.horizontalCenter: parent.horizontalCenter
    text: parent.statusModel.hostname
  }
  Column {
    anchors {
      top: title.bottom
      left: parent.left
    }
    Text {
      text: "next recordings:"
    }
    Text {
      text: "next recordings:"
    }
  }
}