import 'package:flutter/material.dart';

class DividerWidget extends StatelessWidget {
  const DividerWidget({super.key, required this.title});
  final String title;
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Container(
            height: 1,
            color: const Color.fromRGBO(0, 0, 0, .1),
          ),
        ),
        const SizedBox(
          width: 10,
        ),
         Text(
          title,
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w500,
          ),
        ),
        const SizedBox(
          width: 10,
        ),
        Expanded(
          child: Container(
            height: 1,
            color: const Color.fromRGBO(0, 0, 0, .1),
          ),
        ),
      ],
    );
  }
}
