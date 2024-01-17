import 'package:flutter/material.dart';
import 'package:mobile_drive_hub/constant/url.dart';
import 'package:mobile_drive_hub/services/profile_services.dart';

import '../../../constant/palette.dart';
import '../../../services/hive_services.dart';
import '../../../services/token_services.dart';
import '../../splash/last_screen.dart';

class InstrcutorAppBarWidget extends StatefulWidget {
  const InstrcutorAppBarWidget(
      {super.key, required this.title, this.leading = false});
  final String title;
  final bool leading;
  @override
  State<InstrcutorAppBarWidget> createState() => _InstrcutorAppBarWidgetState();
}

class _InstrcutorAppBarWidgetState extends State<InstrcutorAppBarWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: primaryBg,
      padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 10),
      // decoration: BoxDecoration(
      //   border: Border.all(
      //     color: const Color.fromRGBO(0, 0, 0, .1),
      //   ),
      // ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
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
              ClipOval(
                child: Image.network(
                  WEBSITE_URL + hiveServices.getProfile(),
                  width: 30,
                  height: 30,
                  fit: BoxFit.cover,
                ),
              ),
              const SizedBox(
                width: 15,
              ),
              Text(
                widget.title,
                style: const TextStyle(
                  fontSize: 21,
                  fontWeight: FontWeight.w500,
                  color: Colors.white,
                ),
              ),
            ],
          ),
          Row(
            children: [
              // const Icon(
              //   Icons.search,
              //   size: 25,
              //   color: Colors.white,
              // ),

              // Stack(
              //   children: const [
              //     Icon(
              //       Icons.notifications_none_rounded,
              //       size: 25,
              //       color: Colors.white,
              //     ),
              //     Positioned(
              //       right: 0,
              //       child: CircleAvatar(
              //         backgroundColor: secondaryBg,
              //         radius: 8,
              //         child: Text(
              //           "99",
              //           style: TextStyle(
              //             color: Colors.white,
              //             fontSize: 10,
              //             fontWeight: FontWeight.w600,
              //           ),
              //         ),
              //       ),
              //     )
              //   ],
              // ),
              // const SizedBox(width: 10),
              GestureDetector(
                child: const Icon(
                  Icons.logout_rounded,
                  size: 25,
                  color: Colors.white,
                ),
                onTap: () async {
                  await tokenServices.clearToken();
                  if (context.mounted) {
                    Navigator.of(context, rootNavigator: true)
                        .pushAndRemoveUntil(
                      MaterialPageRoute(
                        builder: (context) => LastSplashScreen(),
                      ),
                      (route) => false,
                    );
                  }
                },
              ),
            ],
          )
        ],
      ),
    );
  }
}
