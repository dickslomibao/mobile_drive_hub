import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../controllers/student/schedules/schedules_controller.dart';
import 'widgets/practical_container_widget.dart';
import 'widgets/theoritical_container_widget.dart';
import 'package:intl/intl.dart';

class CompletedSchedule extends StatelessWidget {
  const CompletedSchedule({super.key});

  @override
  Widget build(BuildContext context) {
    final schedules =
        context.watch<StudentSchedulesController>().getCompleted();
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
              Text(
                DateFormat('E - MMMM d, yyyy')
                    .format(DateTime.parse(days['day'].toString())),
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w500,
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
                  if (schedule['type'] == 1) {
                    return PracticalContainerWidget(
                      schedule: schedule,
                    );
                  } else {
                    return TheoriticalContianerWidget(
                      schedule: schedule,
                    );
                  }
                },
              )
            ],
          );
        },
      ),
    );
  }
}
