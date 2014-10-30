import QtQuick 1.1
import org.kde.plasma.components 0.1 as PlasmaComponents

Item {
  PlasmaComponents.BusyIndicator {
    running: true
    anchors {
      horizontalCenter: parent.horizontalCenter
      verticalCenter: parent.verticalCenter
    }
  }
}