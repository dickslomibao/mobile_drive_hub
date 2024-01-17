import 'package:flutter/material.dart';
import 'package:mobile_drive_hub/constant/palette.dart';
import 'package:mobile_drive_hub/controllers/student/course/view_mycourses_controller.dart';
import 'package:provider/provider.dart';

import '../appbar/app_bar_widget.dart';

import 'widgets/schedule_container_widget.dart';

class ProgressViewScreen extends StatefulWidget {
  const ProgressViewScreen({
    super.key,
  });

  @override
  State<ProgressViewScreen> createState() => _ProgressViewScreenState();
}

class _ProgressViewScreenState extends State<ProgressViewScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final watch = context.watch<ViewMyCoursesController>();
    final height = MediaQuery.of(context).size.height;
    final progress = watch.course['progress'];
    return Scaffold(
      backgroundColor: primaryBg,
      body: SafeArea(
        child: watch.isLoading
            ? const Center(
                child: CircularProgressIndicator(),
              )
            : Container(
                height: height,
                color: backgroundMainColor,
                child: Stack(
                  children: [
                    const AppBarWidget(
                      title: 'Course Progress',
                      leading: true,
                    ),
                    Container(
                      margin: const EdgeInsets.only(top: 60),
                      child: SingleChildScrollView(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const SizedBox(
                              height: 10,
                            ),
                            ListView.builder(
                              physics: const BouncingScrollPhysics(),
                              itemCount: progress.length,
                              shrinkWrap: true,
                              itemBuilder: (context, index) {
                                final p = progress[index];
                                return Container(
                                  color: secondaryMainColor,
                                  padding: const EdgeInsets.all(15),
                                  margin: const EdgeInsets.only(bottom: 10),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        p['progress']['title'],
                                        style: const TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                      const SizedBox(
                                        height: 5,
                                      ),
                                      ListView.builder(
                                        physics: const BouncingScrollPhysics(),
                                        itemCount: p['sub_progress'].length,
                                        shrinkWrap: true,
                                        itemBuilder: (context, index) {
                                          final s = p['sub_progress'][index];
                                          return Row(
                                            children: [
                                              Checkbox(
                                                value: s['status'] != 1,
                                                onChanged: (value) {},
                                              ),
                                              Expanded(
                                                child: Text(
                                                  s['title'],
                                                  style: const TextStyle(
                                                    fontSize: 16,
                                                    fontWeight: FontWeight.w500,
                                                  ),
                                                ),
                                              ),
                                            ],
                                          );
                                        },
                                      ),
                                    ],
                                  ),
                                );
                              },
                            ),
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              ),
      ),
    );
  }
}
