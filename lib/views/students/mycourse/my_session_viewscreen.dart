import 'package:flutter/material.dart';
import 'package:mobile_drive_hub/views/students/mycourse/widgets/schedule_container_widget.dart';

import '../../../constant/palette.dart';
import '../appbar/app_bar_widget.dart';

class CourseSessionScreen extends StatelessWidget {
  const CourseSessionScreen({super.key, required this.course});
  final Map<String, dynamic> course;
  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: primaryBg,
      body: SafeArea(
        child: Container(
          height: height,
          color: backgroundMainColor,
          child: Stack(children: [
            const AppBarWidget(
              title: 'My Course Sessions',
              leading: true,
            ),
            Container(
              margin: const EdgeInsets.only(top: 60),
              child: SingleChildScrollView(
                child: ListView.builder(
                  physics: const BouncingScrollPhysics(),
                  itemCount: course['sessions'].length,
                  shrinkWrap: true,
                  itemBuilder: (context, index) {
                    final session = course['sessions'][index];
                    return ScheduleContainerWidget(
                      session: session,
                    );
                  },
                ),
              ),
            ),
          ]),
        ),
      ),
    );
  }
}
