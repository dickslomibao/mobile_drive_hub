import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:mobile_drive_hub/services/mock_services.dart';

class MockQuizController extends ChangeNotifier {
  bool isLoading = true;
  List<dynamic> questions = [];
  String error = "";
  Future<void> getMockQuestions(String mockId) async {
    error = "";
    try {
      final data = await mockServices.getStudentMockQuestions(mockId);
      questions = data['questions'];
      print(questions);
    } on DioException catch (ex) {
      if (ex.response != null) {
        error = 'An unexpcted error while calling api.';
      } else {
        error = "Network error occurred.\nCheck your connection.";
      }
    } catch (ex) {
      error = "An unexpected error occurred. Try to reapet the process.";
    }
    isLoading = false;
    notifyListeners();
  }

  void saveAnswer(int questionId, int codeAnswer) {
    for (var i = 0; i < questions.length; i++) {
      if (questions[i]['question_id'] == questionId) {
        questions[i]['user_answer'] = codeAnswer;
        try {
          mockServices.saveQuestionAnswer(
              questions[i]['id'].toString(), codeAnswer.toString());
        } catch (e) {
          debugPrint('$e');
        }
        break;
      }
    }
    notifyListeners();
  }

  Future<String> submitAnswer() async {
    List<String> ids = [];
    List<String> answers = [];
    for (var i = 0; i < questions.length; i++) {
      ids.add(questions[i]['id'].toString());
      answers.add(questions[i]['user_answer'].toString());
    }
    String r = "success";
    try {
      final data = await mockServices.submitAnswer(ids, answers);
      // questions = data['questions'];
    } on DioException catch (ex) {
      if (ex.response != null) {
        error = 'An unexpcted error while calling api.';
      } else {
        error = "Network error occurred.\nCheck your connection.";
      }
    } catch (ex) {
      error = "An unexpected error occurred. Try to reapet the process.";
    }
    return r;
  }
}
