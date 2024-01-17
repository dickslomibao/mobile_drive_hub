import 'package:mobile_drive_hub/constant/url.dart';
import 'package:mobile_drive_hub/constant/user_type.dart';

class ConversationModel {
  final String id;
  final String userId;
  final String profilePicture;
  final UserType userType;
  final String name;
  ConversationModel({
    required this.id,
    required this.userId,
    required this.profilePicture,
    required this.userType,
    required this.name,
  });
  
  factory ConversationModel.fromJson(Map<String, dynamic> json) {
    return ConversationModel(
      id: json['conversation_id'],
      userId: json['user_id'],
      profilePicture: WEBSITE_URL + json['profile_image'],
      userType: toTypeEnum(json['type']),
      name: json['name'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'conversation_id': id,
      'user_id': userId,
    };
  }
}
