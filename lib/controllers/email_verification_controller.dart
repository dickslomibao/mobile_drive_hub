import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:mobile_drive_hub/services/email_verification_services.dart';

class EmailVerificationController extends ChangeNotifier {
  String dateExpired = "";
  String id = "";
  Future<String> sendVerificationEmail(String email) async {
    String error = "";
    try {
      final data =
          await emailVerificationServices.sendEmailVerification(email: email);
      if (data['code'] == 200) {
        id = data['id'].toString();
        print(id);
        dateExpired = data['date_expired'];
        error = 'success';
      } else {
        error = data['message'];
      }
    } on DioException catch (ex) {
      if (ex.response != null) {
        error = 'An unexpcted error while calling api.';
      } else {
        error = "Network error occurred.\nCheck your connection.";
      }
    } catch (ex) {
      error = "An unexpected error occurred. Try to reapet the process.";
    }
    return error;
  }
}
