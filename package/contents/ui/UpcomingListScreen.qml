import QtQuick 1.1
import org.kde.plasma.core 0.1 as PlasmaCore
import org.kde.plasma.components 0.1 as PlasmaComponents
import org.kde.plasma.extras 0.1 as PlasmaExtras
import "plasmapackage:/code/xdate.js" as Jxd

PlasmaExtras.ScrollArea {
  property QtObject upcomingListModel
  ListView {
    id: upcomingListView
    model: parent.upcomingListModel
    delegate: upcomingListDelegate
    // highlight item
    currentIndex: -1
    // expanded item
    property int i: -1
    clip: true
    snapMode: ListView.SnapToItem
    Component {
      id: upcomingListDelegate
      Item {
	id: listitem
	clip: true
        //FIXME: define expanded height depending on description text height
        //TODO: why i have to add the margin?
        height: upcomingListView.i == index ? icon.height * 2 + 10 : icon.height + 10
        Behavior on height {
	  PropertyAnimation {
	    duration: 500
	    easing.type: Easing.InOutCubic
	  }
	}
	width: parent.width
        MouseArea {
          hoverEnabled: true
          onPositionChanged: {
            // index change during flicking disabled
            upcomingListView.flicking ? upcomingListView.currentIndex = upcomingListView.currentIndex : upcomingListView.currentIndex = parseInt(model.index) ;
          }
          anchors.fill: parent
          onClicked: {
            if ( upcomingListView.i == index) {
              upcomingListView.i = -1;
            } else {
              upcomingListView.i = index;
            }
          }
	}
        Image {
          id: icon
          anchors {
	    left: parent.left
	    top: listitem.top
	    topMargin: 5
	    leftMargin: 5
	  }
          // hope every icon has the same size
          width: sourceSize.width / 2
          height: sourceSize.height / 2
          smooth: true
          //FIXME: save this information in properties
          source: "http://" + plasmoid.readConfig("hostadd") + ":" + plasmoid.readConfig("port") + model.img
        }
        PlasmaExtras.Heading {
          id: titleHeading
          anchors {
	    left: icon.right
	    top: listitem.top
	    topMargin: 5	    
	  }
          text: model.title
          level: 3
        }
        Text {
          id: titlePara
          anchors {
	    left: icon.right
	    top: titleHeading.bottom
	    // heading hase enought margin
	    //anchors.topMargin: 5	    
	  }
	  text: model.subtitle
        }
        Text {
          id: startText
          anchors {
	    right: listitem.right
	    top: listitem.top
	    rightMargin: 5
	    topMargin: 5
	  }
          text: Jxd.XDate(model.start).toLocaleDateString()
        }
        Text {
	  anchors {
	    right: listitem.right
	    top: startText.bottom
	    rightMargin: 5
	    topMargin: 5	    
	  }
          text: Jxd.XDate(model.start).toLocaleTimeString() + " - " + Jxd.XDate(model.end).toLocaleTimeString()
        }
        Text {
          opacity: upcomingListView.i == index ? 1 : 0
          Behavior on opacity {
	    PropertyAnimation {
	      duration: 600
	      easing.type: Easing.InOutCubic
	    }
	  }
	  anchors {
	    left: icon.right
	    top: icon.bottom
	    right: listitem.right
	    bottom: listitem.bottom
	    topMargin: 5
	    rightMargin: 5
	    bottomMargin: 5
	  }
          text: model.desc
          wrapMode: Text.Wrap
	}
      }
    }
    highlight: PlasmaComponents.Highlight {
      hover: true
    }
  }
}