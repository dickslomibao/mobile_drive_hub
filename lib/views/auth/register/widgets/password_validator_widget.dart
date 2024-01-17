import 'package:flutter/material.dart';

class PasswordValidatorWidget extends StatelessWidget {
  const PasswordValidatorWidget(
      {super.key, required this.isValid, required this.text});
  final bool isValid;
  final String text;
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(
          isValid ? Icons.check_circle : Icons.close_outlined,
          color: isValid ? Colors.green : Colors.red,
          size: 18,
        ),
        const SizedBox(
          width: 5,
        ),
        Text(
          text,
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w500,
            color: isValid ? Colors.green : Colors.red,
          ),
        ),
      ],
    );
  }
}
