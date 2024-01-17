import 'package:flutter/material.dart';
import 'package:mobile_drive_hub/constant/palette.dart';
import 'package:persistent_bottom_nav_bar_v2/persistent-tab-view.dart';

import '../order_view_screen.dart';

class OrderButtonsWidget extends StatelessWidget {
  const OrderButtonsWidget({super.key, required this.orderId});
  final String orderId;
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        // Expanded(
        //   child: SizedBox(
        //     height: 42,
        //     child: ElevatedButton(
        //       style: ElevatedButton.styleFrom(
        //         elevation: 0,
        //         backgroundColor: const Color.fromRGBO(0, 0, 0, .05),
        //       ),
        //       onPressed: () {},
        //       child: const Text(
        //         'Cancel',
        //         style: TextStyle(
        //           color: Colors.black,
        //           fontSize: 15,
        //           fontWeight: FontWeight.w500,
        //         ),
        //       ),
        //     ),
        //   ),
        // ),
        // const SizedBox(
        //   width: 20,
        // ),
        Expanded(
          flex: 2,
          child: SizedBox(
            height: 42,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                  elevation: 0, backgroundColor: secondaryBg),
              onPressed: () {},
              child: const Text(
                'View order',
                style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w500,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
