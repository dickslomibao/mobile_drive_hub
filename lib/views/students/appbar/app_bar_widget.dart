import 'package:flutter/material.dart';
import 'package:mobile_drive_hub/constant/url.dart';
import 'package:mobile_drive_hub/services/hive_services.dart';
import 'package:mobile_drive_hub/views/students/profile_screen/profile_screen.dart';

import '../../../constant/palette.dart';
import '../../../services/token_services.dart';
import '../../splash/last_screen.dart';

class AppBarWidget extends StatefulWidget {
  const AppBarWidget({super.key, required this.title, this.leading = false});
  final String title;
  final bool leading;
  @override
  State<AppBarWidget> createState() => _AppBarWidgetState();
}

class _AppBarWidgetState extends State<AppBarWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
      decoration: const BoxDecoration(
        color: primaryBg,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          if (widget.leading)
            GestureDetector(
              onTap: () {
                Navigator.of(context).pop();
              },
              child: const Icon(
                Icons.arrow_back_ios_new,
                size: 25,
                color: Colors.white,
              ),
            ),
          if (widget.leading)
            const SizedBox(
              width: 5,
            ),
          GestureDetector(
            onTap: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => StudentProfileScreen(),
                ),
              );
            },
            child: ClipOval(
              child: Image.network(
                WEBSITE_URL + hiveServices.getProfile(),
                width: 35,
                height: 35,
                fit: BoxFit.cover,
              ),
            ),
          ),
          const SizedBox(
            width: 20,
          ),
          Text(
            widget.title,
            style: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w500,
              color: Colors.white,
            ),
          ),
          Spacer(),
          GestureDetector(
            child: const Icon(
              Icons.logout_rounded,
              size: 25,
              color: Colors.white,
            ),
            onTap: () async {
              await tokenServices.clearToken();
              if (context.mounted) {
                Navigator.of(context, rootNavigator: true).pushAndRemoveUntil(
                  MaterialPageRoute(
                    builder: (context) => LastSplashScreen(),
                  ),
                  (route) => false,
                );
              }
            },
          ),
          // Row(
          //   children: [
          //     // Stack(
          //     //   children: const [
          //     //     Icon(
          //     //       Icons.notifications_none_rounded,
          //     //       size: 25,
          //     //       color: Colors.white,
          //     //     ),
          //     //     Positioned(
          //     //       right: 0,
          //     //       child: CircleAvatar(
          //     //         backgroundColor: secondaryBg,
          //     //         radius: 8,
          //     //         child: Text(
          //     //           "99",
          //     //           style: TextStyle(
          //     //             color: Colors.white,
          //     //             fontSize: 10,
          //     //             fontWeight: FontWeight.w600,
          //     //           ),
          //     //         ),
          //     //       ),
          //     //     )
          //     //   ],
          //     // ),
          //     const SizedBox(
          //       width: 15,
          //     ),

          //   ],
          // )
        ],
      ),
    );
  }
}
