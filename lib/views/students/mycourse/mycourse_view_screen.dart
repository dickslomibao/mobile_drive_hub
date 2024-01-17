import 'package:flutter/material.dart';
import 'package:mobile_drive_hub/constant/palette.dart';
import 'package:mobile_drive_hub/controllers/student/course/view_mycourses_controller.dart';
import 'package:mobile_drive_hub/views/students/mock_screen/mock_screen.dart';
import 'package:mobile_drive_hub/views/students/mycourse/progress_view_screen.dart';
import 'package:mobile_drive_hub/views/students/mycourse/review_course_screen.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';
import '../../../constant/const_method.dart';
import '../appbar/app_bar_widget.dart';
import 'my_session_viewscreen.dart';
import 'widgets/course_status_widget.dart';
import 'widgets/divider_widget.dart';
import 'widgets/schedule_container_widget.dart';

class MyCourseViewScreen extends StatefulWidget {
  const MyCourseViewScreen({super.key, required this.myCourseId});
  final int myCourseId;
  @override
  State<MyCourseViewScreen> createState() => _MyCourseViewScreenState();
}

class _MyCourseViewScreenState extends State<MyCourseViewScreen> {
  @override
  void initState() {
    super.initState();
    context
        .read<ViewMyCoursesController>()
        .getStudentSingleCourses(widget.myCourseId);
  }

