import 'package:flutter/material.dart';
import 'package:mobile_drive_hub/constant/palette.dart';

import 'widgets/conversation_list_widget.dart';

class ConversationScreen extends StatefulWidget {
  const ConversationScreen({super.key});

  @override
  State<ConversationScreen> createState() => _ConversationScreenState();
}

class _ConversationScreenState extends State<ConversationScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Messages',
                style: TextStyle(
                  fontSize: 27,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Container(
                height: 52,
                decoration: BoxDecoration(
                  color: backgroundMainColor,
                  borderRadius: BorderRadius.circular(10),
                ),
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: const TextField(
                  textAlignVertical: TextAlignVertical.center,
                  style: TextStyle(
                    fontSize: 17,
                    fontWeight: FontWeight.w500,
                  ),
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText: 'Search Conversation...',
                  ),
                ),
              ),
              const SizedBox(
                height: 25,
              ),
              const Expanded(
                child: ConversationWidget(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
