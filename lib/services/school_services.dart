import 'package:mobile_drive_hub/model/availed_course_model.dart';
import 'package:mobile_drive_hub/model/course_model.dart';
import 'package:mobile_drive_hub/services/token_services.dart';

import '../helpers/dio.dart';

class SchoolServices {
  Future<dynamic> filterSchool(
    String name,
    double lat,
    double long,
    double startKm,
    double endKm,
    double rStart,
    double rEnd,
  ) async {
    String token = await tokenServices.getToken();
    final data = {
      'name': name,
      'lat': lat,
      'long': long,
      'startKm': startKm,
      'endKm': endKm,
      'r_start': rStart,
      'r_end': rEnd,
    };
    final response = await dio(token).post(
      'retrieve/filltered_drivingschool',
      data: data,
    );

    return response.data;
  }

  Future<dynamic> getSchoolAbout(
    String schoolId,
  ) async {
    String token = await tokenServices.getToken();
    final response = await dio(token).get(
      '/retrieve/$schoolId/about',
    );
    return response.data;
  }

  Future<dynamic> getSchoolPolicy(
    String schoolId,
  ) async {
    String token = await tokenServices.getToken();
    final response = await dio(token).get(
      '/retrieve/$schoolId/policy',
    );
    return response.data;
  }

  Future<List<dynamic>> getSchoolReview(String schoolId) async {
    final response = await dio("").get(
      'retrieve/$schoolId/school/review',
    );
    return response.data['review'];
  }

  Future<dynamic> studentCreateSchoolReview(
    Map<String, dynamic> data,
  ) async {
    String token = await tokenServices.getToken();

    final response = await dio(token).post(
      'student/school/review',
      data: data,
    );
    return response.data;
  }
}

SchoolServices schoolServices = SchoolServices();
