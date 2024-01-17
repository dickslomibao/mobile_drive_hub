import 'package:flutter/material.dart';
import 'package:mobile_drive_hub/views/students/schedule_screen/rate_instructor_screen.dart';
import 'package:mobile_drive_hub/views/students/schedule_screen/report_screen.dart';
import 'package:provider/provider.dart';

import '../../../constant/const_method.dart';
import '../../../constant/palette.dart';
import '../../../constant/url.dart';
import '../../../controllers/student/schedules/schedule_view_screen.dart';
import '../../shared_screen/messages/messages_screen.dart';
import '../../shared_widget/session_status.dart';
import '../appbar/app_bar_widget.dart';
import 'package:intl/intl.dart';

class PracticalScheduleViewScreen extends StatefulWidget {
  const PracticalScheduleViewScreen({super.key});

  @override
  State<PracticalScheduleViewScreen> createState() =>
      _PracticalScheduleViewScreenState();
}

class _PracticalScheduleViewScreenState
    extends State<PracticalScheduleViewScreen> {
  TextEditingController c = TextEditingController();
  @override
  void initState() {
    super.initState();context.read<StudentViewSchedulesController>().isLoading = true;
    final r = context.read<StudentViewSchedulesController>();
    r.getSingleStudentSchedule();
  }

  @override
  Widget build(BuildContext context) {
    final watch = context.watch<StudentViewSchedulesController>();
    final schedule = watch.schedule;
    final height = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: primaryBg,
      body: SafeArea(
        child: Container(
          height: height,
          color: Colors.white,
          child: Stack(
            children: [
              const AppBarWidget(
                title: 'Schedule Details',
              ),
              watch.isLoading
                  ? const Center(child: CircularProgressIndicator())
                  : Container(
                      margin: const EdgeInsets.only(top: 60),
                      child: SingleChildScrollView(
                        child: Column(
                          children: [
                            Container(
                              width: double.infinity,
                              color: secondaryMainColor,
                              padding: const EdgeInsets.all(15),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      const Text(
                                        'Status: ',
                                        style: TextStyle(
                                          fontSize: 17,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                      const SizedBox(
                                        width: 10,
                                      ),
                                      SessionStatus(
                                        status: schedule['status'],
                                      )
                                    ],
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  const Divider(),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  Text(
                                    'Date: ${DateFormat('E - MMMM d, yyyy').format(DateTime.parse(schedule['start_date'].toString()))}',
                                    style: const TextStyle(
                                      fontSize: 17,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 5,
                                  ),
                                  Text(
                                    'From ${DateFormat('h:mm a').format(DateTime.parse(schedule['start_date'].toString()))} - To ${DateFormat('h:mm a').format(DateTime.parse(schedule['end_date'].toString()))}',
                                    style: const TextStyle(
                                      fontSize: 17,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 5,
                                  ),
                                  Text(
                                    'Session number: ${schedule['session']['session_number']}',
                                    style: const TextStyle(
                                      fontSize: 17,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 5,
                                  ),
                                  Text(
                                    'Total hours: ${schedule['total_hours']} hrs',
                                    style: const TextStyle(
                                      fontSize: 17,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                  if (schedule['status'] == 3)
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        const SizedBox(
                                          height: 5,
                                        ),
                                        const Divider(),
                                        const SizedBox(
                                          height: 5,
                                        ),
                                        Text(
                                          'Completed Hours: ${schedule['complete_hours']} hrs',
                                          style: const TextStyle(
                                            fontSize: 17,
                                            fontWeight: FontWeight.w500,
                                          ),
                                        ),
                                        const SizedBox(
                                          height: 5,
                                        ),
                                        Text(
                                          'Date started: ${watch.startDate()}',
                                          style: const TextStyle(
                                            fontSize: 17,
                                            fontWeight: FontWeight.w500,
                                          ),
                                        ),
                                        const SizedBox(
                                          height: 5,
                                        ),
                                        Text(
                                          'Date Ended: ${watch.endDate()}',
                                          style: const TextStyle(
                                            fontSize: 17,
                                            fontWeight: FontWeight.w500,
                                          ),
                                        ),
                                      ],
                                    ),
                                  const SizedBox(
                                    height: 5,
                                  ),
                                  const Divider(),
                                  const SizedBox(
                                    height: 5,
                                  ),
                                  Text(
                                    'Course name: ${schedule['course_name']}',
                                    style: const TextStyle(
                                      fontSize: 17,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                  Text(
                                    'Variants: ${schedule['course_duration']} hrs',
                                    style: const TextStyle(
                                      fontSize: 17,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        'Vehicle: ${schedule['vehicle']['name']}',
                                        style: const TextStyle(
                                          fontSize: 17,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                      Text(
                                        'Transmission: ${schedule['vehicle']['transmission']}',
                                        style: const TextStyle(
                                          fontSize: 17,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(
                                    height: 5,
                                  ),
                                  const Divider(),
                                  const SizedBox(
                                    height: 5,
                                  ),
                                  const Text(
                                    'Instructor:',
                                    style: TextStyle(
                                      fontSize: 17,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 15,
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Expanded(
                                        child: Row(
                                          children: [
                                            ClipOval(
                                              child: Image.network(
                                                WEBSITE_URL +
                                                    schedule['instructor'][0]
                                                            ['profile_image']
                                                        .toString(),
                                                height: 35,
                                                width: 35,
                                                fit: BoxFit.cover,
                                              ),
                                            ),
                                            const SizedBox(
                                              width: 10,
                                            ),
                                            Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  schedule['instructor'][0]
                                                          ['firstname'] +
                                                      " " +
                                                      schedule['instructor'][0]
                                                          ['lastname'],
                                                  style: const TextStyle(
                                                    fontSize: 17,
                                                    fontWeight: FontWeight.w500,
                                                  ),
                                                ),
                                                Text(
                                                  schedule['instructor'][0]
                                                      ['email'],
                                                  style: const TextStyle(
                                                    fontSize: 14,
                                                    fontWeight: FontWeight.w500,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ),
                                      Row(
                                        children: [
                                          GestureDetector(
                                            onTap: () {
                                              Navigator.of(context)
                                                  .push(MaterialPageRoute(
                                                builder: (context) {
                                                  return MessagesScreen(
                                                    userId:
                                                        schedule['instructor']
                                                            [0]['user_id'],
                                                    profile: WEBSITE_URL +
                                                        schedule['instructor']
                                                                    [0][
                                                                'profile_image']
                                                            .toString(),
                                                    name: schedule['instructor']
                                                            [0]['firstname'] +
                                                        " " +
                                                        schedule['instructor']
                                                            [0]['lastname'],
                                                  );
                                                },
                                              ));
                                            },
                                            child: const Icon(
                                              Icons.chat_bubble_outline_rounded,
                                              size: 23,
                                            ),
                                          ),
                                          Visibility(
                                            visible: schedule['status'] == 3 &&
                                                schedule['instructor'][0]
                                                        ['reported'] ==
                                                    0,
                                            child: Container(
                                              margin: EdgeInsets.only(left: 10),
                                              child: GestureDetector(
                                                onTap: () {
                                                  Navigator.of(context).push(
                                                    MaterialPageRoute(
                                                      builder: (context) {
                                                        return ReportInstructorScreen(
                                                          scheduleId:
                                                              schedule['id']
                                                                  .toString(),
                                                          instructorId: schedule[
                                                                  'instructor']
                                                              [0]['user_id'],
                                                        );
                                                      },
                                                    ),
                                                  );
                                                },
                                                child: const Icon(
                                                  Icons.report_outlined,
                                                ),
                                              ),
                                            ),
                                          ),
                                          Visibility(
                                            visible: schedule['status'] == 3 &&
                                                schedule['instructor'][0]
                                                        ['rate'] ==
                                                    0,
                                            child: Container(
                                              margin: const EdgeInsets.only(
                                                  left: 10),
                                              child: GestureDetector(
                                                onTap: () {
                                                  Navigator.of(context).push(
                                                    MaterialPageRoute(
                                                      builder: (context) {
                                                        return ReviewInstructor(
                                                          scheduleId:
                                                              schedule['id']
                                                                  .toString(),
                                                          instructorId: schedule[
                                                                  'instructor']
                                                              [0]['user_id'],
                                                          instructorData: schedule[
                                                              'instructor'][0],
                                                        );
                                                      },
                                                    ),
                                                  );
                                                },
                                                child: const Icon(
                                                  Icons.rate_review_outlined,
                                                ),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
            ],
          ),
        ),
      ),
    );
  }
}
