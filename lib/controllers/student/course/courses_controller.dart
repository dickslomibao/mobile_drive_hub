import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:mobile_drive_hub/services/pusher_services.dart';

import '../../../services/mycourses_services.dart';

class CoursesController extends ChangeNotifier {
  bool isLoading = true;
  List<dynamic> courses = [];
  String error = "";

  List<dynamic> ongoing = [];
  List<dynamic> completed = [];
  List<dynamic> waiting = [];
  Future<void> getStudentCourses() async {
    error = "";
    try {
      ongoing = [];
      completed = [];
      Map<String, dynamic> data = await myCoursesServices.getStudentCourses();
      courses = data['courses'];
      for (var element in courses) {
        switch (element['mycourse.status']) {
          case 1:
            waiting.add(element);
            break;
          case 2:
            ongoing.add(element);
            break;
          case 3:
            completed.add(element);
            break;
          default:
        }
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
    isLoading = false;
    notifyListeners();
  }
}
