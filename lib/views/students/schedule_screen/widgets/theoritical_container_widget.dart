import 'package:flutter/material.dart';
import 'package:image_stack/image_stack.dart';
import 'package:intl/intl.dart';
import 'package:mobile_drive_hub/views/students/schedule_screen/schedule_theoritical_view_screen.dart';
import 'package:persistent_bottom_nav_bar_v2/persistent-tab-view.dart';
import 'package:provider/provider.dart';
import '../../../../constant/palette.dart';
import '../../../../constant/url.dart';
import '../../../../controllers/student/schedules/schedule_view_screen.dart';

class TheoriticalContianerWidget extends StatelessWidget {
  const TheoriticalContianerWidget({super.key, required this.schedule});

  final Map<String, dynamic> schedule;
  @override
  Widget build(BuildContext context) {
    List<String> imageInstructor = [];
    for (var instructor in schedule['instructor']) {
      imageInstructor.add(WEBSITE_URL + instructor['profile_image']);
    }

    Color color = secondaryMainColor;
    if (schedule['status'] == 1) {
      color = Color.fromRGBO(247, 111, 2, .1);
    }
    if (schedule['status'] == 2) {
      color = Color.fromRGBO(84, 94, 225, .1);
    }
    if (schedule['status'] == 3) {
      color = Color.fromRGBO(0, 255, 0, .1);
    }
    return GestureDetector(
      onTap: () {
        context.read<StudentViewSchedulesController>().scheduleId =
            schedule['id'].toString();
        pushNewScreen(
          context,
          screen: const StudentTheoriticalViewScreen(),
          withNavBar: false,
        );
      },
      child: Container(
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
                color: color,
              ),
              padding: const EdgeInsets.all(15),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Text(
                        'Session ${schedule['session']['session_number']}',
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
                    height: 5,
                  ),
                  Text(
                    'School: ${schedule['name']}',
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  const Text(
                    'Instructor:',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  ImageStack(
                    imageList: imageInstructor,
                    totalCount: imageInstructor
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
      ),
    );
  }
}
