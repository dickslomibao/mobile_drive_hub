import 'package:flutter/material.dart';
import 'package:image_stack/image_stack.dart';
import 'package:intl/intl.dart';
import 'package:mobile_drive_hub/views/students/schedule_screen/schedule_theoritical_view_screen.dart';
import 'package:persistent_bottom_nav_bar_v2/persistent-tab-view.dart';
import 'package:provider/provider.dart';

import '../../../../constant/palette.dart';
import '../../../../constant/url.dart';
import '../../../../controllers/student/schedules/schedule_view_screen.dart';
import '../../../shared_widget/session_status.dart';
import '../../schedule_screen/schedule_practical_view_screen.dart';
import 'divider_widget.dart';

class ScheduleContainerWidget extends StatelessWidget {
  const ScheduleContainerWidget({super.key, required this.session});
  final Map<String, dynamic> session;
  @override
  Widget build(BuildContext context) {
    List<String> imageInstructor = [];
    for (var instructor in session['instructors']) {
      imageInstructor.add(WEBSITE_URL + instructor['profile_image']);
    }
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(15),
      margin: const EdgeInsets.only(bottom: 15),
      decoration: const BoxDecoration(
        color: Colors.white,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Session ${session['session_number']}",
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w500,
                ),
              ),
              if (session['schedule_id'] != 0)
                SessionStatus(
                  status: session['schedules']['status'],
                )
            ],
          ),
          if (session['schedule_id'] == 0)
            Center(
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    child: Image.asset(
                      'assets/images/waiting_schedule.png',
                      width: 40,
                      height: 40,
                    ),
                  ),
                  const Text(
                    "Waiting for schedules",
                    style: TextStyle(
                      fontSize: 17,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            )
          else
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(
                  height: 10,
                ),
                const Text(
                  "Date:",
                  style: TextStyle(
                    fontSize: 17,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(
                  height: 5,
                ),
                Text(
                  "${DateFormat('MMM d, yyyy').format(
                    DateTime.parse(
                      session['schedules']['start_date'].toString(),
                    ),
                  )} | ${DateFormat('h:mm a').format(DateTime.parse(
                    session['schedules']['start_date'].toString(),
                  ))} - ${DateFormat('h:mm a').format(DateTime.parse(
                    session['schedules']['end_date'].toString(),
                  ))}",
                  style: const TextStyle(
                    fontSize: 17,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(
                  height: 5,
                ),
                const Text(
                  "Instructor:",
                  style: TextStyle(
                    fontSize: 17,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(
                  height: 5,
                ),
                (session['schedules']['type'] == 1)
                    ? Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "${session['instructors'][0]['firstname']} ${session['instructors'][0]['lastname']}",
                            style: const TextStyle(
                              fontSize: 17,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          const SizedBox(
                            height: 5,
                          ),
                          const Text(
                            "Vehicle name:",
                            style: TextStyle(
                              fontSize: 17,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          const SizedBox(
                            height: 5,
                          ),
                          Text(
                            '${session['vehicles']['name']} (${session['vehicles']['transmission']})',
                            style: const TextStyle(
                              fontSize: 17,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      )
                    : ImageStack(
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
                const SizedBox(
                  height: 15,
                ),
                SizedBox(
                  width: double.infinity,
                  height: 42,
                  child: OutlinedButton(
                    onPressed: () {
                      context
                          .read<StudentViewSchedulesController>()
                          .scheduleId = session['schedules']['id'].toString();
                      if (session['schedules']['type'] == 1) {
                        pushNewScreen(
                          context,
                          screen: const PracticalScheduleViewScreen(),
                          withNavBar: false,
                        );
                      } else {
                        pushNewScreen(
                          context,
                          screen: const StudentTheoriticalViewScreen(),
                          withNavBar: false,
                        );
                      }
                    },
                    style: OutlinedButton.styleFrom(
                      elevation: 0,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      side: const BorderSide(
                        color: primaryBg,
                      ),
                    ),
                    child: const Text(
                      'View Schedule',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                )
              ],
            ),
        ],
      ),
    );
  }
}
