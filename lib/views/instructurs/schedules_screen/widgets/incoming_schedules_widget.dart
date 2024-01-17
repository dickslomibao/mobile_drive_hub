import 'package:flutter/material.dart';
import 'package:persistent_bottom_nav_bar_v2/persistent-tab-view.dart';
import 'package:provider/provider.dart';

import '../../../../controllers/instructor/instructor_schedules_controller.dart';
import '../practical_schedule_view_screen.dart';
import '../theoritical_schedule_view_screen.dart';
import 'instructor_practical_container_widget.dart';
import 'instructor_theoritical_container_widget.dart';
import 'package:intl/intl.dart';

class IncomingScheduleWidget extends StatefulWidget {
  const IncomingScheduleWidget({super.key, required this.schedules});
  final List<dynamic> schedules;
  @override
  State<IncomingScheduleWidget> createState() => _IncomingScheduleWidgetState();
}

class _IncomingScheduleWidgetState extends State<IncomingScheduleWidget> {
  @override
  Widget build(BuildContext context) {
    final watch = context.read<InstructorScheduleController>();
    final schedules = widget.schedules;
    return RefreshIndicator(
      onRefresh: () async {},
      child: ListView.builder(
        physics: const BouncingScrollPhysics(),
        shrinkWrap: true,
        itemCount: schedules.length,
        itemBuilder: (context, index) {
          final days = schedules[index];
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Text(
                  DateFormat('E - MMMM d, yyyy')
                      .format(DateTime.parse(days['day'].toString())),
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              ListView.builder(
                physics: const BouncingScrollPhysics(),
                shrinkWrap: true,
                itemCount: days['schedules_list'].length,
                itemBuilder: (context, index) {
                  final schedule = days['schedules_list'][index];
                  if (schedule['type'] == 2) {
                    return GestureDetector(
                      onTap: () => pushNewScreen(
                        context,
                        screen: TheoriticalViewScreen(
                          scheduleId: schedule['id'],
                        ),
                        withNavBar: false,
                      ),
                      child: InstructorTheoriticalContainerWidget(
                        schedule: schedule,
                      ),
                    );
                  }
                  return GestureDetector(
                    onTap: () => pushNewScreen(
                      context,
                      screen: PracticalViewScreen(
                        scheduleId: schedule['id'],
                      ),
                      withNavBar: false,
                    ),
                    child: InstructorPracticalContainerWidget(
                      schedule: schedule,
                    ),
                  );
                },
              ),
            ],
          );
        },
      ),
    );
  }
}
