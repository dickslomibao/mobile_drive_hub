import '../helpers/dio.dart';
import 'token_services.dart';

class StudentServices {
  Future<dynamic> create({
    required String token,
    required Map<String, dynamic> data,
  }) async {
    return await dio(token).post('createstudent', data: data);
  }

  Future<dynamic> checkIfAlreadyRegistered({
    required Map<String, dynamic> data,
  }) async {
    final token = await tokenServices.getToken();
    return await dio(token)
        .post('alreadyRegisteredInDrivingSchool', data: data);
  }
}

StudentServices studentServices = StudentServices();
