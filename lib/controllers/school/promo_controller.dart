import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

import '../../services/promo_services.dart';

class PromoController extends ChangeNotifier {
  List<dynamic> promos = [];
  String error = "";
  bool isLoading = true;

  Future<void> getPromo(String schoolId) async {
    error = "";
    try {
      final result = await promoServices.getSchoolPromo(schoolId);
      promos = result['promos'];
    
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
}
