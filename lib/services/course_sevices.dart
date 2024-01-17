import 'package:mobile_drive_hub/model/availed_course_model.dart';
import 'package:mobile_drive_hub/model/course_model.dart';
import 'package:mobile_drive_hub/services/token_services.dart';

import '../helpers/dio.dart';

class CourseServices {
  Future<List<CourseModel>> getSchoolCourses(String schoolId) async {
    final response = await dio("").post(
      'retrieve/school/courses',
      data: {
        'school_id': schoolId,
      },
    );
    List<dynamic> courses = response.data['courses'];
    return courses.map((coursesJson) {
      return CourseModel.fromJson(coursesJson);
    }).toList();
  }

  Future<List<dynamic>> getCourseReview(String courseId) async {
    final response = await dio("").get(
      'retrieve/$courseId/courses/review',
    );
    return response.data['review'];
  }

  Future<dynamic> geDrivingSchoolSingleCourse(
      {required String courseId}) async {
    String token = await tokenServices.getToken();
    final response = await dio(token).post(
      'retrieve/$courseId/courses',
    );
    return response.data;
  }

  Future<dynamic> filterCourses(
    String name,
    List<String> type,
    int priceStart,
    int priceEnd,
    double lat,
    double long,
    double rStart,
    double rEnd,
  ) async {
    String token = await tokenServices.getToken();
    final data = {
      'name': name,
      'type': type,
      'price_start': priceStart,
      'price_end': priceEnd,
      'lat': lat,
      'long': long,
      'r_start': rStart,
      'r_end': rEnd,
    };
    final response = await dio(token).post(
      'retrieve/filltered_courses',
      data: data,
    );
    return response.data;
  }

  Future<dynamic> studentReviewCourse(
    Map<String, dynamic> data,
  ) async {
    String token = await tokenServices.getToken();

    final response = await dio(token).post(
      'student/course/review',
      data: data,
    );
    return response.data;
  }
}

CourseServices courseServices = CourseServices();
