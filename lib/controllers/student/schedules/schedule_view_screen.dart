import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:mobile_drive_hub/services/report_services.dart';
import 'package:mobile_drive_hub/services/schedules_services.dart';
import 'package:intl/intl.dart';

class StudentViewSchedulesController extends ChangeNotifier {
  bool isLoading = true;
  String scheduleId = "";
  Map<String, dynamic> schedule = {};
  String error = "";
  Future<void> getSingleStudentSchedule() async {
    error = "";
    try {
      final data =
          await schedulesServices.getStudentSchedulesWithId(scheduleId);
      if (data['code'] == 200) {
        schedule = data['schedule'];
      } else {
        error = data['message'];
      }
    } on DioException catch (ex) {
      debugPrint('$ex');
      if (ex.response != null) {
        error = 'An unexpcted error while calling api.';
      } else {
        error = "Network error occurred";
      }
    } catch (ex) {
      error = "An unexpected error occurred. Try to reapet the process.";
      debugPrint('$ex');
    }
    isLoading = false;
    notifyListeners();
  }

  Future<String> reportInsructor({
    required String scheduleId,
    required String instructorId,
    required String comments,
  }) async {
    String rError = "";
    try {
      final data = await reportServices.reportInstructor(
        scheduleId: scheduleId,
        instructorId: instructorId,
        comments: comments,
      );
      if (data['code'] == 200) {
        rError = "success";
      } else {
        rError = data['message'];
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

  String startDate() {
    if (schedule['logs'].length == 0) {
      return "";
    }
    Map<String, dynamic> s = schedule['logs']
        .singleWhere((element) => element['type'] == 1, orElse: () => {});
    return s.isEmpty
        ? ""
        : DateFormat('E - MMM d, yyyy  hh:mm a')
            .format(DateTime.parse(s['date_process'].toString()));
  }

  String endDate() {
    if (schedule['logs'].length == 0) {
      return "";
    }
    Map<String, dynamic> s = schedule['logs']
        .singleWhere((element) => element['type'] == 2, orElse: () => {});
    return s.isEmpty
        ? ""
        : DateFormat('E - MMM d, yyyy  hh:mm a')
            .format(DateTime.parse(s['date_process'].toString()));
  }

  Future<String> createReview(
    Map<String, dynamic> data,
  ) async {
    String rError = "";
    try {
      final result = await schedulesServices.reviewInstructor(data);
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

  // double studentProgressPercentage() {
  //   int check = 0;
  //   int count = 0;
  //   if (!schedule['students'][0].containsKey('progress')) {
  //     return 0;
  //   }
  //   for (var element in schedule['students'][0]['progress']) {
  //     for (var sub in element['sub_progress']) {
  //       ++count;
  //       if (sub['status'] == 2) {
  //         check++;
  //       }
  //     }
  //   }
  //   return check / count;
  // }
}
