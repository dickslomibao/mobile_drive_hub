import 'package:app_settings/app_settings.dart';
import 'package:flutter/material.dart';
import 'package:mobile_drive_hub/constant/palette.dart';
import 'package:mobile_drive_hub/views/schools/map_screens.dart';
import 'package:persistent_bottom_nav_bar_v2/persistent-tab-view.dart';

import '../../../services/geo_location.dart';
import '../appbar/app_bar_widget.dart';
import 'filter_courses.dart';
import 'filter_school.dart';

class SelectionScreen extends StatelessWidget {
  const SelectionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width - 30;
    return Scaffold(
      backgroundColor: primaryBg,
      body: SafeArea(
        child: Container(
          color: Colors.white,
          child: Column(
            children: [
              const AppBarWidget(
                title: 'Search',
              ),
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // const Text(
                    //   'What are you looking for?',
                    //   textAlign: TextAlign.center,
                    //   style: TextStyle(
                    //     fontSize: 24,
                    //     fontWeight: FontWeight.w500,
                    //   ),
                    // ),
                    // const SizedBox(
                    //   height: 50,
                    // ),
                    SizedBox(
                      width: width * .8,
                      height: 50,
                      child: ElevatedButton(
                        onPressed: () async {
                          final p = await geoLocationServices.getPermission();

                          if (p == 'granted') {
                            final position =
                                await geoLocationServices.getPosition();
                            if (context.mounted) {
                              pushNewScreen(
                                context,
                                screen: SchoolMapScreen(
                                  lat: position.latitude,
                                  long: position.longitude,
                                ),
                                withNavBar: false,
                              );
                            }
                          } else if (p == "Turn un your location.") {
                            AppSettings.openAppSettings(
                                type: AppSettingsType.location);
                          }
                        },
                        style: ElevatedButton.styleFrom(
                          elevation: 0,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        child: const Text(
                          'Free View',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ),
                    const Padding(
                      padding: EdgeInsets.symmetric(vertical: 20.0),
                      child: Text(
                        'OR',
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                          color: Color.fromRGBO(0, 0, 0, .8),
                        ),
                      ),
                    ),
                    SizedBox(
                      width: width * .8,
                      height: 50,
                      child: OutlinedButton(
                        style: OutlinedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        onPressed: () {
                          pushNewScreen(
                            context,
                            screen: FillterDrivingSchoolScreen(),
                            withNavBar: false,
                          );
                        },
                        child: const Text(
                          'Search Driving School',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    SizedBox(
                      width: width * .8,
                      height: 50,
                      child: OutlinedButton(
                        style: OutlinedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        onPressed: () {
                          pushNewScreen(
                            context,
                            screen: FillterCoursesScreen(),
                            withNavBar: false,
                          );
                        },
                        child: const Text(
                          'Search Courses',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
