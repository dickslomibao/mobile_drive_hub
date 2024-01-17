import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

import '../../../services/schedules_services.dart';

class StudentSchedulesController extends ChangeNotifier {
  bool isLoading = true;
  List<dynamic> schedules = [];
  String error = "";
  List<dynamic> incoming = [];
  List<dynamic> ongoing = [];
  List<dynamic> completed = [];

  Future<void> getStudentSchedules() async {
    error = "";
    try {
      incoming.clear();
      ongoing.clear();
      completed.clear();
      Map<String, dynamic> data = await schedulesServices.getStudentSchedules();
      schedules = data['schedules'];
      // print(schedules);
      // for (var d in schedules) {
      //   for (var s in d['schedules_list']) {
      //     if (s['status'] == 1) {
      //       incoming.add(d);
      //     }
      //     if (s['status'] == 2) {
      //       ongoing.add(d);
      //     }
      //     if (s['status'] == 3) {
      //       completed.add(d);
      //     }
      //   }
      // }
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
}
