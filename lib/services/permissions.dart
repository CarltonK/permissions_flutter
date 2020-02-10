import 'package:location/location.dart';
import 'package:permission_handler/permission_handler.dart';

class PermissionsService {
  //Instantiate permission handler
  final PermissionHandler _permissionHandler = PermissionHandler();

  //This function requests a specific permission
  //The parameter is a list or permissions otherwise called a Permission Group
  Future<bool> requestPermission(PermissionGroup permissionGroup) async {
    //Request permissions in a permission group
    var result = await _permissionHandler.requestPermissions([permissionGroup]);
    print('result: $result');
    //result is a Map. To request the value of a single entry, pass the key,
    //which is an entry in the permissiongroup
    if (result[permissionGroup]  == PermissionStatus.granted) {
      //If permission is granted return true
      return true;
    }
    //Call the permission request window
    await _permissionHandler.shouldShowRequestPermissionRationale(permissionGroup);
    return false;
    //Otherwise return false by default
  }

  //A permission function for reading logs
  Future<bool> requestLogsPermission() async {
    return requestPermission(PermissionGroup.phone);
  }

  //A permission function for reading SMS on device
  Future<bool> requestSmsPermission() async {
    return requestPermission(PermissionGroup.sms);
  }

  //A permission function for getting location of a device
  Future<bool> requestLocationPermission() async {
    PermissionGroup _permission =PermissionGroup.location;
    var result = await _permissionHandler.requestPermissions([_permission]);
    if (result[_permission] == PermissionStatus.granted) {
      return true;
    }
    else if(result[_permission] == PermissionStatus.disabled) {
      //call the function to open the desired Android menu
      var location = Location();
      bool status = await location.requestService();
      if (status) {
        requestLocationPermission();
      }
      requestLocationPermission();
    }
    //Call the permission request window
    await _permissionHandler.shouldShowRequestPermissionRationale(_permission);
    return false;
    //Otherwise return false by default
  }

  //All permissions required by this application
  List<PermissionGroup> requiredPerms = [
    PermissionGroup.sms,
    PermissionGroup.phone,
    PermissionGroup.location
  ];
  Future<bool> requestallPermissions() async {
    for (int i=0;i<requiredPerms.length;i++) {
      await requestPermission(requiredPerms[i]);
    }
    return null;
  }

  //A function for showing a request window
  Future<bool> _showRequestWindow(PermissionGroup permission) async {
    var result = await _permissionHandler.shouldShowRequestPermissionRationale(permission);
    return result;
  }


}