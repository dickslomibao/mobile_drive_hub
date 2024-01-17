import 'dart:async';

import 'package:flutter/material.dart';
import 'package:mobile_drive_hub/controllers/instructor/instructor_start_practical_controller.dart';
import 'package:provider/provider.dart';

import '../../../constant/palette.dart';
import '../../../controllers/instructor/view_schedules_controller.dart';

class TimerWidget extends StatefulWidget {
  const TimerWidget(
      {super.key,
      required this.startTime,
      required this.now,
      this.theoritical = false});
  final String startTime;
  final String now;
  final bool theoritical;
  @override
  State<TimerWidget> createState() => _TimerWidgetState();
}

class _TimerWidgetState extends State<TimerWidget> {
  late DateTime startTime;
  Duration _currentDuration = Duration(hours: 1, minutes: 30);
  late Timer _timer;
  @override
  void initState() {
    super.initState();
    startTime = DateTime.parse(widget.startTime);
    startTimer();
  }

  void startTimer() {
    DateTime currentTime = DateTime.parse(widget.now);
    if (currentTime.isAfter(startTime)) {
      _currentDuration = currentTime.difference(startTime);
    } else {
      _currentDuration = Duration.zero;
    }
    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      setState(() {
        _currentDuration = _currentDuration + Duration(seconds: 1);

        context.read<InstructorStartSchedulesController>().current =
            _currentDuration;

        context.read<InstructorViewSchedulesController>().current =
            _currentDuration;
      });
    });
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Text(
      "${_currentDuration.inHours.toString().padLeft(2, '0')}:${(_currentDuration.inMinutes % 60).toString().padLeft(2, '0')}:${(_currentDuration.inSeconds % 60).toString().padLeft(2, '0')}",
      style: TextStyle(
        fontSize: 21,
        fontWeight: FontWeight.w500,
        color: secondaryBg,
      ),
    );
  }
}
