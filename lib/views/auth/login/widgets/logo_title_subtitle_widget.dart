import 'package:flutter/material.dart';

import '../../../../constant/palette.dart';

class LogoTitleSubtitleWidget extends StatelessWidget {
  const LogoTitleSubtitleWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Image.asset(
          'assets/images/logo.png',
          height: 80,
        ),
        const SizedBox(
          height: 20,
        ),
        const Text.rich(
          TextSpan(
            text: "Welcome to\n",
            children: [
              TextSpan(
                text: 'Drive',
                style: TextStyle(
                  color: primaryBg,
                  fontWeight: FontWeight.w800,
                ),
              ),
              TextSpan(
                text: 'Hub',
                style: TextStyle(
                  color: secondaryBg,
                  fontWeight: FontWeight.w800,
                ),
              ),
            ],
          ),
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 28,
            fontWeight: FontWeight.w500,
          ),
        ),
        const SizedBox(
          height: 30,
        ),
        const Align(
          alignment: Alignment.topLeft,
          child: Text(
            'Sign in your account',
            style: TextStyle(
              fontSize: 23,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
        const SizedBox(
          height: 30,
        ),
      ],
    );
  }
}
