import 'package:mobile_drive_hub/services/token_services.dart';

import '../helpers/dio.dart';

class ReportServices {
  Future<Map<String, dynamic>> reportInstructor({
    required String scheduleId,
    required String instructorId,
    required String comments,
  }) async {
    String token = await tokenServices.getToken();
    final response = await dio(token).post(
      'student/report/instructor',
      data: {
        'schedule_id': scheduleId,
        'instructor_id': instructorId,
        'comments': comments,
      },
    );
    return response.data;
  }
}

ReportServices reportServices = ReportServices();
