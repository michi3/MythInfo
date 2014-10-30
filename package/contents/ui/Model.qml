import QtQuick 1.1
import "plasmapackage:/code/MythServices.js" as Myth

Item {
  property alias upcoming: upcomingListModel
  property alias recorded: recordedListModel
  property int interval
  property string hostname
  Timer {
    interval: parent.interval * 60000
    //running: parent.active
    running: true
    repeat: true
    triggeredOnStart: true
    onTriggered: {
      Myth.getHostName();
      Myth.getUpcomingList();
      Myth.getRecordedList();
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