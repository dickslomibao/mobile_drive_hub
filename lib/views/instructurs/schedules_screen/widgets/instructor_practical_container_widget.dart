import 'package:flutter/material.dart';
import 'package:mobile_drive_hub/views/instructurs/drive_screen/drive_screen.dart';

import '../../../../constant/palette.dart';
import 'package:intl/intl.dart';

import '../../../../constant/url.dart';

class InstructorPracticalContainerWidget extends StatelessWidget {
  const InstructorPracticalContainerWidget({super.key, required this.schedule});
  final Map<String, dynamic> schedule;
  @override
  Widget build(BuildContext context) {
    print(schedule);
    return Container(
      margin: const EdgeInsets.only(bottom: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 15),
            child: Text(
              "${DateFormat('h:mm a').format(DateTime.parse(schedule['start_date'].toString()))} - ${DateFormat('h:mm a').format(DateTime.parse(schedule['end_date'].toString()))}",
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          const SizedBox(
            height: 15,
          ),
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
              color: backgroundMainColor,
            ),
            padding: const EdgeInsets.all(15),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text(
                      'Session ${schedule['session']['session_number']}',
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    const Spacer(),
                    Row(
                      children: [
                        const Icon(
                          Icons.timer_outlined,
                          size: 18,
                        ),
                        const SizedBox(
                          width: 5,
                        ),
                        Text(
                          "${schedule['total_hours']} hrs",
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                          ),
                        )
                      ],
                    )
                  ],
                ),
                const SizedBox(
                  height: 10,
                ),
                Text(
                  'Course Name: ${schedule['course_name']}',
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                Text(
                  'Variant: ${schedule['course_duration']} hrs',
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                const Text(
                  'Student:',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Row(
                  children: [
                    ClipOval(
                      child: Image.network(
                        WEBSITE_URL +
                            schedule['students'][0]['profile_image'].toString(),
                        height: 30,
                        width: 30,
                        fit: BoxFit.cover,
                      ),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          schedule['students'][0]['firstname'] +
                              " " +
                              schedule['students'][0]['lastname'],
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        Text(
                          schedule['students'][0]['email'],
                          style: const TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                const SizedBox(
                  height: 10,
                ),
                Text(
                  'Vehicle: ${schedule['vehicle']['name']}',
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}


//     return Container(
//       margin: const EdgeInsets.only(bottom: 20),
//       child: GestureDetector(
//         onTap: () {
//           Navigator.of(context).push(
//             MaterialPageRoute(
//               builder: (context) => DriveScreen(),
//             ),
//           );
//         },
//         child: Row(
//           crossAxisAlignment: CrossAxisAlignment.center,
//           children: [
//             Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Text(
//                   DateFormat('h:mm a').format(
//                       DateTime.parse(schedule['start_date'].toString())),
//                   style: const TextStyle(
//                     fontSize: 16,
//                     fontWeight: FontWeight.w500,
//                   ),
//                 ),
//                 const SizedBox(
//                   height: 5,
//                 ),
//                 Text(
//                   DateFormat('h:mm a')
//                       .format(DateTime.parse(schedule['end_date'].toString())),
//                   style: const TextStyle(
//                     fontSize: 16,
//                     fontWeight: FontWeight.w500,
//                   ),
//                 ),
//               ],
//             ),
//             const SizedBox(
//               width: 10,
//             ),
//             Expanded(
//               child: Container(
//                 decoration: BoxDecoration(
//                   borderRadius: BorderRadius.circular(15),
//                   color: secondaryBg,
//                 ),
//                 padding: const EdgeInsets.all(15),
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     Row(
//                       children: [
//                         Text(
//                           'Session ${schedule['practical']['session_number']}',
//                           style: const TextStyle(
//                             fontSize: 16,
//                             fontWeight: FontWeight.w500,
//                             color: Colors.white,
//                           ),
//                         ),
//                         const Spacer(),
//                         Row(
//                           children: [
//                             const Icon(
//                               Icons.timer_outlined,
//                               size: 18,
//                               color: Colors.white,
//                             ),
//                             const SizedBox(
//                               width: 5,
//                             ),
//                             Text(
//                               "${schedule['total_hours']} hrs",
//                               style: const TextStyle(
//                                 color: Colors.white,
//                                 fontSize: 16,
//                                 fontWeight: FontWeight.w500,
//                               ),
//                             )
//                           ],
//                         )
//                       ],
//                     ),
//                     // const SizedBox(
//                     //   height: 10,
//                     // ),
//                     // Text(
//                     //   'School: ${schedule['name']}',
//                     //   style: const TextStyle(
//                     //     fontSize: 16,
//                     //     color: Colors.white,
//                     //     fontWeight: FontWeight.w500,
//                     //   ),
//                     // ),
//                     const SizedBox(
//                       height: 10,
//                     ),
//                     Row(
//                       children: [
//                         ClipOval(
//                           child: Image.network(
//                             WEBSITE_URL +
//                                 schedule['students'][0]['profile_image']
//                                     .toString(),
//                             height: 30,
//                             width: 30,
//                             fit: BoxFit.cover,
//                           ),
//                         ),
//                         const SizedBox(
//                           width: 10,
//                         ),
//                         Column(
//                           crossAxisAlignment: CrossAxisAlignment.start,
//                           children: [
//                             Text(
//                               schedule['students'][0]['firstname'] +
//                                   " " +
//                                   schedule['students'][0]['lastname'],
//                               style: const TextStyle(
//                                 fontSize: 16,
//                                 color: Colors.white,
//                                 fontWeight: FontWeight.w500,
//                               ),
//                             ),
//                             Text(
//                               schedule['students'][0]['email'],
//                               style: const TextStyle(
//                                 fontSize: 12,
//                                 color: Colors.white,
//                                 fontWeight: FontWeight.w500,
//                               ),
//                             ),
//                           ],
//                         ),
//                       ],
//                     ),
//                     const SizedBox(
//                       height: 10,
//                     ),
//                     Text(
//                       'Vehicle: ${schedule['vehicle']['name']}',
//                       style: const TextStyle(
//                         fontSize: 16,
//                         color: Colors.white,
//                         fontWeight: FontWeight.w500,
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
