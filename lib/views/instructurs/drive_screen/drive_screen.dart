// import 'dart:async';

// import 'package:flutter/material.dart';
// import 'package:google_maps_flutter/google_maps_flutter.dart';
// import 'package:location/location.dart';

// class DriveScreen extends StatefulWidget {
//   const DriveScreen({super.key});

//   @override
//   State<DriveScreen> createState() => _DriveScreenState();
// }

// class _DriveScreenState extends State<DriveScreen> {
//   final Completer<GoogleMapController> _controller =
//       Completer<GoogleMapController>();
//   Location location = Location();
//   List<LatLng> l = [];
//   Set<Polyline> lines = {};
//   void onChange() async {
//     await location.changeSettings(
//         accuracy: LocationAccuracy.high, interval: 10000, distanceFilter: 5);

//     location.onLocationChanged.distinct().listen((
//       event,
//     ) {
//       setState(() {
//         lines.clear();
//         l.add(LatLng(event.latitude!, event.longitude!));
//         lines.add(Polyline(polylineId: PolylineId('asd'), points: l));
//         print(event);
//       });
//     });
//   }

//   static const CameraPosition _kGooglePlex = CameraPosition(
//     target: LatLng(37.42796133580664, -122.085749655962),
//     zoom: 14.4746,
//   );

//   static const CameraPosition _kLake = CameraPosition(
//       bearing: 192.8334901395799,
//       target: LatLng(37.43296265331129, -122.08832357078792),
//       tilt: 59.440717697143555,
//       zoom: 19.151926040649414);
//   @override
//   void initState() {
//     // TODO: implement initState
//     super.initState();
//     onChange();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: GoogleMap(
//         myLocationEnabled: true,
//         myLocationButtonEnabled: true,
//         mapType: MapType.normal,
//         polylines: lines,
//         initialCameraPosition: _kGooglePlex,
//         onMapCreated: (GoogleMapController controller) {
//           _controller.complete(controller);
//         },
//       ),
//       floatingActionButton: FloatingActionButton.extended(
//         onPressed: _goToTheLake,
//         label: const Text('To the lake!'),
//         icon: const Icon(Icons.directions_boat),
//       ),
//     );
//   }

//   Future<void> _goToTheLake() async {
//     final GoogleMapController controller = await _controller.future;
//     await controller.animateCamera(CameraUpdate.newCameraPosition(_kLake));
//   }
// }
