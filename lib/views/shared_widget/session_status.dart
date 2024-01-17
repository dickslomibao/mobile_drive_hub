import 'package:flutter/material.dart';

import '../../constant/palette.dart';

class SessionStatus extends StatelessWidget {
  const SessionStatus({super.key, required this.status});
  final status;
  @override
  Widget build(BuildContext context) {
    if (status == 1) {
      return Container(
        padding: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: waiting,
        ),
        child: const Text(
          'Waiting',
          style: TextStyle(
            fontSize: 15,
            fontWeight: FontWeight.w500,
            color: Colors.white,
          ),
        ),
      );
    }
    if (status == 2) {
      return Container(
        padding: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: ongoing,
        ),
        child: const Text(
          'Started',
          style: TextStyle(
            fontSize: 15,
            fontWeight: FontWeight.w500,
            color: Colors.white,
          ),
        ),
      );
    }
    if (status == 3) {
      return Container(
        padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: completed,
        ),
        child: const Text(
          'Completed',
          style: TextStyle(
            fontSize: 15,
            fontWeight: FontWeight.w500,
            color: Colors.white,
          ),
        ),
      );
    }
    return SizedBox();
  }
}
