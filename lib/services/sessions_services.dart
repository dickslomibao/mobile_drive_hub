import 'package:mobile_drive_hub/services/token_services.dart';

import '../helpers/dio.dart';

class SessionServices {
  Future<List<dynamic>?> getCourseSessions(
      {required String orderId, required String schoolId}) async {
    String token = await tokenServices.getToken();
    final response = await dio(token).post(
      '/availed/courses/student/singleorder/sessions',
      data: {
        'order_id': orderId,
        'school_id': schoolId,
      },
    );
    return response.data['sessions'];
  }
}

SessionServices sessionServices = SessionServices();
