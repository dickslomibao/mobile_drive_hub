import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:mobile_drive_hub/services/student_services.dart';
import 'package:mobile_drive_hub/services/token_services.dart';

class StudentController extends ChangeNotifier {
  Future<String> createStudent(Map<String, dynamic> data) async {
    String message = "";
    String token = await tokenServices.getToken();
    try {
      await studentServices.create(token: token, data: data);
      message = 'success';
    } on DioException catch (ex) {
      if (ex.response != null) {
        message = 'An unexpcted error while calling api. ${ex.message}';
      } else {
        message = "Network error occurred";
      }
    } catch (ex) {
      message = "An unexpected error occurred. Try to reapet the process.";
    }
    return message;
  }

  Future<String> checkIfAlreadyRegistered(String schoolId) async {
    String message = "not-yet";

    try {
      final isRegistered =
          await studentServices.checkIfAlreadyRegistered(data: {
        'school_id': schoolId,
      });
      if (isRegistered.data['exist']) {
        message = 'registered';
      }
    } on DioException catch (ex) {
      if (ex.response != null) {
        message = 'An unexpcted error while calling api.';
      } else {
        message = "Network error occurred";
      }
    } catch (ex) {
      message = "An unexpected error occurred. Try to reapet the process.";
    }
    return message;
  }
}
