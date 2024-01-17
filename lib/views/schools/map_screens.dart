import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:mobile_drive_hub/constant/palette.dart';
import 'package:mobile_drive_hub/constant/url.dart';
import 'package:mobile_drive_hub/helpers/dio.dart';
import 'package:dio/dio.dart' as di;
import 'package:mobile_drive_hub/views/schools/grid_view_screen.dart';
import 'package:mobile_drive_hub/views/schools/school_home_screen.dart';
import 'package:persistent_bottom_nav_bar_v2/persistent-tab-view.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';

import '../../model/driving_school_model.dart';

class SchoolMapScreen extends StatefulWidget {
  const SchoolMapScreen({super.key, required this.lat, required this.long});
  final double lat;
  final double long;
  @override
  State<SchoolMapScreen> createState() => _SchoolMapScreenState();
}

class _SchoolMapScreenState extends State<SchoolMapScreen> {
  List<DrivingSchoolModel> schools = [];
  bool isLoading = true;
  Set<Marker> marker = {};
  Set<Polyline> lines = {};
  int nearby = 0;
  @override
  void initState() {
    getSchools();
    super.initState();
  }

  Future<void> getSchools() async {
    final response = await dio("").post(
      data: {
        'lat': widget.lat,
        'long': widget.long,
      },
      'retrieve/schools',
    );
    List<dynamic> schoolData = response.data['schools'];
    schools = schoolData.map(
      (schoolJson) {
        return DrivingSchoolModel.fromJson(schoolJson);
      },
    ).toList();
    PolylinePoints polylinePoints = PolylinePoints();
    for (var school in schools) {
      if (school.distance <= 15) {
        PolylineResult result = await polylinePoints.getRouteBetweenCoordinates(
          'AIzaSyC85qXT_Yw5dwax9Rk9K62DLsxM9vVQWB4',
          PointLatLng(widget.lat, widget.long),
          PointLatLng(
            school.latitude,
            school.longitude,
          ),
        );
        lines.add(
          Polyline(
            width: 3,
            color: primaryBg,
            polylineId: PolylineId(school.userId),
            points: result.points
                .map((e) => LatLng(e.latitude, e.longitude))
                .toList(),
          ),
        );
        nearby++;
      }
      marker.add(
        Marker(
          infoWindow: InfoWindow(
            snippet: school.accredited == 1 ? 'Not yet verified' : 'Accredited',
            title: school.name,
            onTap: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => SchoolHomeScreen(
                    drivingSchoolModel: school,
                  ),
                ),
              );
            },
          ),
          markerId: MarkerId(school.userId),
          position: LatLng(
            school.latitude,
            school.longitude,
          ),
        ),
      );
    }
    setState(() {
      isLoading = false;
    });
  }

  final Completer<GoogleMapController> _controller =
      Completer<GoogleMapController>();
  late final CameraPosition _kGooglePlex = CameraPosition(
    target: LatLng(widget.lat, widget.long),
    zoom: 10,
  );

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    return Scaffold(
      body: SafeArea(
        child: isLoading
            ? const Center(
                child: CircularProgressIndicator(),
              )
            : SizedBox(
                height: height,
                child: Stack(
                  children: [
                    GoogleMap(
                      myLocationButtonEnabled: true,
                      myLocationEnabled: true,
                      mapType: MapType.terrain,
                      markers: marker,
                      polylines: lines,
                      initialCameraPosition: _kGooglePlex,
                      onMapCreated: (GoogleMapController controller) {
                        _controller.complete(controller);
                      },
                    ),
                    Positioned(
                      top: 8,
                      left: 8,
                      child: Row(
                        children: [
                          GestureDetector(
                            onTap: () {
                              Navigator.of(context).push(
                                MaterialPageRoute(
                                  builder: (context) => GridDrivingSchoolView(
                                    listDrivingSchool: schools,
                                  ),
                                ),
                              );
                            },
                            child: const Card(
                              elevation: 5,
                              shape: CircleBorder(),
                              shadowColor: Colors.black38,
                              child: CircleAvatar(
                                backgroundColor: secondaryBg,
                                child: Icon(
                                  Icons.grid_view_outlined,
                                  color: Colors.white,
                                  size: 20,
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                            width: 5,
                          ),
                          Container(
                            height: 40,
                            width: 150,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(10),
                              // border: Border.all(color: primaryBg),
                            ),
                            child: Center(
                              child: Text(
                                'Nearby Schools: ${nearby}',
                                style: const TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
      ),
    );
  }
}
