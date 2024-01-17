import 'package:flutter/material.dart';

import '../../../../constant/palette.dart';

class RegisterLogoTitleSubtitleWidget extends StatelessWidget {
  const RegisterLogoTitleSubtitleWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        const SizedBox(
          height: 50,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              'assets/logo/logo.png',
              height: 70,
            ),
            SizedBox(
              width: 10,
            ),
            Image.asset(
              'assets/logo/logo-text.png',
              height: 60,
            ),
          ],
        ),
        const SizedBox(
          height: 50,
        ),
      ],
    );
  }
}
