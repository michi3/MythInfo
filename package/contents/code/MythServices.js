function getBaseUrl(service) {
  //TODO no ssl?
  return "http://" + plasmoid.readConfig("hostadd") + ":" + plasmoid.readConfig("port") + "/" + service + "/";
}

//TODO: read fresh config value...should be a property or something
function getPreferredItemsCount() {
  return plasmoid.readConfig("itemscount");
}

function request(url, json, callback) {
  var xhr = new XMLHttpRequest();
  xhr.onreadystatechange = (function f() {
    callback(xhr);
  });
  xhr.open('GET', url, true);
  if (json)
    xhr.setRequestHeader("Accept","application/json");
  xhr.send();
}

function getUpcomingList() {
  var method = "GetUpcomingList?Count=" + getPreferredItemsCount();
  request(getBaseUrl("Dvr") + method, false, getUpcomingListCallback);
}

function getUpcomingListCallback(xhr) {
  
  if (xhr.readyState == XMLHttpRequest.DONE && xhr.status == 200) {
    model.upcoming.xml = xhr.responseText;
  }
}

function getRecordedList() {
  var method = "GetRecordedList?Count=" + getPreferredItemsCount() + "&Descending=true";
  request(getBaseUrl("Dvr") + method, false, getRecordedListCallback);
}

function getRecordedListCallback(xhr) {
  if (xhr.readyState == XMLHttpRequest.DONE && xhr.status == 200) {
    model.recorded.xml = xhr.responseText;
  }
}

function getConflictList() {
  var method = "GetConflictList?Count=" + getPreferredItemsCount();
  request(getBaseUrl("Dvr") + method, false, getConflictListCallback);
}

function getConflictListCallback(xhr) {
  if (xhr.readyState == XMLHttpRequest.DONE && xhr.status == 200) {
    model.conflict.xml = xhr.responseText;
  }
}

function getHostName() {
  var method = "GetHostName";
  request(getBaseUrl("Myth") + method, true, getHostNameCallback);
}

function getHostNameCallback(xhr) {
  if (xhr.readyState == XMLHttpRequest.DONE) {
    if (xhr.status == 200) {
      ret = JSON.parse(xhr.responseText);
      model.hostname = ret.String;
      // if already online, don't restart the timer -> loop
      //TODO: just return is not the best code
      if (model.online)
	return;
      model.online = true;
      model.timer.restart();
    } else {
      model.online = false;
    }
  }
  
}