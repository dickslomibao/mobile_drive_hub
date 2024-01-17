import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:mobile_drive_hub/services/school_services.dart';

class FilterDrivingSchoolController extends ChangeNotifier {
  bool isLoading = true;
  List<dynamic> schools = [];
  String error = "";
  Future<void> filterSchool(
    String name,
    double lat,
    double long,
    double startKm,
    double endKm,
    double rStart,
    double rEnd,
  ) async {
    error = "";
    try {
      Map<String, dynamic> data = await schoolServices.filterSchool(
        name,
        lat,
        long,
        startKm,
        endKm,
        rStart,
        rEnd,
      );
      schools = data['schools'];
      print(data);
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

  void distanceAsc() {
    schools.sort(
      (a, b) => a['distance'].compareTo(b['distance']),
    );
    notifyListeners();
  }

  void distanceDesc() {
    schools.sort(
      (a, b) => b['distance'].compareTo(a['distance']),
    );
    notifyListeners();
  }

  void ratingAsc() {
    schools.sort(
      (a, b) => a['rating'].compareTo(b['rating']),
    );
    notifyListeners();
  }

  void ratingDesc() {
    schools.sort(
      (a, b) => b['rating'].compareTo(a['rating']),
    );
    notifyListeners();
  }
  // void sortPrice(bool asc) {
  //   if (asc) {
  //     courses.sort((a, b) => a["min_price"].compareTo(b["min_price"]));
  //   } else {
  //     courses.sort((a, b) => b["min_price"].compareTo(a["min_price"]));
  //   }

  //   notifyListeners();
  // }
}
