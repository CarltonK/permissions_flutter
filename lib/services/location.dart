import 'package:location/location.dart';
import 'package:permissions_flutter/services/permissions.dart';

class Locate {

  PermissionsService _permissionsService = PermissionsService();
  
  //Get co-ordinates of device
  void getCoordinates() async {
    var status = await _permissionsService.requestLocationPermission();
    if (status == true) {
      Location _locationService = Location();
      bool status = await _locationService.requestService();
      if (status) {
        await _locationService.changeSettings(accuracy: LocationAccuracy.HIGH, interval: 1000);
        //Get Location Data
        LocationData location;
        location = await _locationService.getLocation();
        var lat = location.latitude;
        print(lat);
        var long = location.longitude;
        print(long);
      }
    }
    else {
      //Executed if permission is not granted
      _permissionsService.requestLocationPermission();
    }
  }
}