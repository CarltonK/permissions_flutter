import 'dart:convert';
import 'package:permissions_flutter/models/smsmodel.dart';
import 'package:permissions_flutter/models/usermodel.dart';
import 'package:permissions_flutter/services/permissions.dart';
import 'package:sms/sms.dart';
import 'package:http/http.dart' as http;

class ReadSMS {

  PermissionsService _permissionsService = PermissionsService();

  void readMPESA(String imei, String token) async {
    var status = await _permissionsService.requestSmsPermission();
    if (status == true) {
      //This function handles reading MPESA messages
      SmsQuery query = new SmsQuery();
      //Store the messages in a list
      List<SmsMessage> mpesaMessages = await query.querySms(
          kinds: [SmsQueryKind.Inbox], address: 'MPESA',
      );
      //How many are they ?
      print('Count: ${mpesaMessages.length}');
      //Initialize an empty list to hold SMS objects
      List<SMS> smsList = [];
      //Initialize SMS Object as empty 
      SMS sms;
       //Read Contents by iterating through the list
      for (int i=0; i<mpesaMessages.length; i++) {
        SmsMessage singleSMS = mpesaMessages[i];
        sms = SMS(
          address: singleSMS.address,
          body: singleSMS.body,
          date: singleSMS.date
        );
        //Populate the List
        smsList.add(sms);
      }
      //Map List<SMS> to String
      String records = List<dynamic>.from(smsList.map((x) => x.toJSON())).toString();
      //Create a user object
      User user = User(
        mpesaSmsData: records,
        regImei: imei,
        regSerial: 'R58M55CMGWB',
      );
      //Convert User from Object to JSON
      String userToJson(User data) => json.encode(data.toJson());
      //Store as a variable to be able to read
      var data = userToJson(user);
      print(data);
      // //Try HTTP Post
      // var url = 'https://hapoloans.com/api/v1/loans/get_mpesa_sms_data/';
      // var response = await http.post(
      //   url,
      //   headers: {"Content-Type":"application/json","Authorization":"Token $token"}, 
      //   body: data);
      // print('Response status: ${response.statusCode}');
      // print('Response body: ${response.body}');
    }
    else {
      //Executed if permission is not granted
      _permissionsService.requestSmsPermission();
    }
  }
}