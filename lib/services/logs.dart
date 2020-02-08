import 'dart:convert';

import 'package:call_log/call_log.dart';
import 'package:permissions_flutter/models/logmodel.dart';
import 'package:permissions_flutter/models/usermodel.dart';
import 'package:permissions_flutter/services/permissions.dart';

class ReadLOGS {

  PermissionsService _permissionsService = PermissionsService();

  void readCallLogs(String imei) async {
      //Check Permission status
      var status = await _permissionsService.requestLogsPermission();
      //If the permission is granted
      if (status == true) {
        //Query the Logs for the past 90 days
      //Initiate the DateTime module;
      var now = DateTime.now();
      int from = now.subtract(Duration(days: 90)).millisecondsSinceEpoch;
      int to = now.subtract(Duration(days: 0)).millisecondsSinceEpoch;
      Iterable<CallLogEntry> entries = await CallLog.query(
        dateFrom: from,
        dateTo: to,
      );
      //Add the entries to a list
      List allEntries = entries.toList();
      //How many entries are there ?
      print('Count: ${allEntries.length}');
      //Iterate through the list to get a single entry
      //Iteration will also help to store as a custom LOG object
      //Initialize an empty list to hold SMS objects
      List<LOG> logList = [];
      //Initialize SMS Object as empty 
      LOG log;
      for (int i=0; i<allEntries.length; i++) {
        CallLogEntry singleEntry = allEntries[i];
        //Timestamp returns an integer, store in variable names time
        int time = singleEntry.timestamp;
        //Convert time to DateTime
        DateTime date = DateTime.fromMillisecondsSinceEpoch(time);
        //Create custom LOG object for every entry
        log = LOG(
          name: singleEntry.name,
          duration: singleEntry.duration,
          date: date
        );
        //Populate logList with LOG objects
        logList.add(log);
        print('Name: ${singleEntry.name}\n'
              'Duration: ${singleEntry.duration} Secs\n'
              'Date: $date');
      }
      //Map List<SMS> to String
      String records = List<dynamic>.from(logList.map((x) => x.toJSON())).toString();
      //Create a user object
      User user = User(
        callData: records,
        regImei: imei,
        regSerial: '',
      );
      //Convert User from Object to JSON
      String userToJson(User data) => json.encode(data.toJson());
      //Store as a variable to be able to read
      var data = userToJson(user);
      print(data);
    }
    else {
      //Executed if permission is not granted
      _permissionsService.requestLogsPermission();
    }
  }
}