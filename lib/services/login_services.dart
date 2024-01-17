import '../helpers/dio.dart';

class LoginServices {
  Future<dynamic> login({
    required String usernameEmail,
    required String password,
    required String deviceName,
  }) async {
    return await dio("").post(
      'login',
      data: {
        'username_email': usernameEmail,
        'password': password,
        'device_name': deviceName,
      },
    );
  }
}

LoginServices loginServices = LoginServices();
