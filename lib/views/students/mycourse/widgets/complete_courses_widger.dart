import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:mobile_drive_hub/controllers/student/course/courses_controller.dart';
import 'package:persistent_bottom_nav_bar_v2/persistent-tab-view.dart';
import 'package:provider/provider.dart';

import '../../../../constant/const_method.dart';
import '../../../../constant/palette.dart';
import '../../../../constant/url.dart';
import '../../../../controllers/student/course/view_mycourses_controller.dart';
import '../mycourse_view_screen.dart';
import 'course_status_widget.dart';
import 'courses_container_widget.dart';

class CompletedCourses extends StatelessWidget {
  const CompletedCourses({super.key});
  @override
  Widget build(BuildContext context) {
    final courses = context.watch<CoursesController>().completed;
    return RefreshIndicator(
      onRefresh: () async {},
      child: ListView.builder(
        physics: const BouncingScrollPhysics(),
        shrinkWrap: true,
        itemCount: courses.length,
        itemBuilder: (context, index) {
          final course = courses[index];
          return CourseContainerWidget(
            color: Colors.white,
            course: course,
          );
        },
      ),
    );
  }
}
