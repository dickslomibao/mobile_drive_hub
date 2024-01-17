import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:mobile_drive_hub/services/schedules_services.dart';

class InstructorViewSchedulesController extends ChangeNotifier {
  bool isLoading = true;
  Map<String, dynamic> schedule = {};

  String error = "";
  void refresh() {
    isLoading = true;
    notifyListeners();
  }

  Duration? current;

  Future<String> startSchedule(
    String id,
  ) async {
    error = "success";
    try {
      final data = await schedulesServices.startInstructorSchedule(id, "");

      if (data['code'] == 200) {
        schedule = data['schedule'];
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
    isLoading = false;
    notifyListeners();
    return error;
  }

  Future<String> createMockExam(int itemCount, int mockCount) async {
    List<String> list = [];
    for (var s in schedule['students']) {
      list.add(s['order_list_id'].toString());
    }
    String c = "success";
    try {
      final d = await schedulesServices.createMockExam(
        list,
        itemCount,
        mockCount,
      );
      if (d['code'] != 200) {
        c = d['message'];
      }
    } on DioException catch (ex) {
      if (ex.response != null) {
        c = 'An unexpcted error while calling api.';
      } else {
        c = "Network error occurred";
      }
    } catch (ex) {
      c = "An unexpected error occurred. Try to reapet the process.";
    }
    return c;
  }

  Future<String> endScheduleT(int hrs, int min) async {
    String r = "";
    try {
      final data = await schedulesServices.endSession(
          schedule['id'].toString(), hrs, min, "");
      if (data['code'] == 200) {
        r = 'success';
      } else {
        r = data['message'];
      }
      debugPrint("$data");
    } on DioException catch (ex) {
      if (ex.response != null) {
        r = 'An unexpcted error while calling api.';
      } else {
        r = "Network error occurred";
      }
    } catch (ex) {
      debugPrint("$ex");
      r = "An unexpected error occurred. Try to reapet the process. ";
    }
    return r;
  }

  Future<void> getSingleInstructorSchedule(String id) async {
    error = "";
    try {
      final data = await schedulesServices.getInstructorSchedulesWithId(id);
      schedule = data['schedule'];
    } on DioException catch (ex) {
      if (ex.response != null) {
        error = 'An unexpcted error while calling api.';
      } else {
        error = "Network error occurred";
      }
    } catch (ex) {
      error = "An unexpected error occurred. Try to reapet the process.";
    }
    isLoading = false;
    notifyListeners();
  }

  double studentProgressPercentage() {
    int check = 0;
    int count = 0;
    if (!schedule['students'][0].containsKey('progress')) {
      return 0;
    }
    for (var element in schedule['students'][0]['progress']) {
      for (var sub in element['sub_progress']) {
        ++count;
        if (sub['status'] == 2) {
          check++;
        }
      }
    }
    return check / count;
  }

  String getStartDate() {
    for (var element in schedule['logs']) {
      if (element['type'] == 1) {
        return element['date_process'];
      }
    }
    return "";
  }

  String getEndDate() {
    for (var element in schedule['logs']) {
      if (element['type'] == 2) {
        return element['date_process'];
      }
    }
    return "";
  }

  Map<String, dynamic> consumeHours() {
    return {
      'hrs': current!.inHours,
      'min': current!.inMinutes % 60,
    };
  }
}
