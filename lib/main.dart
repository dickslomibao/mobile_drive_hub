import 'package:flutter/material.dart';
import 'package:mobile_drive_hub/constant/palette.dart';
import 'package:mobile_drive_hub/services/token_services.dart';
import 'package:mobile_drive_hub/views/instructurs/bottom_navbar/instructor_screen.dart';
import 'package:mobile_drive_hub/views/splash/last_screen.dart';
import 'package:mobile_drive_hub/views/students/bottom_navbar/student_screen.dart';
import 'package:provider/provider.dart';
import 'providers.dart';
import 'package:hive_flutter/hive_flutter.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  await Hive.openBox('user');
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: providers,
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'DriveHub',
        theme: ThemeData(
          primarySwatch: myColor,
        ),
        home: FutureBuilder(
          future: tokenServices.getUserType(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Scaffold(
                body: Center(
                  child: CircularProgressIndicator(),
                ),
              );
            }
            if (snapshot.data == "") {
              return const LastSplashScreen();
            }
            if (snapshot.data == "3") {
              return StudentMainScreen();
            }
            return InstructormMainScreen();
          },
        ),
      ),
    );
  }
}
