import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:mobile_drive_hub/constant/palette.dart';
import 'package:mobile_drive_hub/views/instructurs/schedules_screen/practical_schedule_view_screen.dart';
import 'package:mobile_drive_hub/views/instructurs/schedules_screen/widgets/all_schedules_widget.dart';
import 'package:mobile_drive_hub/views/instructurs/schedules_screen/widgets/completed_schedules_widget.dart';
import 'package:mobile_drive_hub/views/instructurs/schedules_screen/widgets/incoming_schedules_widget.dart';
import 'package:mobile_drive_hub/views/instructurs/schedules_screen/widgets/ongoing_schedules_widget.dart';
import 'package:mobile_drive_hub/views/students/schedule_screen/all_screen.dart';
import 'package:persistent_bottom_nav_bar_v2/persistent-tab-view.dart';
import 'package:provider/provider.dart';

import '../../../controllers/instructor/instructor_schedules_controller.dart';
import '../appbar/insctructor_appbar_widget.dart';
import 'theoritical_schedule_view_screen.dart';
import 'widgets/filtering_button_widget.dart';
import 'package:intl/intl.dart';

import 'widgets/instructor_practical_container_widget.dart';
import 'widgets/instructor_theoritical_container_widget.dart';

class InstructorScheduleScreen extends StatefulWidget {
  const InstructorScheduleScreen({super.key});

  @override
  State<InstructorScheduleScreen> createState() =>
      _InstructorScheduleScreenState();
}

class _InstructorScheduleScreenState extends State<InstructorScheduleScreen>
    with SingleTickerProviderStateMixin {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    tabController = TabController(length: 4, vsync: this);
    context.read<InstructorScheduleController>().getInstructorSchedules();
  }

  late TabController tabController;
  @override
  Widget build(BuildContext context) {
    final watch = context.watch<InstructorScheduleController>();
    final height = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: primaryBg,
      body: SafeArea(
        child: Container(
          color: Colors.white,
          height: height,
          child: Stack(
            children: [
              const InstrcutorAppBarWidget(
                title: 'Schedules',
              ),
              if (watch.isLoading)
                const Center(
                  child: CircularProgressIndicator(),
                )
              else
                Container(
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
                                      'Incoming',
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
                                  .read<InstructorScheduleController>()
                                  .getInstructorSchedules();
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
                          children: [
                            AllScheduleWidget(
                              schedules: watch.schedules,
                            ),
                            IncomingScheduleWidget(
                              schedules: watch.getIncoming(),
                            ),
                            OngoingScheduleWidget(
                              schedules: watch.getOngoing(),
                            ),
                            CompletedSchedulesWidget(
                              schedules: watch.getCompleted(),
                            )
                          ],
                        ),
                      )
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
