import '../helpers/dio.dart';

class EmailVerificationServices {
  Future<dynamic> sendEmailVerification({
    required String email,
  }) async {
    final response = await dio("").post(
      'email/send_verification',
      data: {
        'email': email,
      },
    );
    return response.data;
  }

  Future<dynamic> validateEmailUsername({
    required String email,
    required String username,
  }) async {
    final response = await dio("").post(
      'validate/email_username',
      data: {
        'email': email,
        'username': username,
      },
    );
    return response.data;
  }
}

EmailVerificationServices emailVerificationServices = EmailVerificationServices();
