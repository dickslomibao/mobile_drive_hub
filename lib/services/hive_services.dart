import 'package:hive_flutter/hive_flutter.dart';

class HiveServices {
  final myBox = Hive.box('user');

  Future<void> setProfile(String profile) async {
    await myBox.put('profile', profile);
  }

  String getProfile() {
    return myBox.get('profile') ?? "";
  }
}

HiveServices hiveServices = HiveServices();
