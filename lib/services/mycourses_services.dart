import 'package:mobile_drive_hub/services/pusher_services.dart';
import 'package:mobile_drive_hub/services/token_services.dart';

import '../helpers/dio.dart';

class MyCoursesServices {
  Future<Map<String, dynamic>> getStudentCourses() async {
    String token = await tokenServices.getToken();
    await pusherServices.init(token: token);
    final response = await dio(token).post('student/getcourses');
    return response.data;
  }

  Future<Map<String, dynamic>> getStudentSingleCourses(int id) async {
    String token = await tokenServices.getToken();
    final response = await dio(token).post('student/$id/getcourse');
    return response.data;
  }
}

MyCoursesServices myCoursesServices = MyCoursesServices();
