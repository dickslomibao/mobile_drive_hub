import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:mobile_drive_hub/services/register_services.dart';
import 'package:mobile_drive_hub/services/token_services.dart';

import '../../../services/hive_services.dart';

class RegisterController extends ChangeNotifier {
  DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
  String firstname = "";
  String vId = "";
  String code = "";
  String username = "";
  String lastname = "";
  String email = "";
  String password = "";
  File? profileimage;
  Future<String> createAccount() async {
    String error = "";
    AndroidDeviceInfo androidInfo = await deviceInfo.androidInfo;
    try {
      final response = await registerServices.createAccount(
        firstname: firstname,
        lastname: lastname,
        username: username,
        email: email,
        password: password,
        deviceName: androidInfo.model,
        profile: profileimage!,
        code: code,
        vId: vId,
      );
      if (response.data['code'] == 200) {
        String userType = response.data['user']['type'].toString();
        String userId = response.data['user']['id'].toString();
        String profileImage = response.data['user']['profile_image'].toString();
        // print(response.data['token']);
        // print(profileImage);
        await tokenServices.createToken(response.data['token']);
        await tokenServices.setUserType(userType);
        await tokenServices.setUserId(userId);
        await hiveServices.setProfile(profileImage);
        return 'success';
      } else {
        return response.data['message'];
      }
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

  void profileChange(File file) {
    profileimage = file;
    notifyListeners();
  }
}
