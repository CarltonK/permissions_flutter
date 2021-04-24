import 'package:location/location.dart';
import 'package:permissions_flutter/services/permissions.dart';

class Locate {

  PermissionsService _permissionsService = PermissionsService();
  
  //Get co-ordinates of device
  Future<Map<String, dynamic>> getCoordinates() async {
    //Check if the permission is granted
    var status = await _permissionsService.requestLocationPermission();
    if (status == true) {
      //If the location is granted. Check if the GPS is on
      Location _locationService = Location();
      //Show the GPS dialog
      bool status = await _locationService.requestService();
      //If the GPS is on, get the location data
      if (status) {
        await _locationService.changeSettings(accuracy: LocationAccuracy.HIGH, interval: 100);
        //Get Location Data
        LocationData location;
        location = await _locationService.getLocation();
        var lat = location.latitude;
        print('Lat - $lat');
        var lon = location.longitude;
        print('Lon - $lon');
        Map<String, dynamic> coords = {
          'lat': lat,
          'lon': lon
        };
        return coords;
      }
      else {
        return null;
      }
    }
    else {
      //Executed if permission is not granted
      _permissionsService.requestLocationPermission();
      return null;
    }
  }
}