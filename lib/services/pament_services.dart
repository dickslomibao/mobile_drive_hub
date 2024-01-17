import 'package:mobile_drive_hub/services/token_services.dart';

import '../helpers/dio.dart';

class PaymentServices {
  Future<double?> totalPaidForCash(String orderId) async {
    String token = await tokenServices.getToken();
    final response = await dio(token).post(
      'availed/courses/student/totalpaid',
      data: {
        'order_id': orderId,
      },
    );
    return double.parse(response.data['amount'].toString());
  }
}

PaymentServices paymentServices = PaymentServices();
