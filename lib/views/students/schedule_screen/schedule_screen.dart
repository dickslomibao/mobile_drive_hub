import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:mobile_drive_hub/views/students/schedule_screen/all_screen.dart';
import 'package:mobile_drive_hub/views/students/schedule_screen/completed_screen.dart';
import 'package:mobile_drive_hub/views/students/schedule_screen/incoming_screen.dart';
import 'package:mobile_drive_hub/views/students/schedule_screen/ongoing_screen.dart';
import 'package:provider/provider.dart';
import '../../../constant/palette.dart';
import '../../../controllers/student/schedules/schedules_controller.dart';
import '../appbar/app_bar_widget.dart';

class StudentScheduleScreen extends StatefulWidget {
  const StudentScheduleScreen({super.key});

  @override
  State<StudentScheduleScreen> createState() => _StudentScheduleScreenState();
}

class _StudentScheduleScreenState extends State<StudentScheduleScreen>
    with SingleTickerProviderStateMixin {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    tabController = TabController(length: 4, vsync: this);
    context.read<StudentSchedulesController>().getStudentSchedules();
  }

  late TabController tabController;
  @override
  Widget build(BuildContext context) {
    final watch = context.watch<StudentSchedulesController>();
    final height = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: primaryBg,
      body: SafeArea(
        child: Container(
          height: height,
          color: Colors.white,
          child: Stack(
            children: [
              const AppBarWidget(
                title: 'Schedules',
              ),
              watch.isLoading
                  ? Center(child: CircularProgressIndicator())
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
                                      .read<StudentSchedulesController>()
                                      .getStudentSchedules();
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
                                AllSchedule(),
                                IncomingSchedule(),
                                OngoingSchedule(),
                                CompletedSchedule(),
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
