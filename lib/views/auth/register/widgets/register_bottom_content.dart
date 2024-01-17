import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:mobile_drive_hub/views/auth/login/login.dart';
import 'package:mobile_drive_hub/views/auth/register/register_screen.dart';

import '../../../../constant/palette.dart';

class RegisterBottomContentWidget extends StatelessWidget {
  const RegisterBottomContentWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        const SizedBox(
          height: 30,
        ),
        Text.rich(
          TextSpan(
            text: "Already have an account? ",
            children: [
              TextSpan(
                recognizer: TapGestureRecognizer()
                  ..onTap = () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => LoginScreen(),
                      ),
                    );
                  },
                text: 'Sign in',
                style: const TextStyle(
                  color: primaryBg,
                ),
              ),
            ],
          ),
          textAlign: TextAlign.center,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }
}
