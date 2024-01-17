import 'package:flutter/material.dart';
import 'package:mobile_drive_hub/views/shared_widget/loader_widget.dart';
import 'package:mobile_drive_hub/views/students/schedule_screen/schedule_practical_view_screen.dart';
import 'package:persistent_bottom_nav_bar_v2/persistent-tab-view.dart';
import 'package:provider/provider.dart';
import 'package:quickalert/quickalert.dart';

import '../../../../constant/palette.dart';
import 'package:intl/intl.dart';

import '../../../../constant/url.dart';
import '../../../../controllers/student/schedules/schedule_view_screen.dart';

class PracticalContainerWidget extends StatelessWidget {
  const PracticalContainerWidget({super.key, required this.schedule});
  final Map<String, dynamic> schedule;
  @override
  Widget build(BuildContext context) {
    print(schedule);

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
      onTap: () async {
        context.read<StudentViewSchedulesController>().scheduleId =
            schedule['id'].toString();
        pushNewScreen(
          context,
          screen: const PracticalScheduleViewScreen(),
          withNavBar: false,
        );
      },
      child: Container(
        margin: const EdgeInsets.only(bottom: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
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
                    height: 15,
                  ),
                  Text(
                    "${DateFormat('h:mm a').format(DateTime.parse(schedule['start_date'].toString()))} - ${DateFormat('h:mm a').format(DateTime.parse(schedule['end_date'].toString()))}",
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Text(
                    'School: ${schedule['name']}',
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Row(
                    children: [
                      ClipOval(
                        child: Image.network(
                          WEBSITE_URL +
                              schedule['instructor'][0]['profile_image']
                                  .toString(),
                          height: 30,
                          width: 30,
                          fit: BoxFit.cover,
                        ),
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            schedule['instructor'][0]['firstname'] +
                                " " +
                                schedule['instructor'][0]['lastname'],
                            style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          Text(
                            schedule['instructor'][0]['email'],
                            style: const TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Text(
                    'Vehicle: ${schedule['vehicle']['name']}',
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                    ),
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
