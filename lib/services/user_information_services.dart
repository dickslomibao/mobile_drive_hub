// import 'package:mobile_drive_hub/constant/user_type.dart';
// import 'package:mobile_drive_hub/services/token_services.dart';

// import '../helpers/dio.dart';

// class UserInformationServices {
//   Future<Map<String, dynamic>> getInformation({
//     required String userId,
//     required UserType type,
//   }) async {
//     String token = await tokenServices.getToken();
//     final response = await dio(token).post('user/info', data: {
//       'user_id': userId,
//       'user_type': toTypeInt(type),
//     });
//     return response.data;
//   }
//   String name(Map<String, dynamic> data, UserType type) {
//     String name = "";
//     if (type == UserType.school) {
//       return data['name'];
//     }
//     return name;
//   }
// }

// UserInformationServices userInformationServices = UserInformationServices();
