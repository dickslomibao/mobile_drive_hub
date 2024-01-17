import 'package:flutter/material.dart';
import 'package:mobile_drive_hub/model/driving_school_model.dart';
import 'package:mobile_drive_hub/services/course_sevices.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:persistent_bottom_nav_bar_v2/persistent-tab-view.dart';

import '../../students/course_view/course_view_screen.dart';

class CoursesWidget extends StatelessWidget {
  const CoursesWidget({super.key, required this.drivingSchoolModel});
  final DrivingSchoolModel drivingSchoolModel;
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: courseServices.getSchoolCourses(drivingSchoolModel.userId),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }
        final courses = snapshot.data!;
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15.0),
          child: MasonryGridView.builder(
            padding: const EdgeInsets.only(
              top: 15,
            ),
            itemCount: courses.length,
            mainAxisSpacing: 10,
            crossAxisSpacing: 10,
            gridDelegate: const SliverSimpleGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
            ),
            itemBuilder: (context, index) {
              final c = courses[index];
              return GestureDetector(
                onTap: () {
                  pushNewScreen(
                    context,
                    screen: CourseViewScreen(
                      courseId: c.id,
                    ),
                    withNavBar: false,
                    pageTransitionAnimation: PageTransitionAnimation.cupertino,
                  );
                },
                child: Card(
                  elevation: 0.5,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(0),
                        child: Image.network(
                          c.thumbnail,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const SizedBox(
                              height: 5,
                            ),
                            Text(
                              c.name,
                              style: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            const SizedBox(
                              height: 5,
                            ),
                            Text(
                              'Start at: ${double.parse(c.variants[0]['price'].toString()).toStringAsFixed(2)}',
                              style: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            // const SizedBox(
                            //   height: 2,
                            // ),
                            // Text(
                            //   "Duration: ${c.duration}",
                            //   style: const TextStyle(
                            //     fontSize: 15,
                            //     fontWeight: FontWeight.w500,
                            //   ),
                            // ),
                            // Text(
                            //   "Price: ${c.price}",
                            //   style: const TextStyle(
                            //     fontSize: 15,
                            //     fontWeight: FontWeight.w500,
                            //   ),
                            // ),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              );
            },
          ),
        );
      },
    );
  }
}
