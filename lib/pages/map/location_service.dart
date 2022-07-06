import 'dart:async';

import 'package:find_hospital/pages/map/user_location.dart';
import 'package:location/location.dart';

class LocationService {
  Location location = Location();
  StreamController<UserLocation> _locationStreamController =
      StreamController<UserLocation>();
  Stream<UserLocation> get locationStream => _locationStreamController.stream;

  LocationService() {
    location.requestPermission().then((permisionStatus) {
      if (permisionStatus == PermissionStatus.granted) {
        location.onLocationChanged.listen((locationData) {
          if (locationData != null) {
            _locationStreamController.add(UserLocation(
                lat: locationData.latitude, long: locationData.longitude));
          }
        });
      }
    });
  }

  void dispose() => _locationStreamController.close();
}
