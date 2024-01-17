import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:mobile_drive_hub/model/conversation_model.dart';
import 'package:mobile_drive_hub/services/conversation_services.dart';
import 'package:mobile_drive_hub/services/pusher_services.dart';
import 'package:pusher_channels_flutter/pusher_channels_flutter.dart';

import '../../constant/url.dart';

class ConversationController extends ChangeNotifier {
  List<dynamic> conversation = [];
  bool isLoaded = false;
  String error = "";
  Future<void> getConversation() async {
    isLoaded = false;
    error = "";
    try {
      final result = await conversationServices.getConversation();
      conversation = result['conversation'];
      for (var element in conversation) {
        initPusher(element['conversation_id']);
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
    isLoaded = true;
    notifyListeners();
  }

  void initPusher(String convoId) async {
    final temp = await pusherServices.getPusher();
    temp.subscribe(
      channelName: "private-message.${convoId}copy",
      onEvent: (e) {
        if (e.eventName == "receive-message") {
          for (var i = 0; i < conversation.length; i++) {
            if (conversation[i]['conversation_id'] == convoId) {
              conversation[i]['last_message'] = jsonDecode(e.data);
              conversation.sort((a, b) {
                DateTime dateA =
                    DateTime.parse(a['last_message']['date_created']);
                DateTime dateB =
                    DateTime.parse(b['last_message']['date_created']);
                return dateB.compareTo(dateA);
              });
              break;
            }
          }
          notifyListeners();
        }
      },
    );
  }
}
