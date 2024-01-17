import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:mobile_drive_hub/services/hive_services.dart';
import 'package:mobile_drive_hub/services/login_services.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:mobile_drive_hub/services/token_services.dart';

class LoginController extends ChangeNotifier {
  DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();

  Future<String> login({
    required String usernameEmail,
    required String password,
  }) async {
    String error = "";
    AndroidDeviceInfo androidInfo = await deviceInfo.androidInfo;
    try {
      final response = await loginServices.login(
        usernameEmail: usernameEmail,
        password: password,
        deviceName: androidInfo.model,
      );
      if (response.data['code'] == 200) {
        String userType = response.data['user']['type'].toString();
        String userId = response.data['user']['id'].toString();
        String profileImage = response.data['user']['profile_image'].toString();
        print(response.data['token']);
        print(profileImage);
        await tokenServices.createToken(response.data['token']);
        await tokenServices.setUserType(userType);
        await tokenServices.setUserId(userId);
        await hiveServices.setProfile(profileImage);
        return userType;
      }
      return 'Invalid Account. Please check your credentials';
    } on DioException catch (ex) {
      if (ex.response != null) {
        error = 'An unexpcted error while calling api.';
      } else {
        error = "Network error occurred";
      }
    } catch (ex) {
      error = "An unexpected error occurred. Try to reapet the process.";
    }

    return error;
  }
}
