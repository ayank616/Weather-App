// ignore_for_file: unused_local_variable, avoid_print

import 'package:geolocator/geolocator.dart';

class Location {
  double? latitude, longitude;

  Future<void> getCurrentLocation() async {
    try {
      LocationPermission permission = await Geolocator.requestPermission();
      Position position = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.low);

      latitude = position.latitude;
      longitude = position.longitude;
      // print(position);
    } catch (e) {
      print(e);
    }
  }
}
