import 'package:flutter/material.dart';

import '../../../../constant/const_method.dart';
import 'my_course_status.dart';

class CourseStatusWidget extends StatelessWidget {
  const CourseStatusWidget(
      {super.key, required this.status, required this.session});
  final int status;
  final int session;
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        const Text(
          'Status:',
          style: TextStyle(
            fontSize: 17,
            fontWeight: FontWeight.w500,
          ),
        ),
        MyCourseStatus(
          status: status,
        ),
      ],
    );
  }
}
