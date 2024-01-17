import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:mobile_drive_hub/services/order_services.dart';
import 'dart:convert';
import 'dart:developer' as developer;

import 'package:mobile_drive_hub/services/school_services.dart';

class OrderController extends ChangeNotifier {
  List<dynamic> orders = [];

  bool isLoading = true;
  String url = "";
  String error = "";
  Future<String> createOrder(String? promoId, String schoolId,
      List<String> courses, List<String> v, String paymentType) async {
    try {
      final data = await orderServices.createOrder(
          promoId, schoolId, courses, v, paymentType);

      if (data['code'] == 200) {
        url = data['url'];
        notifyListeners();
        return 'success';
      } else {
        return data['message'];
      }
    } on DioException catch (ex) {
      if (ex.response != null) {
        return 'An unexpcted error while calling api.';
      } else {
        return "Network error occurred. Please check your internet connection.";
      }
    } catch (ex) {
      return "An unexpected error occurred. Try to repeat the process.";
    }
  }

  void refresh(Map<String, dynamic> data) {
    print(data);
    for (var i = 0; i < orders.length; i++) {
      if (orders[i]['order']['id'] == data['order']['id']) {
        orders[i] = data;
        break;
      }
    }

    notifyListeners();
  }

  Future<void> getStudentOrders() async {
    try {
      final response = await orderServices.getStudentOrder();
      print(response);
      if (response['code'] == 200) {
        orders = response['orders'];
      } else {
        error = "An unexpected error occurred. Try to reapet the process.";
      }
    } on DioException catch (ex) {
      if (ex.response != null) {
        error = 'An unexpcted error while calling api.';
      } else {
        error = "Network error occurred";
      }
    } catch (ex) {
      error = "An unexpected error occurred. Try to reapet the process.";
    }
    isLoading = false;
    notifyListeners();
  }

  Map<String, dynamic> getSingleOrder(String orderId) {
    return orders.singleWhere(
      (element) => element['order']['id'] == orderId,
      orElse: () => {},
    );
  }

  Future<String> createReview(
    Map<String, dynamic> data,
  ) async {
    String rError = "";
    try {
      final result = await schoolServices.studentCreateSchoolReview(data);
      if (result['code'] == 200) {
        rError = "success";
      } else {
        rError = result['message'];
      }
      debugPrint(data['message'].toString());
    } on DioException catch (ex) {
      debugPrint('$ex');
      if (ex.response != null) {
        rError = 'An unexpcted error while calling api.';
      } else {
        rError = "Network error occurred";
      }
    } catch (ex) {
      debugPrint('$ex');
      rError = "An unexpected error occurred. Try to reapet the process.";
    }
    return rError;
  }
}
