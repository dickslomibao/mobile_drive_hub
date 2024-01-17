import 'package:app_settings/app_settings.dart';
import 'package:flutter/material.dart';

import 'package:mobile_drive_hub/views/auth/login/login.dart';
import 'package:persistent_bottom_nav_bar_v2/persistent-tab-view.dart';

import '../../services/geo_location.dart';
import '../auth/register/register_screen.dart';
import '../schools/map_screens.dart';

class LastSplashScreen extends StatefulWidget {
  const LastSplashScreen({super.key});
  @override
  State<LastSplashScreen> createState() => _LastSplashScreenState();
}

class _LastSplashScreenState extends State<LastSplashScreen> {
  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width - 30;
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(
                      'assets/logo/logo.png',
                      height: 100,
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Image.asset(
                      'assets/logo/logo-text.png',
                      height: 60,
                    ),
                  ],
                ),
                const SizedBox(
                  height: 80,
                ),
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
                        )),
                    child: const Text(
                      'Find Driving School',
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
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => const LoginScreen(),
                        ),
                      );
                    },
                    child: const Text(
                      'Sign in',
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
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => const RegistrationScreen(),
                        ),
                      );
                    },
                    child: const Text(
                      'Sign up',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
