import 'dart:convert';

import 'package:chat_bubbles/bubbles/bubble_special_three.dart';
import 'package:flutter/material.dart';
import 'package:mobile_drive_hub/constant/palette.dart';
import 'package:mobile_drive_hub/controllers/message/messages_controller.dart';
import 'package:mobile_drive_hub/model/conversation_model.dart';
import 'package:mobile_drive_hub/model/message_model.dart';
import 'package:provider/provider.dart';
import 'package:pusher_channels_flutter/pusher_channels_flutter.dart';

class MessagesListScreen extends StatefulWidget {
  const MessagesListScreen({super.key, required this.userId});
  final String userId;
  @override
  State<MessagesListScreen> createState() => _MessagesListScreenState();
}

class _MessagesListScreenState extends State<MessagesListScreen> {
  @override
  void initState() {
    super.initState();
    initData();
  }

  void initData() async {
    await context
        .read<MessagesController>()
        .getConversationMessages(userId: widget.userId);
  }

  String timeAgo(DateTime date) {
    Duration difference = DateTime.now().difference(date);
    int seconds = difference.inSeconds;

    int interval = (seconds / 31536000).floor();
    if (interval >= 1) {
      return '$interval y';
    }

    interval = (seconds / 2592000).floor();
    if (interval >= 1) {
      return '$interval mo';
    }

    interval = (seconds / 86400).floor();
    if (interval >= 1) {
      return '$interval d';
    }

    interval = (seconds / 3600).floor();
    if (interval >= 1) {
      return '$interval hr';
    }

    interval = (seconds / 60).floor();
    if (interval >= 1) {
      return '$interval m';
    }

    if (seconds < 10) {
      return 'now';
    }

    return '${seconds.floor()}s';
  }

  @override
  Widget build(BuildContext context) {
    final read = context.read<MessagesController>();
    final watch = context.watch<MessagesController>();

    return watch.isLoaded
        ? ListView.builder(
            reverse: true,
            itemCount: read.messages.length,
            itemBuilder: (context, index) {
              final m = read.messages[(read.messages.length - 1) - index];
              bool isSender = widget.userId != m.senderId;
              return BubbleSpecialThree(
                isSender: isSender,
                text: m.body,
                color: isSender ? primaryBg : Colors.grey.shade100,
                tail: false,
                textStyle: TextStyle(
                  color: isSender ? Colors.white : Colors.black87,
                  fontSize: 16,
                ),
              );
            },
          )
        : const Center(child: CircularProgressIndicator());
  }
}
