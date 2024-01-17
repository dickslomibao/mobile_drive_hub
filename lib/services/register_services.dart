import 'dart:io';

import 'package:dio/dio.dart';

import '../helpers/dio.dart';

class RegisterServices {
  Future<dynamic> createAccount({
    required String firstname,
    required String lastname,
    required String username,
    required String email,
    required String password,
    required String deviceName,
    required File profile,
    required String vId,
    required String code,
  }) async {
    var formData = FormData.fromMap({
      'firstname': firstname,
      'lastname': lastname,
      'username': username,
      'email': email,
      'password': password,
      'device_name': deviceName,
      'v_id': vId,
      'code': code,
      'image':
          await MultipartFile.fromFile(profile.path, filename: profile.path),
    });
    return await dio("").post(
      'register',
      data: formData,
    );
  }
}

RegisterServices registerServices = RegisterServices();
