/***************************************************************************
 *   Copyright (C) %{CURRENT_YEAR} by %{AUTHOR} <%{EMAIL}>                            *
 *                                                                         *
 *   This program is free software; you can redistribute it and/or modify  *
 *   it under the terms of the GNU General Public License as published by  *
 *   the Free Software Foundation; either version 2 of the License, or     *
 *   (at your option) any later version.                                   *
 *                                                                         *
 *   This program is distributed in the hope that it will be useful,       *
 *   but WITHOUT ANY WARRANTY; without even the implied warranty of        *
 *   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the         *
 *   GNU General Public License for more details.                          *
 *                                                                         *
 *   You should have received a copy of the GNU General Public License     *
 *   along with this program; if not, write to the                         *
 *   Free Software Foundation, Inc.,                                       *
 *   51 Franklin Street, Fifth Floor, Boston, MA  02110-1301  USA .        *
 ***************************************************************************/

import QtQuick 1.1
import org.kde.plasma.components 0.1 as PlasmaComponents
import org.kde.plasma.extras 0.1 as PlasmaExtras

Item {
  id:root
  //TODO: not getting set anywhere
  property bool online: true
  property bool showUpcoming: plasmoid.readConfig("upcoming")
  property bool showConflicts: plasmoid.readConfig("conflicts")
  property bool showRecorded: plasmoid.readConfig("recorded")
  property int refreshEvery : plasmoid.readConfig("refreshevery")
  function configChanged() {
    root.showUpcoming = plasmoid.readConfig("upcoming");
    root.showConflicts = plasmoid.readConfig("conflicts");
    root.showRecorded = plasmoid.readConfig("recorded");
    root.refreshEvery = plasmoid.readConfig("refreshevery");
  }
  Component.onCompleted: { // read configuration, in case of change in configuration
    plasmoid.addEventListener('ConfigChanged', configChanged);
  }
  // no effect
  //property int minimumWidth: paintedWidth
  //property int minimumHeight: paintedHeight
  PlasmaComponents.TabBar {
    id: tabBar
    height: 27
    width: 0.9 * parent.width
    visible: online
    anchors {
      top: root.top
      topMargin: 5
      horizontalCenter: parent.horizontalCenter
    }
    PlasmaComponents.TabButton {
      tab: statusScreen
      text: i18n("Status")
    }
    PlasmaComponents.TabButton {
      visible: showUpcoming
      tab: upcomingListScreen
      text:i18n("Upcoming Recordings")
    }
    PlasmaComponents.TabButton {
      visible: showRecorded
      tab: recordedListScreen
      text:i18n("Last Recordings")
    }
    PlasmaComponents.TabButton {
      visible: showConflicts
      //TODO: not yet implemented
      tab: upcomingListScreen
      text:i18n("Recording Conflicts")
    }
  }
  PlasmaComponents.TabGroup {
    anchors {
      top: tabBar.bottom
      left: root.left
      right: root.right
      bottom: root.bottom
      margins: 10
    }
    StatusScreen {
      id: statusScreen
      anchors.fill: parent
      statusModel: model
    }
    UpcomingListScreen {
      id: upcomingListScreen
      anchors.fill: parent
      upcomingListModel: model.upcoming
    }
    RecordedListScreen {
      id: recordedListScreen
      anchors.fill: parent
      recordedListModel: model.recorded
    }
//     ConflictListScreen {
//       id: conflictListScreen
//       anchors.fill: parent
//     }
  }
  UnavailableScreen {
    visible: !online
    anchors.fill: parent
  }
  Model {
    id: model
    interval: root.refreshEvery
  }
}