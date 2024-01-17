import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:mobile_drive_hub/services/profile_services.dart';

class StudentProfileController extends ChangeNotifier {
  bool isLoading = true;
  Map<String, dynamic> data = {};
  String error = "";

  Future<void> getStudentProfile() async {
    try {
      final response = await profileServices.getStudentProfile();
      if (response['code'] == 200) {
        data = response['data'];
        error = "success";
      } else {
        error = response['message'];
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
    isLoading = false;
    notifyListeners();
  }

  Future<String> changePassword(String oldPassword, String newPassword) async {
    String msg = "";
    try {
      final response =
          await profileServices.changePassword(oldPassword, newPassword);
      if (response['code'] == 200) {
        msg = "success";
      } else {
        msg = response['message'];
      }
    } on DioException catch (ex) {
      if (ex.response != null) {
        msg = 'An unexpcted error while calling api.';
      } else {
        msg = "Network error occurred";
      }
    } catch (ex) {
      msg = "An unexpected error occurred. Try to reapet the process.";
    }
    return msg;
  }

  Future<String> udpateInfo(Map<String, dynamic> data) async {
    String msg = "";
    try {
      final response = await profileServices.updateInfo(data);
      if (response['code'] == 200) {
        msg = "success";
      } else {
        msg = response['message'];
      }
    } on DioException catch (ex) {
      if (ex.response != null) {
        msg = 'An unexpcted error while calling api.';
      } else {
        msg = "Network error occurred";
      }
    } catch (ex) {
      msg = "An unexpected error occurred. Try to reapet the process.";
    }
    return msg;
  }

  Future<String> sendOtp(Map<String, dynamic> data) async {
    String msg = "";
    try {
      final response = await profileServices.sendOtp(data);
      if (response['code'] == 200) {
        msg = "success";
      } else {
        msg = response['message'];
      }
    } on DioException catch (ex) {
      if (ex.response != null) {
        msg = 'An unexpcted error while calling api.';
      } else {
        msg = "Network error occurred";
      }
    } catch (ex) {
      msg = "An unexpected error occurred. Try to reapet the process.";
    }
    return msg;
  }

  Future<String> updatePhoneNumber(Map<String, dynamic> data) async {
    String msg = "";
    try {
      final response = await profileServices.updatePhoneNumber(data);
      if (response['code'] == 200) {
        msg = "success";
      } else {
        msg = response['message'];
      }
    } on DioException catch (ex) {
      if (ex.response != null) {
        msg = 'An unexpcted error while calling api.';
      } else {
        msg = "Network error occurred";
      }
    } catch (ex) {
      msg = "An unexpected error occurred. Try to reapet the process.";
    }
    return msg;
  }
}
