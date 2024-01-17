import 'dart:async';

import 'package:geolocator/geolocator.dart';

class GeoLocationServices {
  Future<String> getPermission() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return "Turn un your location.";
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return "Permission denied.";
      }
    }

    if (permission == LocationPermission.deniedForever) {
      return "Go to settings and turn on location";
    }
    return 'granted';
  }

  Future<Position> getPosition() {
    return Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.high,
    );
  }

  StreamSubscription<Position> streamPOsiton(dynamic function) {
    return Geolocator.getPositionStream(
        locationSettings: const LocationSettings(
      accuracy: LocationAccuracy.bestForNavigation,
      distanceFilter: 5,
    )).listen(function);
  }
}

GeoLocationServices geoLocationServices = GeoLocationServices();
