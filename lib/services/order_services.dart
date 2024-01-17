import '../helpers/dio.dart';
import 'token_services.dart';

class OrderServices {
  Future<dynamic> createOrder(
    String? promoId,
    String schoolId,
    List<String> courses,
    List<String> variant,
    String paymentType,
  ) async {
    String token = await tokenServices.getToken();
    final data = {
      'school_id': schoolId,
      'courses': courses,
      'variants': variant,
      'payment_type': paymentType,
    };
    if (promoId != null) {
      data['promo_id'] = promoId;
    }
    final response = await dio(token).post(
      'student/createorder',
      data: data,
    );
    return response.data;
  }

  Future<dynamic> getStudentOrder() async {
    String token = await tokenServices.getToken();
    final response = await dio(token).post(
      'student/getorders',
    );
    return response.data;
  }
}

OrderServices orderServices = OrderServices();
