// import 'dart:ffi';

// import 'package:dio/dio.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_map/flutter_map.dart';
// import 'package:latlong2/latlong.dart';
// import 'package:mobile_drive_hub/constant/url.dart';
// import 'package:mobile_drive_hub/helpers/dio.dart';
// import 'package:dio/dio.dart' as di;

// class TestMapBox extends StatefulWidget {
//   const TestMapBox({super.key});

//   @override
//   State<TestMapBox> createState() => _TestMapBoxState();
// }

// class _TestMapBoxState extends State<TestMapBox> {
//   late final MapController mapController;

//   @override
//   void initState() {
//     super.initState();
//     mapController = MapController();
//   }

//   Future<List<dynamic>> getSchools() async {
//     di.Response response = await dio().post('retrieve/schools');
//     return response.data['schools'];
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: SafeArea(
//         child: FutureBuilder(
//           future: getSchools(),
//           builder: (context, snapshot) {
//             if (snapshot.connectionState == ConnectionState.waiting) {
//               return const Center(
//                 child: CircularProgressIndicator(),
//               );
//             }
//             return FlutterMap(
//               mapController: mapController,
//               options: MapOptions(
//                 minZoom: 5,
//                 maxZoom: 18,
//                 zoom: 10,
//                 center: LatLng(15.9758, 120.5707),
//               ),
//               children: [
//                 TileLayer(
//                   urlTemplate:
//                       "https://api.mapbox.com/styles/v1/royceehorta/{mapStyleId}/tiles/256/{z}/{x}/{y}@2x?access_token={accessToken}",
//                   additionalOptions: const {
//                     'mapStyleId': 'cll9ibz8700bx01q0h0m873w8',
//                     'accessToken':
//                         'pk.eyJ1Ijoicm95Y2VlaG9ydGEiLCJhIjoiY2xrd2d5Y2s1MDAyYTNlcW9xbTY5Yml2ZCJ9.KS2OSp51FGQnPTooKJHqzQ',
//                   },
//                 ),
//                 MarkerLayer(
//                   markers: snapshot.data!
//                       .map(
//                         (e) => Marker(
//                           point: LatLng(
//                             double.parse(e['latitude']),
//                             double.parse(e['longitude']),
//                           ),
//                           builder: (context) => CircleAvatar(
//                             backgroundImage:
//                                 NetworkImage(WEBSITE_URL + e['profile_image']),
//                           ),
//                         ),
//                       )
//                       .toList(),
//                 )
//               ],
//             );
//           },
//         ),
//       ),
//     );
//   }
// }

// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:mobile_drive_hub/constant/url.dart';
// import 'package:mobile_drive_hub/helpers/dio.dart';
// import 'package:dio/dio.dart' as di;
// import 'package:mapbox_gl/mapbox_gl.dart';
// import 'package:http/http.dart' as http;

// class TestMapBox extends StatefulWidget {
//   const TestMapBox({super.key, required this.lat, required this.long});
//   final double lat;
//   final double long;
//   @override
//   State<TestMapBox> createState() => _TestMapBoxState();
// }

// class _TestMapBoxState extends State<TestMapBox> {
//   Future<List<dynamic>> getSchools() async {
//     di.Response response = await dio("asd").post('retrieve/schools');
//     return response.data['schools'];
//   }

//   late CameraPosition _initialCameraPosition;

//   late final MapboxMapController controller;
//   @override
//   void initState() {
//     super.initState();
//     _initialCameraPosition = CameraPosition(
//       target: LatLng(
//         widget.lat,
//         widget.long,
//       ),
//       zoom: 15,
//     );
//   }

//   Future<void> addImageFromUrl(String name, Uri uri) async {
//     var response = await http.get(uri);
//     return controller.addImage(name, response.bodyBytes);
//   }

//   Future<void> addImageFromAsset(String name, String assetName) async {
//     final ByteData bytes = await rootBundle.load(assetName);
//     final Uint8List list = bytes.buffer.asUint8List();
//     return controller.addImage(name, list);
//   }

//   @override
//   void dispose() {
//     // TODO: implement dispose
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: SafeArea(
//         child: Stack(
//           children: [
//             Text("asd"),
//             MapboxMap(
//               onStyleLoadedCallback: () async {
//                 // for (var e in snapshot.data!) {
//                 //   await addImageFromAsset(
//                 //       "assetImage", "assets/images/logo.png");

//                 //   await addImageFromUrl("networkImage",
//                 //       Uri.parse(WEBSITE_URL + e['profile_image']));

//                 //   await controller.addSymbol(
//                 //     SymbolOptions(
//                 //       geometry: LatLng(
//                 //         double.parse(e['latitude']),
//                 //         double.parse(e['longitude']),
//                 //       ),
//                 //       iconSize: .2,
//                 //       iconImage: 'networkImage',
//                 //     ),
//                 //   );
//                 // }
//               },
//               onMapCreated: (mapBoxController) {
//                 controller = mapBoxController;
//               },
//               onUserLocationUpdated: (location) {
//                 print(location.position);
//               },
//               myLocationEnabled: true,
//               myLocationTrackingMode: MyLocationTrackingMode.TrackingGPS,
//               initialCameraPosition: _initialCameraPosition,
//               accessToken: MAPBOX_TOKEN,
//             )
//           ],
//         ),
//       ),
//       floatingActionButton: FloatingActionButton(
//         onPressed: () {
//           controller.animateCamera(
//               CameraUpdate.newCameraPosition(_initialCameraPosition));
//         },
//         child: const Icon(Icons.my_location),
//       ),
//     );
//   }
// }


// Stack(
//                                             children: [
//                                               Image.network(
//                                                 WEBSITE_URL +
//                                                     e['profile_image'],
//                                               ),
//                                               Positioned(
//                                                 top: 10,
//                                                 left: 10,
//                                                 child: Row(
//                                                   children: const [
//                                                     CircleAvatar(
//                                                       radius: 21,
//                                                       backgroundColor:
//                                                           secondaryBg,
//                                                       child: CircleAvatar(
//                                                         backgroundColor:
//                                                             Colors.white,
//                                                         child: Icon(
//                                                           Icons.arrow_back,
//                                                           color: secondaryBg,
//                                                           size: 20,
//                                                         ),
//                                                       ),
//                                                     ),
//                                                   ],
//                                                 ),
//                                               ),
//                                               Positioned(
//                                                 top: 10,
//                                                 right: 60,
//                                                 child: Row(
//                                                   children: const [
//                                                     CircleAvatar(
//                                                       radius: 21,
//                                                       backgroundColor:
//                                                           primaryBg,
//                                                       child: CircleAvatar(
//                                                         backgroundColor:
//                                                             Colors.white,
//                                                         child: Icon(
//                                                           Icons
//                                                               .favorite_border_outlined,
//                                                           color: primaryBg,
//                                                           size: 20,
//                                                         ),
//                                                       ),
//                                                     ),
//                                                   ],
//                                                 ),
//                                               ),
//                                               Positioned(
//                                                 top: 10,
//                                                 right: 10,
//                                                 child: Row(
//                                                   children: const [
//                                                     CircleAvatar(
//                                                       radius: 21,
//                                                       backgroundColor:
//                                                           primaryBg,
//                                                       child: CircleAvatar(
//                                                         backgroundColor:
//                                                             Colors.white,
//                                                         child: Icon(
//                                                           Icons
//                                                               .message_outlined,
//                                                           color: primaryBg,
//                                                           size: 20,
//                                                         ),
//                                                       ),
//                                                     ),
//                                                   ],
//                                                 ),
//                                               )
//                                             ],
//                                           ),