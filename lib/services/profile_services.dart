import 'package:mobile_drive_hub/services/token_services.dart';

import '../helpers/dio.dart';

class ProfileServices {
  Future<dynamic> getStudentProfile() async {
    String token = await tokenServices.getToken();
    final response = await dio(token).post(
      'student/profile',
    );
    return response.data;
  }

  Future<dynamic> getInstructorProfile() async {
    String token = await tokenServices.getToken();
    final response = await dio(token).post(
      'instructor/profile',
    );
    return response.data;
  }

  Future<dynamic> changePassword(String oldPassword, String newPassword) async {
    String token = await tokenServices.getToken();
    final response = await dio(token).post(
      data: {
        'old_password': oldPassword,
        'password': newPassword,
      },
      'student/profile/changepassword',
    );
    return response.data;
  }

  Future<dynamic> updateInfo(Map<String, dynamic> data) async {
    String token = await tokenServices.getToken();
    final response = await dio(token).post(
      data: data,
      'student/profile/updateinfo',
    );
    return response.data;
  }

  Future<dynamic> updateInstructorInfo(Map<String, dynamic> data) async {
    String token = await tokenServices.getToken();
    final response = await dio(token).post(
      data: data,
      'instructor/profile/save',
    );
    return response.data;
  }

  Future<dynamic> sendOtp(Map<String, dynamic> data) async {
    String token = await tokenServices.getToken();
    final response = await dio(token).post(
      data: data,
      'student/profile/sendotp',
    );
    return response.data;
  }

  Future<dynamic> updatePhoneNumber(Map<String, dynamic> data) async {
    String token = await tokenServices.getToken();
    final response = await dio(token).post(
      data: data,
      'student/profile/updatenumber',
    );
    return response.data;
  }
}

ProfileServices profileServices = ProfileServices();
