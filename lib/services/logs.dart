import 'package:call_log/call_log.dart';
import 'package:permissions_flutter/services/permissions.dart';

class ReadLOGS {

  PermissionsService _permissionsService = PermissionsService();

  void readCallLogs() async {
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
      //How many entries ate there ?
      print('entries: ${allEntries.length}');
      //Get a single entry
      for (int i=0; i<allEntries.length; i++) {
        CallLogEntry singleEntry = allEntries[i];

        int time = singleEntry.timestamp;
        print('Name: ${singleEntry.name}\n'
              'Duration: ${singleEntry.duration} Secs\n'
              'Date: ${DateTime.fromMillisecondsSinceEpoch(time)}');
      }
  }
}