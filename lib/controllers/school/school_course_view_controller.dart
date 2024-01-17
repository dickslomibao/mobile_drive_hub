import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:mobile_drive_hub/services/course_sevices.dart';

import '../../model/course_model.dart';
import '../../model/driving_school_model.dart';

class SchoolCourseViewController extends ChangeNotifier {
  String error = "";
  bool isLoading = true;
  CourseModel? courseModel;
  DrivingSchoolModel? drivingSchoolModel;
  Future<void> getSingleCourse(String courseId) async {
    error = "";
    try {
      print("asad");
      final data =
          await courseServices.geDrivingSchoolSingleCourse(courseId: courseId);
      if (data['code'] == 200) {
        courseModel = CourseModel.fromJson(data['course']);
        drivingSchoolModel =
            DrivingSchoolModel.fromJson(data['course']['schools']);
      } else {
        error = data['message'];
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
    print(error);
    isLoading = false;
    notifyListeners();
  }
}
