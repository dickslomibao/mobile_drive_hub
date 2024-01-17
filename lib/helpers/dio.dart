import 'package:dio/dio.dart';
import 'package:mobile_drive_hub/constant/url.dart';
import 'package:mobile_drive_hub/services/token_services.dart';

Dio dio(String token) {
  var dio = Dio(
    BaseOptions(
      baseUrl: API_URL,
      headers: {
        'accept': 'application/json',
        'content-type': 'application/json',
        'authorization': 'Bearer $token',
      },
      responseType: ResponseType.json,
    ),
  );

  return dio;
}
