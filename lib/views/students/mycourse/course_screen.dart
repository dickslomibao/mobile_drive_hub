import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:mobile_drive_hub/constant/palette.dart';
import 'package:mobile_drive_hub/controllers/student/course/courses_controller.dart';
import 'package:mobile_drive_hub/views/students/mycourse/widgets/complete_courses_widger.dart';
import 'package:mobile_drive_hub/views/students/mycourse/widgets/ongoing_courses_widget.dart';
import 'package:mobile_drive_hub/views/students/mycourse/widgets/waiting_course.dart';
import 'package:provider/provider.dart';

import '../appbar/app_bar_widget.dart';

import 'widgets/list_courses_widget.dart';

class CourseScreen extends StatefulWidget {
  const CourseScreen({super.key});

  @override
  State<CourseScreen> createState() => _CourseScreenState();
}

class _CourseScreenState extends State<CourseScreen>
    with SingleTickerProviderStateMixin {
  late TabController tabController;

  @override
  void initState() {
    super.initState();
    context.read<CoursesController>().getStudentCourses();
    tabController = TabController(length: 4, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    final watch = context.watch<CoursesController>();
    // final read = context.read<AvailedCoursesController>();
    // final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: primaryBg,
      body: SafeArea(
        child: Container(
          color: Colors.white,
          height: height,
          child: Stack(
            children: [
              const AppBarWidget(
                title: 'My courses',
              ),
              watch.isLoading
                  ? const Center(
                      child: CircularProgressIndicator(),
                    )
                  : Container(
                      padding: const EdgeInsets.only(
                        top: 15,
                        left: 15,
                        right: 15,
                        bottom: 15,
                      ),
                      margin: const EdgeInsets.only(top: 60),
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Expanded(
                                child: Align(
                                  alignment: Alignment.centerLeft,
                                  child: TabBar(
                                    controller: tabController,
                                    isScrollable: true,
                                    tabs: const [
                                      Tab(
                                        child: Text(
                                          'All',
                                          style: TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.w500,
                                          ),
                                        ),
                                      ),
                                      Tab(
                                        child: Text(
                                          'Waiting',
                                          style: TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.w500,
                                          ),
                                        ),
                                      ),
                                      Tab(
                                        child: Text(
                                          'Ongoing',
                                          style: TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.w500,
                                          ),
                                        ),
                                      ),
                                      Tab(
                                        child: Text(
                                          'Completed',
                                          style: TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.w500,
                                          ),
                                        ),
                                      ),
                                    ],
                                    labelColor: Colors.black,
                                  ),
                                ),
                              ),
                              IconButton(
                                onPressed: () async {
                                  Fluttertoast.showToast(
                                    msg: "Refreshing",
                                    toastLength: Toast.LENGTH_SHORT,
                                    gravity: ToastGravity.CENTER,
                                    timeInSecForIosWeb: 1,
                                    backgroundColor: primaryBg,
                                    textColor: Colors.white,
                                    fontSize: 16.0,
                                  );
                                  await context
                                      .read<CoursesController>()
                                      .getStudentCourses();
                                  Fluttertoast.showToast(
                                    msg: "Refresh Success",
                                    toastLength: Toast.LENGTH_SHORT,
                                    gravity: ToastGravity.CENTER,
                                    timeInSecForIosWeb: 1,
                                    backgroundColor: primaryBg,
                                    textColor: Colors.white,
                                    fontSize: 16.0,
                                  );
                                },
                                icon: Icon(Icons.refresh_rounded),
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Expanded(
                            child: TabBarView(
                              controller: tabController,
                              children: const [
                                ListCoursesWidget(),
                                WaitingCourses(),
                                OngoingCourses(),
                                CompletedCourses(),
                              ],
                            ),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                        ],
                      ),
                    ),
            ],
          ),
        ),
      ),
    );
  }
}
