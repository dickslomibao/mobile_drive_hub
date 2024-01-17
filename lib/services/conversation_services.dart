import 'package:mobile_drive_hub/helpers/dio.dart';
import 'package:mobile_drive_hub/model/conversation_model.dart';
import 'package:mobile_drive_hub/model/message_model.dart';
import 'package:mobile_drive_hub/services/token_services.dart';

class ConversationServices {
  Future<dynamic> getConversation() async {
    final token = await tokenServices.getToken();
    final response = await dio(token).post('conversation/retrieve');
    return response.data;
  }

  Future<String> getConvoId(String userId) async {
    final token = await tokenServices.getToken();
    final response = await dio(token).post('conversation/getconvoid', data: {
      'user_id': userId,
    });
    return response.data['id'];
  }

  Future<List<MessageModel>> getConverationMessages({
    required String convoId,
  }) async {
    final token = await tokenServices.getToken();
    final response = await dio(token).post('messages/$convoId/retrieve');

    if (response.data['code'] == 200) {
      List<dynamic> conversation = response.data['messages'];
      return conversation.map((e) => MessageModel.fromJson(e)).toList();
    }
    return [];
  }

  Future<dynamic> sendMessage(
      {required String convoId, required String body}) async {
    final token = await tokenServices.getToken();
    final response = dio(token).post(
      'messages/$convoId/sendmessage',
      data: {'body': body, 'conversation_id': convoId},
    );
    return response;
  }
}

ConversationServices conversationServices = ConversationServices();
