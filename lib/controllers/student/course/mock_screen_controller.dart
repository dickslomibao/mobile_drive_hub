import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:mobile_drive_hub/services/mock_services.dart';

class GetMockListController extends ChangeNotifier {
  bool isLoading = true;
  List<dynamic> mocks = [];
  String error = "";
  String orderListId = "0";
  Future<void> getMockList() async {
    error = "";
    try {
      final data = await mockServices.getStudentMockList(orderListId);
      mocks = data['mock_list'];
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
}
