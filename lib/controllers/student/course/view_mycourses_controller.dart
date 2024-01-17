import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:mobile_drive_hub/services/course_sevices.dart';

import '../../../services/mycourses_services.dart';

class ViewMyCoursesController extends ChangeNotifier {
  bool isLoading = true;
  Map<String, dynamic> course = {};
  String error = "";
  Future<void> getStudentSingleCourses(int id) async {
    error = "";
    try {
      Map<String, dynamic> data =
          await myCoursesServices.getStudentSingleCourses(id);
      course = data['mycourse'];
      print(course);
    } on DioException catch (ex) {
      if (ex.response != null) {
        error = 'An unexpcted error while calling api.';
      } else {
        error = "Network error occurred.\nCheck your connection.";
      }
    } catch (ex) {
      error = "An unexpected error occurred. Try to reapet the process.";
    }
    isLoading = false;
    notifyListeners();
  }

  void reload() {
    isLoading = true;
    notifyListeners();
  }

  double completedInPercent() {
    double r = (course['completed_hrs'] / course['info']['mycourse_duration']);

    return r > 1.0 ? 1.0 : r;
  }

  double studentProgressPercentage() {
    int check = 0;
    int count = 0;
    if (!course.containsKey('progress')) {
      return 0;
    }
    for (var element in course['progress']) {
      for (var sub in element['sub_progress']) {
        ++count;
        if (sub['status'] == 2) {
          check++;
        }
      }
    }
    return check / count;
  }

  Future<String> createReview(
    Map<String, dynamic> data,
  ) async {
    String rError = "";
    try {
      final result = await courseServices.studentReviewCourse(data);
      if (result['code'] == 200) {
        rError = "success";
      } else {
        rError = result['message'];
      }
      debugPrint(data['message'].toString());
    } on DioException catch (ex) {
      debugPrint('$ex');
      if (ex.response != null) {
        rError = 'An unexpcted error while calling api.';
      } else {
        rError = "Network error occurred";
      }
    } catch (ex) {
      debugPrint('$ex');
      rError = "An unexpected error occurred. Try to reapet the process.";
    }
    return rError;
  }
}
