import 'package:imei_plugin/imei_plugin.dart';

class Identifier {

  Future<String> getIMEI() async {
    String imei = await ImeiPlugin
        .getImei( shouldShowRequestPermissionRationale: false );
    return imei;
  }
}