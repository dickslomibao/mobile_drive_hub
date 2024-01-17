import 'package:mobile_drive_hub/services/promo_services.dart';
import 'package:mobile_drive_hub/services/pusher_services.dart';
import 'package:mobile_drive_hub/services/token_services.dart';

import '../helpers/dio.dart';

class SchedulesServices {
  Future<List<dynamic>> getInstructorSchedules() async {
    String token = await tokenServices.getToken();

    final response = await dio(token).post('instructor/schedules');
    return response.data;
  }

  Future<Map<String, dynamic>> getInstructorSchedulesWithId(String id) async {
    String token = await tokenServices.getToken();
    final response = await dio(token).post('instructor/$id/getschedule');
    return response.data;
  }

  Future<Map<String, dynamic>> startInstructorSchedule(
      String id, String startMilage) async {
    String token = await tokenServices.getToken();
    final response = await dio(token).post('instructor/$id/startschedule',
        data: {'start_mileage': startMilage});
    return response.data;
  }

  Future<Map<String, dynamic>> getStudentSchedules() async {
    String token = await tokenServices.getToken();
    final response = await dio(token).post('student/getschedules');
    return response.data;
  }

  Future<Map<String, dynamic>> getInstructorsSchedules() async {
    String token = await tokenServices.getToken();

    await pusherServices.init(token: token);

    final response = await dio(token).post('instructor/getschedules');
    return response.data;
  }

  Future<Map<String, dynamic>> sendLocation(
      String schoolId, String id, double lat, double long) async {
    String token = await tokenServices.getToken();

    final response = await dio(token).post(
      'instructor/sendlocation',
      data: {
        'school_id': schoolId,
        'schedule_id': id,
        "latitude": lat,
        "longtitude": long,
      },
    );

    return response.data;
  }

  Future<Map<String, dynamic>> viewStudentProgress(
      String studentId, int orderListId) async {
    String token = await tokenServices.getToken();

    final response = await dio(token).post(
      'instructor/session/studentprogress',
      data: {
        'student_id': studentId,
        'order_list_id': orderListId,
      },
    );
    return response.data;
  }

  Future<Map<String, dynamic>> updateProgress(String progressId) async {
    String token = await tokenServices.getToken();

    final response = await dio(token).post(
      'instructor/session/updateprogress',
      data: {
        'progress_id': progressId,
      },
    );
    return response.data;
  }

  Future<Map<String, dynamic>> createMockExam(
      List<String> orderListId, int itemCount, int mockCount) async {
    String token = await tokenServices.getToken();

    final response = await dio(token).post(
      'instructor/create/mockexam',
      data: {
        'order_list_id': orderListId,
        'item_count': itemCount,
        'mock_count': mockCount,
      },
    );

    return response.data;
  }

  Future<Map<String, dynamic>> endSession(
      String scheduleId, int hrs, int min, String mileage) async {
    String token = await tokenServices.getToken();
    final response = await dio(token).post(
      'instructor/endsession',
      data: {
        'schedule_id': scheduleId,
        'hrs': hrs,
        'min': min,
        'end_mileage': mileage,
      },
    );
    return response.data;
  }

  Future<Map<String, dynamic>> getStudentSchedulesWithId(String id) async {
    String token = await tokenServices.getToken();
    final response = await dio(token).post('student/$id/getschedules');
    return response.data;
  }

  Future<dynamic> reviewInstructor(
    Map<String, dynamic> data,
  ) async {
    String token = await tokenServices.getToken();

    final response = await dio(token).post(
      'student/reviewinstructor',
      data: data,
    );
    return response.data;
  }

  Future<dynamic> scheduleReport(
    var data,
  ) async {
    String token = await tokenServices.getToken();

    final response = await dio(token).post(
      'instructor/report',
      data: data,
    );
    return response.data;
  }
}

SchedulesServices schedulesServices = SchedulesServices();
