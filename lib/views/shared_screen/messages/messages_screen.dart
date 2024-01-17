import 'package:flutter/material.dart';
import 'package:mobile_drive_hub/constant/palette.dart';
import 'package:mobile_drive_hub/controllers/message/messages_controller.dart';
import 'package:mobile_drive_hub/model/conversation_model.dart';
import 'package:mobile_drive_hub/views/shared_screen/messages/widgets/messages_list_widget.dart';
import 'package:provider/provider.dart';

class MessagesScreen extends StatefulWidget {
  const MessagesScreen({
    super.key,
    required this.userId,
    required this.profile,
    required this.name,
  });
  final String userId;
  final String profile;
  final String name;
  @override
  State<MessagesScreen> createState() => _MessagesScreenState();
}

class _MessagesScreenState extends State<MessagesScreen> {
  final TextEditingController content = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(15.0),
            child: Row(
              children: [
                const Icon(
                  Icons.arrow_back_ios,
                ),
                const SizedBox(
                  width: 10,
                ),
                ClipOval(
                  child: Image.network(
                    widget.profile,
                    height: 40,
                    width: 40,
                    fit: BoxFit.cover,
                  ),
                ),
                const SizedBox(
                  width: 10,
                ),
                Text(
                  widget.name,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w500,
                  ),
                )
              ],
            ),
          ),
          Expanded(
            child: MessagesListScreen(
              userId: widget.userId,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(15.0),
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
              ),
              child: Row(
                children: [
                  // GestureDetector(
                  //   onTap: () async {},
                  //   child: const Icon(
                  //     Icons.camera_alt_outlined,
                  //     size: 25,
                  //     color: Color.fromRGBO(0, 0, 0, .7),
                  //   ),
                  // ),
                  // const SizedBox(
                  //   width: 5,
                  // ),
                  // GestureDetector(
                  //   onTap: () async {},
                  //   child: const Icon(
                  //     Icons.image_outlined,
                  //     size: 24,
                  //     color: Color.fromRGBO(0, 0, 0, .7),
                  //   ),
                  // ),
                  // SizedBox(
                  //   width: 5,
                  // ),
                  // GestureDetector(
                  //   onTap: () async {},
                  //   child: const Icon(
                  //     Icons.mic_outlined,
                  //     size: 25,
                  //     color: Color.fromRGBO(0, 0, 0, .7),
                  //   ),
                  // ),
                  // SizedBox(
                  //   width: 5,
                  // ),
                  Expanded(
                    child: Container(
                      padding: const EdgeInsets.only(left: 10),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: const Color.fromRGBO(0, 0, 0, .05),
                      ),
                      child: Center(
                        child: TextField(
                          style: const TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 15,
                          ),
                          textAlignVertical: TextAlignVertical.center,
                          maxLines: 2,
                          controller: content,
                          decoration: const InputDecoration(
                            contentPadding: EdgeInsets.all(0),
                            hintText: 'Enter your message here...',
                            border: InputBorder.none,
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 5,
                  ),
                  SizedBox(
                    height: 45,
                    width: 50,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: primaryBg,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      onPressed: () async {
                        final result = await context
                            .read<MessagesController>()
                            .sendMessage(body: content.text);
                        content.text = "";
                      },
                      child: const Icon(Icons.send_rounded),
                    ),
                  )
                ],
              ),
            ),
          ),
        ],
      )),
    );
  }
}
