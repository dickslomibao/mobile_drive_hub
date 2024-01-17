import 'dart:math';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:mobile_drive_hub/services/schedules_services.dart';

class ViewStudentProgress extends ChangeNotifier {
  bool isLoading = true;
  Map<String, dynamic> student = {};
  List<dynamic> progress = [];
  String error = "";

  void refresh() {
    isLoading = true;
    notifyListeners();
  }

  Future<void> viewStudentProgress(String studentId, int orderListId) async {
    error = "";
    try {
      final data =
          await schedulesServices.viewStudentProgress(studentId, orderListId);
      student = data['student'];
      progress = student['progress'];
      print(studentProgressPercentage());
    } on DioException catch (ex) {
      if (ex.response != null) {
        error = 'An unexpcted error while calling api.';
      } else {
        error = "Network error occurred";
      }
    } catch (ex) {
      debugPrint("$ex");
      error = "An unexpected error occurred. Try to reapet the process.";
    }

    isLoading = false;
    notifyListeners();
  }

  Future<String> updateProgress(String progressId) async {
    String msg = "success";
    try {
      final data = await schedulesServices.updateProgress(
        progressId,
      );
    } on DioException catch (ex) {
      if (ex.response != null) {
        msg = 'An unexpcted error while calling api.';
      } else {
        msg = "Network error occurred";
      }
    } catch (ex) {
      debugPrint("$ex");
      msg = "An unexpected error occurred. Try to reapet the process.";
    }
    return msg;
  }

  double studentProgressPercentage() {
    int check = 0;
    int count = 0;
    for (var element in progress) {
      for (var sub in element['sub_progress']) {
        ++count;
        if (sub['status'] == 2) {
          check++;
        }
      }
    }
    return check / count;
  }
}
