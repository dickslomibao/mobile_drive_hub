import 'package:flutter/material.dart';
import 'package:mobile_drive_hub/constant/url.dart';
import 'package:mobile_drive_hub/controllers/message/conversation_controller.dart';
import 'package:mobile_drive_hub/views/shared_screen/messages/messages_screen.dart';
import 'package:persistent_bottom_nav_bar_v2/persistent-tab-view.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';
import '../../../../constant/palette.dart';

class ConversationWidget extends StatefulWidget {
  const ConversationWidget({super.key});

  @override
  State<ConversationWidget> createState() => _ConversationWidgetState();
}

class _ConversationWidgetState extends State<ConversationWidget> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    final read = context.read<ConversationController>();
    read.getConversation();
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
    final read = context.read<ConversationController>();
    final watch = context.watch<ConversationController>();
    return watch.isLoaded
        ? RefreshIndicator(
            onRefresh: () async {
              await read.getConversation();
            },
            child: ListView.builder(
              itemCount: read.conversation.length,
              itemBuilder: (BuildContext context, int index) {
                final convo = read.conversation[index];
                return GestureDetector(
                  onTap: () {
                    pushNewScreen(
                      context,
                      screen: MessagesScreen(
                        name: convo['name'],
                        profile: WEBSITE_URL + convo['profile_image'],
                        userId: convo['user_id'],
                      ),
                      withNavBar: false,
                    );
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                    ),
                    padding: const EdgeInsets.all(8),
                    margin: const EdgeInsets.only(bottom: 10),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        CircleAvatar(
                          radius: 25,
                          backgroundImage: NetworkImage(
                            WEBSITE_URL + convo['profile_image'],
                          ),
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                convo['name'],
                                maxLines: 1,
                                style: const TextStyle(
                                  fontSize: 17,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              const SizedBox(
                                height: 5,
                              ),
                              Text(
                                convo['last_message']['body'],
                                maxLines: 1,
                                overflow: TextOverflow.clip,
                                style: const TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(
                          width: 30,
                        ),
                        Column(
                          children: [
                            Text(
                              timeAgo(DateTime.parse(convo['last_message']
                                      ['date_created']
                                  .toString())),
                              style: const TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            // const SizedBox(
                            //   height: 5,
                            // ),
                            // const CircleAvatar(
                            //   backgroundColor: primaryBg,
                            //   radius: 8,
                            //   foregroundColor: Colors.white,
                            //   child: Text(
                            //     '1',
                            //     style: TextStyle(
                            //       fontSize: 10,
                            //       fontWeight: FontWeight.w500,
                            //     ),
                            //   ),
                            // )
                          ],
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          )
        : const Center(
            child: CircularProgressIndicator(),
          );
  }
}
