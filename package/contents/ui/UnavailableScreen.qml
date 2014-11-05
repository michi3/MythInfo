import QtQuick 1.1
import org.kde.plasma.components 0.1 as PlasmaComponents
import org.kde.plasma.extras 0.1 as PlasmaExtras

Item {
  property QtObject unavailableModel
  PlasmaComponents.BusyIndicator {
    id: busy
    running: true
    anchors {
      horizontalCenter: parent.horizontalCenter
      verticalCenter: parent.verticalCenter
    }
  }
  PlasmaExtras.Heading {
    id: head
    text: "Myth TV Backend not found!"
    level: 3
    anchors {
      horizontalCenter: parent.horizontalCenter
      top: busy.bottom
    }
  }
  Text {
    text: "Your backend is offline or you missconfigured this. Don't forget to enable the Service API in the backend"
    anchors {
      horizontalCenter: parent.horizontalCenter
      top: head.bottom
    }
  }
}