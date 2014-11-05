import QtQuick 1.1
import "plasmapackage:/code/MythServices.js" as Myth

Item {
  property alias upcoming: upcomingListModel
  property alias recorded: recordedListModel
  property alias timer: timer
  property int interval
  property string hostname
  property bool online: false
  Timer {
    id: timer
    interval: parent.interval * 60000
    running: true
    repeat: true
    triggeredOnStart: true
    onTriggered: {
      Myth.getHostName();
      if (online) {
	Myth.getUpcomingList();
	Myth.getRecordedList();
      }
      //TODO: reset indizes
    }
  }
  XmlListModel {
    id: upcomingListModel
    query: "/ProgramList/Programs/Program"
    XmlRole { name: "title"; query: "Title/string()" }
    XmlRole { name: "subtitle"; query: "SubTitle/string()" }
    XmlRole { name: "start"; query: "StartTime/string()" }
    XmlRole { name: "end"; query: "EndTime/string()" }
    XmlRole { name: "img"; query: "Channel/IconURL/string()" }
    XmlRole { name: "desc"; query: "Description/string()" }
  }
  XmlListModel {
    id: recordedListModel
    query: "/ProgramList/Programs/Program"
    XmlRole { name: "title"; query: "Title/string()" }
    XmlRole { name: "subtitle"; query: "SubTitle/string()" }
    XmlRole { name: "start"; query: "StartTime/string()" }
    XmlRole { name: "end"; query: "EndTime/string()" }
    XmlRole { name: "img"; query: "Channel/IconURL/string()" }
    XmlRole { name: "desc"; query: "Description/string()" }
  }
}