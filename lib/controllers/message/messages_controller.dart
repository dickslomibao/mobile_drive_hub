import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:mobile_drive_hub/constant/url.dart';
import 'package:mobile_drive_hub/model/message_model.dart';
import 'package:mobile_drive_hub/services/token_services.dart';
import 'package:pusher_channels_flutter/pusher_channels_flutter.dart';

import '../../services/conversation_services.dart';
import '../../services/pusher_services.dart';

class MessagesController extends ChangeNotifier {
  String convoID = "";
  List<MessageModel> _messages = [];
  bool isLoaded = false;
  String error = "";
  List<MessageModel> get messages => _messages;

  Future<void> getConversationMessages({required String userId}) async {
    isLoaded = false;
    error = "";
    try {
      convoID = await conversationServices.getConvoId(userId);
      _messages =
          await conversationServices.getConverationMessages(convoId: convoID);
      await initPusher();
    } on DioException catch (ex) {
      print(ex.response);
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

  void addMessageFromEvent(Map<String, dynamic> data) {
    _messages.add(MessageModel.fromJson(data));
    notifyListeners();
  }

  Future<String> sendMessage({
    required String body,
  }) async {
    String error = "";
    try {
      final data =
          await conversationServices.sendMessage(convoId: convoID, body: body);
      print(data);
      error = 'Sent';
    } on DioException catch (ex) {
      if (ex.response != null) {
        error = 'An unexpcted error while calling api.';
      } else {
        error = "Network error occurred";
      }
    } catch (ex) {
      error = "An unexpected error occurred. Try to reapet the process.";
    }

    return error;
  }

  Future<void> initPusher() async {
    final temp = await pusherServices.getPusher();
    temp.subscribe(
      channelName: "private-message." + convoID,
      onEvent: (e) {
        if (e.eventName == "receive-message") {
          addMessageFromEvent(jsonDecode(e.data));
        }
      },
    );
  }
}
