import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../constant/palette.dart';
import '../../controllers/instructor/instructor_start_practical_controller.dart';

class PasswordFormWidgetBuilder extends StatefulWidget {
  const PasswordFormWidgetBuilder({
    super.key,
    required this.label,
    required this.controller,
    required this.validator,
    this.hint = "",
    required this.onChange,
  });
  final String label;
  final TextEditingController controller;
  final dynamic validator;
  final String hint;
  final dynamic onChange;

  @override
  State<PasswordFormWidgetBuilder> createState() =>
      _PasswordFormWidgetBuilderState();
}

class _PasswordFormWidgetBuilderState extends State<PasswordFormWidgetBuilder> {
  bool hide = true;

  @override
  Widget build(BuildContext context) {
    final schedule =
        context.read<InstructorStartSchedulesController>().schedule;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          widget.label,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w500,
          ),
        ),
        const SizedBox(
          height: 10,
        ),
        TextFormField(
          controller: widget.controller,
          validator: widget.validator,
          obscureText: hide,
          onChanged: (val) {
            return widget.onChange(val);
          },
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w500,
            decoration: TextDecoration.none,
          ),
          decoration: InputDecoration(
            hintText: widget.hint,
            contentPadding: const EdgeInsets.symmetric(
              vertical: 0,
              horizontal: 10,
            ),
            focusedErrorBorder: OutlineInputBorder(
              borderSide: const BorderSide(
                color: primaryBg,
                width: 1,
              ),
              borderRadius: BorderRadius.circular(10),
            ),
            suffixIcon: GestureDetector(
                onTap: () {
                  setState(() {
                    hide = !hide;
                  });
                },
                child: const Icon(Icons.visibility)),
            errorBorder: OutlineInputBorder(
              borderSide: const BorderSide(
                color: Colors.red,
                width: 1,
              ),
              borderRadius: BorderRadius.circular(10),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: const BorderSide(
                color: primaryBg,
                width: 1,
              ),
              borderRadius: BorderRadius.circular(10),
            ),
            enabledBorder: OutlineInputBorder(
              gapPadding: 0,
              borderSide: const BorderSide(
                width: 1,
                color: Color.fromRGBO(0, 0, 0, .1),
              ),
              borderRadius: BorderRadius.circular(10),
            ),
          ),
        ),
      ],
    );
  }
}
