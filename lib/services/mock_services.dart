import '../helpers/dio.dart';
import 'token_services.dart';

class MockServices {
  Future<dynamic> getStudentMockList(String orderListId) async {
    String token = await tokenServices.getToken();
    final response = await dio(token).post(
      'student/$orderListId/mockexam',
    );
    return response.data;
  }

  Future<dynamic> getStudentMockQuestions(String mockId) async {
    String token = await tokenServices.getToken();
    final response = await dio(token).post(
      'student/$mockId/mock_questions',
    );
    return response.data;
  }

  Future<dynamic> saveQuestionAnswer(String id, String answer) async {
    String token = await tokenServices.getToken();
    final response = await dio(token).post(
      'student/mock_questions/saveanswer',
      data: {
        'id': id,
        'answer': answer,
      },
    );

    return response.data;
  }

  Future<dynamic> submitAnswer(List<String> id, List<String> answer) async {
    String token = await tokenServices.getToken();
    final response = await dio(token).post(
      'student/mock_questions/submit',
      data: {
        'ids': id,
        'answers': answer,
      },
    );

    return response.data;
  }
}

MockServices mockServices = MockServices();
