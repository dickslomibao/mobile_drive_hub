import 'package:flutter/material.dart';
import 'package:mobile_drive_hub/constant/palette.dart';
import 'package:persistent_bottom_nav_bar_v2/persistent-tab-view.dart';
import 'package:provider/provider.dart';

import '../../../../constant/url.dart';
import '../../../../controllers/student/course/view_mycourses_controller.dart';
import '../mycourse_view_screen.dart';
import 'course_status_widget.dart';

class CourseContainerWidget extends StatelessWidget {
  const CourseContainerWidget({
    super.key,
    required this.color,
    required this.course,
  });

  final Color color;
  final Map<String, dynamic> course;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 15),
      decoration: BoxDecoration(
        color: color,
        border: Border.all(
          color: backgroundMainColor,
        ),
        borderRadius: BorderRadius.circular(10),
      ),
      width: double.infinity,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(
              top: 15,
              left: 20,
              right: 20,
              bottom: 10,
            ),
            child: CourseStatusWidget(
              status: course['mycourse.status'],
              session: course['mycourse.session'],
            ),
          ),
          const Divider(
            color: Color.fromRGBO(0, 0, 0, 0.1),
          ),
          Padding(
            padding: const EdgeInsets.only(
              top: 10,
              left: 20,
              right: 20,
              bottom: 15,
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(5),
                    child: Image.network(
                      WEBSITE_URL + course['course_info.thumbnail'],
                      height: 60,
                      width: 80,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                const SizedBox(
                  width: 10,
                ),
                Expanded(
                  child: SizedBox(
                    height: 60,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Course name: ${course['course_info.name']}',
                          style: const TextStyle(
                            fontSize: 17,
                            fontWeight: FontWeight.w500,
                          ),
                          overflow: TextOverflow.ellipsis,
                          maxLines: 2,
                        ),
                        Text(
                          'Duration: ${course['mycourse.duration']} hrs',
                          style: const TextStyle(
                            overflow: TextOverflow.ellipsis,
                            fontSize: 17,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(
              top: 5,
              left: 15,
              right: 15,
              bottom: 20,
            ),
            child: SizedBox(
              width: double.infinity,
              height: 42,
              child: OutlinedButton(
                style: OutlinedButton.styleFrom(
                  elevation: 0,
                  // side: BorderSide(
                  //   color: primaryBg,
                  // ),
                  // backgroundColor: secondaryBg,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                onPressed: () {
                  context.read<ViewMyCoursesController>().reload();
                  pushNewScreen(
                    context,
                    screen: MyCourseViewScreen(
                      myCourseId: course['mycourse.id'],
                    ),
                    withNavBar: false, // OPTIONAL VALUE. True by default.
                    pageTransitionAnimation:
                        PageTransitionAnimation.scaleRotate,
                  );
                },
                child: const Text(
                  'View course',
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
