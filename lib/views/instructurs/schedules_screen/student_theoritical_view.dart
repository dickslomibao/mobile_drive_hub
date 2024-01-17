import 'package:flutter/material.dart';
import 'package:mobile_drive_hub/controllers/instructor/view_schedules_controller.dart';
import 'package:mobile_drive_hub/controllers/instructor/view_student_progress.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:provider/provider.dart';

import '../../../constant/palette.dart';
import '../../../constant/url.dart';
import '../../../controllers/instructor/instructor_schedules_controller.dart';
import '../../students/mock_screen/mock_screen.dart';
import '../../students/mycourse/progress_view_screen.dart';
import '../appbar/insctructor_appbar_widget.dart';
import 'widgets/filtering_button_widget.dart';
import 'package:intl/intl.dart';

class StudenViewTheoritical extends StatefulWidget {
  const StudenViewTheoritical(
      {super.key, required this.studentId, required this.orderListId});
  final String studentId;
  final int orderListId;
  @override
  State<StudenViewTheoritical> createState() => _StudenViewTheoriticalState();
}

class _StudenViewTheoriticalState extends State<StudenViewTheoritical> {
  @override
  void initState() {
    context
        .read<ViewStudentProgress>()
        .viewStudentProgress(widget.studentId, widget.orderListId);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;

    final watch = context.watch<ViewStudentProgress>();
    final Map<String, dynamic> student = watch.student;

    return Scaffold(
      backgroundColor: primaryBg,
      body: SafeArea(
        child: Container(
          height: height,
          color: backgroundMainColor,
          child: Stack(
            children: [
              const InstrcutorAppBarWidget(
                title: 'Student Details',
              ),
              Container(
                margin: const EdgeInsets.only(top: 65),
                child: watch.isLoading
                    ? const Center(
                        child: CircularProgressIndicator(),
                      )
                    : SingleChildScrollView(
                        child: Column(
                          children: [
                            Container(
                              width: double.infinity,
                              color: secondaryMainColor,
                              padding: const EdgeInsets.all(15),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Text(
                                    'Student Information',
                                    style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 15,
                                  ),
                                  Text(
                                    'Firstname: ${student['firstname']}',
                                    style: const TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 5,
                                  ),
                                  Text(
                                    'Lastname: ${student['lastname']}',
                                    style: const TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 5,
                                  ),
                                  Text(
                                    'Email: ${student['email']}',
                                    style: const TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 5,
                                  ),
                                  Text(
                                    'Phone number: ${student['phone_number']}',
                                    style: const TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            Container(
                              width: double.infinity,
                              color: secondaryMainColor,
                              padding: const EdgeInsets.all(15),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    children: [
                                      const Text(
                                        'Student Progress',
                                        style: TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                      // Spacer(),
                                      // GestureDetector(
                                      //   child: Icon(Icons.more_vert_rounded),
                                      // ),
                                    ],
                                  ),
                                  const SizedBox(
                                    height: 30,
                                  ),
                                  Row(
                                    children: [
                                      Expanded(
                                        child: Column(
                                          children: [
                                            CircularPercentIndicator(
                                              radius: 70.0,
                                              lineWidth: 10.0,
                                              percent: double.parse(
                                                  (student['completed_hrs'] /
                                                          15)
                                                      .toString()),
                                              center: Text(
                                                "${double.parse(((student['completed_hrs'] / 15) * 100).toString()).toStringAsFixed(1)}%",
                                                style: const TextStyle(
                                                  fontSize: 18,
                                                  fontWeight: FontWeight.w500,
                                                ),
                                              ),
                                              progressColor: Colors.green,
                                            ),
                                            const SizedBox(
                                              height: 20,
                                            ),
                                            const Text(
                                              'Completed Hours',
                                              style: TextStyle(
                                                fontSize: 18,
                                                fontWeight: FontWeight.w500,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      // Expanded(
                                      //   child: Column(
                                      //     children: [
                                      //       CircularPercentIndicator(
                                      //         radius: 70.0,
                                      //         lineWidth: 10.0,
                                      //         percent: 1,
                                      //         center: const Text(
                                      //           "100%",
                                      //           style: TextStyle(
                                      //             fontSize: 18,
                                      //             fontWeight: FontWeight.w500,
                                      //           ),
                                      //         ),
                                      //         progressColor: Colors.green,
                                      //       ),
                                      //       const SizedBox(
                                      //         height: 20,
                                      //       ),
                                      //       const Text(
                                      //         'Progress',
                                      //         style: TextStyle(
                                      //           fontSize: 18,
                                      //           fontWeight: FontWeight.w500,
                                      //         ),
                                      //       ),
                                      //     ],
                                      //   ),
                                      // ),
                                    ],
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  Container(
                                    height: 80,
                                    padding: const EdgeInsets.all(15),
                                    child: Row(
                                      children: [
                                        // Expanded(
                                        //   child: Container(
                                        //     height: 48,
                                        //     child: ElevatedButton(
                                        //       style: ElevatedButton.styleFrom(
                                        //         elevation: 0,
                                        //         shape: RoundedRectangleBorder(
                                        //           borderRadius:
                                        //               BorderRadius.circular(10),
                                        //         ),
                                        //       ),
                                        //       onPressed: () {
                                        //         Navigator.of(context).push(
                                        //           MaterialPageRoute(
                                        //             builder: (context) {
                                        //               return StudentCourseProgressView(
                                        //                 orderListId:
                                        //                     widget.orderListId,
                                        //                 studentId:
                                        //                     widget.studentId,
                                        //               );
                                        //             },
                                        //           ),
                                        //         );
                                        //       },
                                        //       child: const Text(
                                        //         'Progress',
                                        //         style: TextStyle(
                                        //           fontSize: 16,
                                        //           fontWeight: FontWeight.w500,
                                        //           color: Colors.white,
                                        //         ),
                                        //       ),
                                        //     ),
                                        //   ),
                                        // ),
                                        // const SizedBox(
                                        //   width: 10,
                                        // ),
                                        Expanded(
                                          child: Container(
                                            height: 48,
                                            child: ElevatedButton(
                                              onPressed: () {
                                                Navigator.of(context).push(
                                                  MaterialPageRoute(
                                                    builder: (context) {
                                                      return MockListScreen(
                                                        id: widget.orderListId
                                                            .toString(),
                                                        instructor: true,
                                                      );
                                                    },
                                                  ),
                                                );
                                              },
                                              style: ElevatedButton.styleFrom(
                                                elevation: 0,
                                                shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(10),
                                                ),
                                              ),
                                              child: const Text(
                                                'Mock Exam',
                                                style: TextStyle(
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.w500,
                                                  color: Colors.white,
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
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
