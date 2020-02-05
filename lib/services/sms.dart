
import 'package:permissions_flutter/services/permissions.dart';
import 'package:sms/sms.dart';

class ReadSMS {

  PermissionsService _permissionsService = PermissionsService();

  void readThread() async {
    var status = await _permissionsService.requestSmsPermission();
    if (status == true) {
      print('We want to read sms. We have the permissions');
      //Permission is granted. Time to perform a function
      SmsQuery query = new SmsQuery();
      //A function to get all SMS
      List<SmsMessage> messages = await query.querySms(
        kinds: [SmsQueryKind.Inbox]
      );
      print('messages number: ${messages.length}');
    }
  }

  void readMPESA() async {
    var status = await _permissionsService.requestSmsPermission();
    if (status == true) {
      //This function handles reading MPESA messages
      SmsQuery query = new SmsQuery();
      //Store the messages in a list
      List<SmsMessage> mpesaMessages = await query.querySms(
          kinds: [SmsQueryKind.Inbox], address: 'MPESA'
      );
      //How many are they ?
      print('messages number: ${mpesaMessages.length}');
      //Read Contents by iterating through the list
      for (int i=0; i<mpesaMessages.length; i++) {
        SmsMessage singleSMS = mpesaMessages[i];
        print('$i: ${singleSMS.body}');
      }
    }
  }
}