  @override
  Widget build(BuildContext context) {
    final watch = context.watch<ViewMyCoursesController>();
    final height = MediaQuery.of(context).size.height;
    final course = watch.course;
    print(course);
    return Scaffold(
      backgroundColor: primaryBg,
      body: SafeArea(
        child: Container(
          height: height,
          color: backgroundMainColor,
          child: Stack(
            children: [
              const AppBarWidget(
                title: 'My Course Details',
                leading: true,
              ),
              watch.isLoading
                  ? const Center(
                      child: CircularProgressIndicator(),
                    )
                  : Container(
                      margin: const EdgeInsets.only(top: 60),
                      child: SingleChildScrollView(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const SizedBox(
                              height: 5,
                            ),
                            Container(
                              color: secondaryMainColor,
                              padding: const EdgeInsets.all(15),
                              child: CourseStatusWidget(
                                status: course['info']['mycourse_status'],
                                session: course['info']['mycourse_session'],
                              ),
                            ),
                            const SizedBox(
                              height: 5,
                            ),
                            Container(
                              width: double.infinity,
                              padding: const EdgeInsets.all(15),
                              decoration: const BoxDecoration(
                                color: secondaryMainColor,
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Text(
                                    "Name:",
                                    style: TextStyle(
                                      fontSize: 17,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 2,
                                  ),
                                  Text(
                                    course['info']['course_info_name'],
                                    style: const TextStyle(
                                      fontSize: 17,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 5,
                                  ),
                                  const Text(
                                    "Duration:",
                                    style: TextStyle(
                                      fontSize: 17,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 2,
                                  ),
                                  Text(
                                    "${course['info']['mycourse_duration']} hrs",
                                    style: const TextStyle(
                                      fontSize: 17,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 5,
                                  ),
                                  const Text(
                                    "Completed Hours:",
                                    style: TextStyle(
                                      fontSize: 17,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 2,
                                  ),
                                  Text(
                                    "${course['completed_hrs']} hrs",
                                    style: const TextStyle(
                                      fontSize: 17,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(
                              height: 5,
                            ),
                            if (course['info']['mycourse_status'] != 1)
                              Container(
                                color: secondaryMainColor,
                                padding: EdgeInsets.all(15),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const Text(
                                      "Your Progress",
                                      style: TextStyle(
                                        fontSize: 17,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    Row(
                                      children: [
                                        Expanded(
                                          child: Column(
                                            children: [
                                              CircularPercentIndicator(
                                                radius: 70.0,
                                                lineWidth: 10.0,
                                                percent:
                                                    watch.completedInPercent(),
                                                center: Text(
                                                  "${(watch.completedInPercent() * 100).toStringAsFixed(1)}%",
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
                                        if (course['info']['mycourse_type'] ==
                                            1)
                                          Expanded(
                                            child: Column(
                                              children: [
                                                CircularPercentIndicator(
                                                  radius: 70.0,
                                                  lineWidth: 10.0,
                                                  percent: watch
                                                      .studentProgressPercentage(),
                                                  center: Text(
                                                    "${(watch.studentProgressPercentage() * 100).toStringAsFixed(2)}%",
                                                    style: const TextStyle(
                                                      fontSize: 18,
                                                      fontWeight:
                                                          FontWeight.w500,
                                                    ),
                                                  ),
                                                  progressColor: Colors.green,
                                                ),
                                                const SizedBox(
                                                  height: 20,
                                                ),
                                                const Text(
                                                  'Progress',
                                                  style: TextStyle(
                                                    fontSize: 18,
                                                    fontWeight: FontWeight.w500,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            SizedBox(
                              height: 5,
                            ),
                            Container(
                              color: secondaryMainColor,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  if (course['info']['mycourse_status'] != 1)
                                    Container(
                                      height: 80,
                                      padding: const EdgeInsets.all(15),
                                      child: Row(
                                        children: [
                                          if (course['info']['mycourse_type'] ==
                                              1)
                                            Expanded(
                                              child: Container(
                                                height: 48,
                                                child: ElevatedButton(
                                                  style:
                                                      ElevatedButton.styleFrom(
                                                    elevation: 0,
                                                    shape:
                                                        RoundedRectangleBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              10),
                                                    ),
                                                  ),
                                                  onPressed: () {
                                                    Navigator.of(context)
                                                        .push(MaterialPageRoute(
                                                      builder: (context) {
                                                        return const ProgressViewScreen();
                                                      },
                                                    ));
                                                  },
                                                  child: const Text(
                                                    'My Progress',
                                                    style: TextStyle(
                                                      fontSize: 16,
                                                      fontWeight:
                                                          FontWeight.w500,
                                                      color: Colors.white,
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ),
                                          if (course['info']['mycourse_type'] ==
                                              2)
                                            Expanded(
                                              child: Container(
                                                height: 48,
                                                child: ElevatedButton(
                                                  onPressed: () {
                                                    Navigator.of(context).push(
                                                      MaterialPageRoute(
                                                        builder: (context) {
                                                          return MockListScreen(
                                                            id: course['info'][
                                                                    'mycourse_id']
                                                                .toString(),
                                                          );
                                                        },
                                                      ),
                                                    );
                                                  },
                                                  style:
                                                      ElevatedButton.styleFrom(
                                                    elevation: 0,
                                                    shape:
                                                        RoundedRectangleBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              5),
                                                    ),
                                                  ),
                                                  child: const Text(
                                                    'Mock Exam',
                                                    style: TextStyle(
                                                      fontSize: 16,
                                                      fontWeight:
                                                          FontWeight.w500,
                                                      color: Colors.white,
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ),
                                        ],
                                      ),
                                    ),
                                  if (course['info']['mycourse_status'] != 1)
                                    Center(
                                      child: Container(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 15),
                                        height: 48,
                                        width: double.infinity,
                                        child: OutlinedButton(
                                          onPressed: () {
                                            Navigator.of(context)
                                                .push(MaterialPageRoute(
                                              builder: (context) =>
                                                  CourseSessionScreen(
                                                course: course,
                                              ),
                                            ));
                                          },
                                          style: OutlinedButton.styleFrom(
                                            elevation: 0,
                                            shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(5),
                                            ),
                                            side: const BorderSide(
                                              color: primaryBg,
                                            ),
                                          ),
                                          child: const Text(
                                            'View my session',
                                            style: TextStyle(
                                              fontSize: 16,
                                              fontWeight: FontWeight.w500,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  if (course['info']['mycourse_status'] == 3 &&
                                      course['review'] == 0)
                                    Center(
                                      child: Container(
                                        margin: const EdgeInsets.only(top: 10),
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 15),
                                        height: 48,
                                        width: double.infinity,
                                        child: TextButton(
                                          onPressed: () {
                                            Navigator.of(context).push(
                                              MaterialPageRoute(
                                                builder: (context) =>
                                                    ReviewCourseScreen(),
                                              ),
                                            );
                                          },
                                          child: const Text(
                                            'Review Course',
                                            style: TextStyle(
                                              fontSize: 16,
                                              fontWeight: FontWeight.w500,
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
                    ),
            ],
          ),
        ),
      ),
    );
  }
}
