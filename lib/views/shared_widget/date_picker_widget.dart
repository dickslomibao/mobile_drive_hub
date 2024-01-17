import 'package:flutter/material.dart';

import '../../constant/palette.dart';

class DatePickerFormWidgetBuilder extends StatelessWidget {
  const DatePickerFormWidgetBuilder({
    super.key,
    required this.label,
    required this.controller,
    required this.validator,
    required this.onTap,
  });
  final String label;
  final TextEditingController controller;
  final dynamic validator;
  final dynamic onTap;
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w500,
          ),
        ),
        const SizedBox(
          height: 10,
        ),
        TextFormField(
          controller: controller,
          validator: validator,
          readOnly: true,
          onTap: () {
            onTap();
          },
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w500,
            decoration: TextDecoration.none,
          ),
          decoration: InputDecoration(
            suffixIcon: Icon(Icons.date_range_rounded),
            contentPadding: const EdgeInsets.symmetric(
              vertical: 0,
              horizontal: 10,
            ),
            focusedErrorBorder: OutlineInputBorder(
              borderSide: const BorderSide(
                color: Colors.red,
                width: 1,
              ),
              borderRadius: BorderRadius.circular(5),
            ),
            errorBorder: OutlineInputBorder(
              borderSide: const BorderSide(
                color: Colors.red,
                width: 1,
              ),
              borderRadius: BorderRadius.circular(5),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: const BorderSide(
                color: primaryBg,
                width: 1,
              ),
              borderRadius: BorderRadius.circular(5),
            ),
            enabledBorder: OutlineInputBorder(
              gapPadding: 0,
              borderSide: const BorderSide(
                width: 1,
                color: Color.fromRGBO(0, 0, 0, .3),
              ),
              borderRadius: BorderRadius.circular(5),
            ),
          ),
        ),
      ],
    );
  }
}
