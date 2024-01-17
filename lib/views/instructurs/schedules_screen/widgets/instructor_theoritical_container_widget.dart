import 'package:flutter/material.dart';
import 'package:image_stack/image_stack.dart';
import 'package:mobile_drive_hub/views/instructurs/drive_screen/drive_screen.dart';

import '../../../../constant/palette.dart';
import 'package:intl/intl.dart';

import '../../../../constant/url.dart';

class InstructorTheoriticalContainerWidget extends StatelessWidget {
  const InstructorTheoriticalContainerWidget(
      {super.key, required this.schedule});
  final Map<String, dynamic> schedule;
  @override
  Widget build(BuildContext context) {
    List<String> imageStudent = [];
    for (var s in schedule['students']) {
      imageStudent.add(WEBSITE_URL + s['profile_image']);
    }

    return Container(
      margin: const EdgeInsets.only(bottom: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 15),
            child: Text(
              "${DateFormat('h:mm a').format(DateTime.parse(schedule['start_date'].toString()))} - ${DateFormat('h:mm a').format(DateTime.parse(schedule['end_date'].toString()))}",
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          const SizedBox(
            height: 15,
          ),
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
              color: backgroundMainColor,
            ),
            padding: const EdgeInsets.all(15),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text(
                      'Session ${schedule['theoritical']['for_session_number']}',
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    const Spacer(),
                    Row(
                      children: [
                        const Icon(
                          Icons.timer_outlined,
                          size: 18,
                        ),
                        const SizedBox(
                          width: 5,
                        ),
                        Text(
                          "${schedule['total_hours']} hrs",
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                          ),
                        )
                      ],
                    )
                  ],
                ),
                const SizedBox(
                  height: 10,
                ),
                Text(
                  'Title: ${schedule['theoritical']['title']}',
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                // Text(
                //   'Variant: ${schedule['course_duration']} hrs',
                //   style: const TextStyle(
                //     fontSize: 16,
                //     fontWeight: FontWeight.w500,
                //   ),
                // ),
                const SizedBox(
                  height: 10,
                ),
                const Text(
                  'Students:',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(
                  height: 5,
                ),
                imageStudent.isEmpty
                    ? const Text(
                        'No student Yet',
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                        ),
                      )
                    : ImageStack(
                        imageList: imageStudent,
                        totalCount: imageStudent
                            .length, // If larger than images.length, will show extra empty circle
                        imageRadius: 30, // Radius of each images
                        imageCount:
                            3, // Maximum number of images to be shown in stack
                        imageBorderWidth: 2,
                        imageBorderColor:
                            Colors.green, // Border width around the images
                      ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
