import 'package:mobile_drive_hub/services/token_services.dart';

import '../helpers/dio.dart';

class PromoServices {
  Future<dynamic> getSchoolPromo(String schoolId) async {
    String token = await tokenServices.getToken();
    final response = await dio(token).get(
      'school/$schoolId/promos',
    );
    return response.data;
  }
}



PromoServices promoServices = PromoServices();
