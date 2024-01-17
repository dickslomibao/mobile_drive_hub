import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:mobile_drive_hub/services/geo_location.dart';
import 'package:mobile_drive_hub/services/schedules_services.dart';

class InstructorStartSchedulesController extends ChangeNotifier {
  bool isLoading = true;
  Map<String, dynamic> schedule = {};
  String error = "";
  void refresh() {
    isLoading = true;
    notifyListeners();
  }

  Duration? current;
  Future<String> startSchedule(String id, String mileage) async {
    error = "success";
    try {
      final data = await schedulesServices.startInstructorSchedule(id, mileage);
      schedule = data['schedule'];

      if (data['code'] == 200) {
        schedule = data['schedule'];
        geoLocationServices.streamPOsiton(
          (event) {
            schedulesServices.sendLocation(schedule['school_id'],
                schedule['id'].toString(), event.latitude, event.longitude);
          },
        );
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

  Future<String> checkProgress(String progresId) async {
    String r = "";
    try {
      final data = await schedulesServices.updateProgress(progresId);
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

  Future<String> scheduleReport(
      String scheduleId, String content, var images) async {
    String r = "";

    try {
      FormData formData = FormData();
      formData.fields.add(MapEntry('schedule_id', scheduleId));
      formData.fields.add(MapEntry('content', content));
      for (var image in images) {
        formData.files.add(
          MapEntry(
            'images[]',
            await MultipartFile.fromFile(image.path),
          ),
        );
      }
      final result = await schedulesServices.scheduleReport(formData);
      if (result['code'] == 200) {
        r = 'success';
      } else {
        r = result['message'];
      }
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

  Future<String> endSchedule(int hrs, int min, String mileage) async {
    String r = "";
    try {
      final data = await schedulesServices.endSession(
          schedule['id'].toString(), hrs, min, mileage);
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

  String getStartDate() {
    for (var element in schedule['logs']) {
      if (element['type'] == 1) {
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
