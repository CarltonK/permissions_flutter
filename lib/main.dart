import 'package:flutter/material.dart';
import 'package:permissions_flutter/services/identifier.dart';
import 'package:permissions_flutter/services/location.dart';
import 'package:permissions_flutter/services/logs.dart';
import 'package:permissions_flutter/services/permissions.dart';
import 'package:permissions_flutter/services/sms.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Permissions',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  ReadSMS _readSMS = ReadSMS();
  ReadLOGS _readLOGS = ReadLOGS();
  Location _location = Location();
  Identifier _identifier = Identifier(); 
  String _id = '1';
  PermissionsService _permissionsService = PermissionsService();

  void _incrementCounter() async {
    _permissionsService.requestallPermissions();
    _location.getCoordinates();
    //String id = await _identifier.getIMEI();
    //_readLOGS.readCallLogs(id);
    //String token = "e0eac2114e908fe7c8f50ff86a020860050fcd24dac533e64b48d3091e203994";
    //_readSMS.readMPESA(id, token);
    setState(() {
     //_id = id;
    });
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'IMEI',
            ),
            Text(
              '$_id',
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
