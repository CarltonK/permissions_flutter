import 'package:geolocator/geolocator.dart';
import 'package:permissions_flutter/services/permissions.dart';

class Location {

  PermissionsService _permissionsService = PermissionsService();
  
  //Get co-ordinates of device
  void getCoordinates() async {
    var status = await _permissionsService.requestLocationPermission();
    if (status == true) {
      var geolocator = Geolocator();
      //Check device location status
      GeolocationStatus geolocationStatus = await geolocator.checkGeolocationPermissionStatus();
      switch (geolocationStatus){
        case GeolocationStatus.denied:
          print('denied');
          break;
        case GeolocationStatus.disabled:
          print('disabled');
          break;
        case GeolocationStatus.restricted:
          print('restricted');
          break;
        case GeolocationStatus.unknown:
          print('unknown');
          break;
        case GeolocationStatus.granted:
          await Geolocator(
          )
          .getCurrentPosition(desiredAccuracy: LocationAccuracy.high)
          .catchError((onError) {
            print('Error: $onError');
          })
          .then((Position _position) {
          if (_position != null) {
            var latitude = _position.latitude;
            print('Latitude: $latitude');
            var longitude = _position.longitude;
            print('Latitude: $longitude');
          }
           });
        break;
      }
    }
    else {
      //Executed if permission is not granted
      _permissionsService.requestLocationPermission();
    }
  }
}