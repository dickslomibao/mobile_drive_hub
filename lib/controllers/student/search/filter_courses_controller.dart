import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:mobile_drive_hub/services/course_sevices.dart';

import '../../../services/geo_location.dart';
import '../../../services/mycourses_services.dart';

class FilterCoursesController extends ChangeNotifier {
  bool isLoading = true;
  List<dynamic> courses = [];
  String error = "";
  Future<void> filterCourses(
    String name,
    List<String> type,
    int priceStart,
    int priceEnd,
    double rStart,
    double rEnd,
  ) async {
    error = "";
    try {
      final position = await geoLocationServices.getPosition();
      Map<String, dynamic> data = await courseServices.filterCourses(
        name,
        type,
        priceStart,
        priceEnd,
        position.latitude,
        position.longitude,
        rStart,
        rEnd,
      );
      courses = data['courses'];
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

  void sortPrice(bool asc) {
    if (asc) {
      courses.sort((a, b) => a["min_price"].compareTo(b["min_price"]));
    } else {
      courses.sort((a, b) => b["min_price"].compareTo(a["min_price"]));
    }

    notifyListeners();
  }

  void sortRating(bool asc) {
    if (asc) {
      courses.sort((a, b) => a["rating"].compareTo(b["rating"]));
    } else {
      courses.sort((a, b) => b["rating"].compareTo(a["rating"]));
    }

    notifyListeners();
  }

  void sortDistance(bool asc) {
    if (asc) {
      courses.sort((a, b) => a["distance"].compareTo(b["distance"]));
    } else {
      courses.sort((a, b) => b["distance"].compareTo(a["distance"]));
    }

    notifyListeners();
  }
}
