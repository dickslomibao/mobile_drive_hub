import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:mobile_drive_hub/services/pusher_services.dart';

import '../../services/schedules_services.dart';

class InstructorScheduleController extends ChangeNotifier {
  bool isLoading = true;
  List<dynamic> schedules = [];

  String error = "";

  Future<void> getInstructorSchedules() async {
    error = "";
    try {
      Map<String, dynamic> data =
          await schedulesServices.getInstructorsSchedules();
      schedules = data['schedules'];
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

  List<dynamic> getIncoming() {
    List<dynamic> originalSchedules = List.from(schedules);

    List<dynamic> t = [];

    for (Map<String, dynamic> originalData in originalSchedules) {
      Map<String, dynamic> data = Map.from(originalData);

      List<dynamic> temp = [];
      for (Map element in data['schedules_list']) {
        if (element['status'] == 1) {
          temp.add(element);
        }
      }
      if (temp.isNotEmpty) {
        data['schedules_list'] = List.from(temp);
        t.add(data);
      }
    }
    return t;
  }

  List<dynamic> getOngoing() {
    List<dynamic> originalSchedules = List.from(schedules);

    List<dynamic> t = [];

    for (Map<String, dynamic> originalData in originalSchedules) {
      Map<String, dynamic> data = Map.from(originalData);

      List<dynamic> temp = [];
      for (Map element in data['schedules_list']) {
        if (element['status'] == 2) {
          temp.add(element);
        }
      }
      if (temp.isNotEmpty) {
        data['schedules_list'] = List.from(temp);
        t.add(data);
      }
    }
    return t;
  }

  List<dynamic> getCompleted() {
    List<dynamic> originalSchedules = List.from(schedules);

    List<dynamic> t = [];

    for (Map<String, dynamic> originalData in originalSchedules) {
      Map<String, dynamic> data = Map.from(originalData);

      List<dynamic> temp = [];
      for (Map element in data['schedules_list']) {
        if (element['status'] == 3) {
          temp.add(element);
        }
      }
      if (temp.isNotEmpty) {
        data['schedules_list'] = List.from(temp);
        t.add(data);
      }
    }
    return t;
  }

  // Map<dynamic, dynamic> getSingleSchedule(int scheduleId) {
  //   Map<dynamic, dynamic> sched = {};
  //   for (var element in schedules) {
  //     sched = element['schedules_list']
  //         .singleWhere((e) => e['id'] == scheduleId, orElse: () => {});
  //   }
  //   return sched;
  // }
}
