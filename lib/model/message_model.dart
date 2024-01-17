class MessageModel {
  final int id;
  final String conversationId;
  final String senderId;
  final String body;
  final int type;
  final String dateCreated;
  MessageModel({
    required this.id,
    required this.conversationId,
    required this.senderId,
    required this.body,
    required this.type,
    required this.dateCreated,
  });
  factory MessageModel.fromJson(Map<String, dynamic> json) {
    return MessageModel(
      id: json['id'],
      conversationId: json['conversation_id'],
      body: json['body'],
      dateCreated: json['date_created'],
      senderId: json['sender_id'],
      type: json['type'],
    );
  }
  // Map<String, dynamic> toJson() {
  //   return {
  //     'id': id,
  //     'school_id': schoolId,
  //     'name': name,
  //     'duration': duration,
  //     'price': price,
  //     'thumbnail': thumbnail,
  //     'status': status,
  //     'date_created': dateCreated,
  //     'date_updated': dateUpdated,
  //   };
  // }
}
