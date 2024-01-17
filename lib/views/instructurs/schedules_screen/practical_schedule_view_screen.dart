import 'package:flutter/material.dart';
import 'package:mobile_drive_hub/controllers/instructor/instructor_start_practical_controller.dart';
import 'package:mobile_drive_hub/controllers/instructor/view_schedules_controller.dart';
import 'package:mobile_drive_hub/services/geo_location.dart';
import 'package:mobile_drive_hub/views/instructurs/schedules_screen/report_screen.dart';
import 'package:mobile_drive_hub/views/shared_widget/loader_widget.dart';
import 'package:persistent_bottom_nav_bar_v2/persistent-tab-view.dart';
import 'package:provider/provider.dart';
import 'package:percent_indicator/percent_indicator.dart';
import '../../../constant/const_method.dart';
import '../../../constant/palette.dart';
import '../../../constant/url.dart';
import '../../../controllers/instructor/instructor_schedules_controller.dart';
import '../../shared_screen/messages/messages_screen.dart';
import '../appbar/insctructor_appbar_widget.dart';
import '../drive_screen/driving_screen.dart';
import 'widgets/filtering_button_widget.dart';
import 'package:intl/intl.dart';
import 'package:app_settings/app_settings.dart';

class PracticalViewScreen extends StatefulWidget {
  const PracticalViewScreen({super.key, required this.scheduleId});
  final int scheduleId;
  @override
  State<PracticalViewScreen> createState() => _PracticalViewScreenState();
}

class _PracticalViewScreenState extends State<PracticalViewScreen> {
  late Map<dynamic, dynamic> schedule;
  @override
  void initState() {
    super.initState();
    context
        .read<InstructorViewSchedulesController>()
        .getSingleInstructorSchedule(widget.scheduleId.toString());
    context.read<InstructorViewSchedulesController>().isLoading = true;
  }

  TextEditingController m = TextEditingController();
  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;

    final watch = context.watch<InstructorViewSchedulesController>();
    final schedule = watch.schedule;
    return Scaffold(
      backgroundColor: primaryBg,
      body: SafeArea(
        child: Container(
          height: height,
          color: backgroundMainColor,
          child: Stack(
            children: [
              const InstrcutorAppBarWidget(
                title: 'Schedule Details',
              ),
              Container(
                margin: const EdgeInsets.only(top: 60),
                height: height - 100 - 70,
                child: watch.isLoading
                    ? const Center(child: CircularProgressIndicator())
                    : SingleChildScrollView(
                        child: Column(
                          children: [
                            Container(
                              width: double.infinity,
                              color: secondaryMainColor,
                              padding: const EdgeInsets.all(15),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    children: [
                                      const Expanded(
                                        child: Text(
                                          'Schedule Information',
                                          style: TextStyle(
                                            fontSize: 18,
                                            fontWeight: FontWeight.w500,
                                          ),
                                        ),
                                      ),
                                      Container(
                                        padding: const EdgeInsets.all(10),
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          color: const Color.fromRGBO(
                                              0, 0, 0, .05),
                                        ),
                                        child: Text(
                                          sessionStatus(schedule['status']),
                                          style: const TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.w500,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(
                                    height: 18,
                                  ),
                                  const SizedBox(
                                    height: 5,
                                  ),
                                  Text(
                                    'Date: ${DateFormat('E - MMMM d, yyyy').format(DateTime.parse(schedule['start_date'].toString()))}',
                                    style: const TextStyle(
                                      fontSize: 17,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 5,
                                  ),
                                  Text(
                                    'From ${DateFormat('h:mm a').format(DateTime.parse(schedule['start_date'].toString()))} - To ${DateFormat('h:mm a').format(DateTime.parse(schedule['end_date'].toString()))}',
                                    style: const TextStyle(
                                      fontSize: 17,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 5,
                                  ),
                                  Text(
                                    'Session number: ${schedule['session']['session_number']}',
                                    style: const TextStyle(
                                      fontSize: 17,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 5,
                                  ),
                                  Text(
                                    'Total hours: ${schedule['total_hours']} hrs',
                                    style: const TextStyle(
                                      fontSize: 17,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 5,
                                  ),
                                  const Divider(),
                                  const SizedBox(
                                    height: 5,
                                  ),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        'Date started: ${watch.getStartDate()}',
                                        style: const TextStyle(
                                          fontSize: 17,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                      const SizedBox(
                                        height: 5,
                                      ),
                                      Text(
                                        'Date Ended: ${watch.getEndDate()}',
                                        style: const TextStyle(
                                          fontSize: 17,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                      const SizedBox(
                                        height: 5,
                                      ),
                                      Text(
                                        'Completed Hours: ${schedule['complete_hours']} hrs',
                                        style: const TextStyle(
                                          fontSize: 17,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                      const SizedBox(
                                        height: 5,
                                      ),
                                      const Divider(),
                                    ],
                                  ),
                                  Text(
                                    'Course name: ${schedule['course_name']}',
                                    style: const TextStyle(
                                      fontSize: 17,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                  Text(
                                    'Variants: ${schedule['course_duration']} hrs',
                                    style: const TextStyle(
                                      fontSize: 17,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  Row(
                                    children: [
                                      Expanded(
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              'Vehicle: ${schedule['vehicle']['name']}',
                                              style: const TextStyle(
                                                fontSize: 17,
                                                fontWeight: FontWeight.w500,
                                              ),
                                            ),
                                            Text(
                                              'Plate no: ${schedule['vehicle']['plate_number']}',
                                              style: const TextStyle(
                                                fontSize: 17,
                                                fontWeight: FontWeight.w500,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      GestureDetector(
                                        onTap: () {
                                          showModalBottomSheet(
                                            context: context,
                                            useSafeArea: true,
                                            builder: (context) {
                                              return Container(
                                                width: double.infinity,
                                                color: secondaryMainColor,
                                                padding:
                                                    const EdgeInsets.all(15),
                                                child: Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    const Text(
                                                      'Vehicle Information',
                                                      style: TextStyle(
                                                        fontSize: 18,
                                                        fontWeight:
                                                            FontWeight.w500,
                                                      ),
                                                    ),
                                                    const SizedBox(
                                                      height: 8,
                                                    ),
                                                    Text(
                                                      'Name: ${schedule['vehicle']['name']}',
                                                      style: const TextStyle(
                                                        fontSize: 17,
                                                        fontWeight:
                                                            FontWeight.w500,
                                                      ),
                                                    ),
                                                    const SizedBox(
                                                      height: 5,
                                                    ),
                                                    Text(
                                                      'Plate number: ${schedule['vehicle']['plate_number']}',
                                                      style: const TextStyle(
                                                        fontSize: 17,
                                                        fontWeight:
                                                            FontWeight.w500,
                                                      ),
                                                    ),
                                                    const SizedBox(
                                                      height: 5,
                                                    ),
                                                    Text(
                                                      'Transmission: ${schedule['vehicle']['transmission']}',
                                                      style: const TextStyle(
                                                        fontSize: 17,
                                                        fontWeight:
                                                            FontWeight.w500,
                                                      ),
                                                    ),
                                                    const SizedBox(
                                                      height: 5,
                                                    ),
                                                    Text(
                                                      'Model: ${schedule['vehicle']['model']}',
                                                      style: const TextStyle(
                                                        fontSize: 17,
                                                        fontWeight:
                                                            FontWeight.w500,
                                                      ),
                                                    ),
                                                    const SizedBox(
                                                      height: 5,
                                                    ),
                                                    Text(
                                                      'Fuel: ${schedule['vehicle']['fuel']}',
                                                      style: const TextStyle(
                                                        fontSize: 17,
                                                        fontWeight:
                                                            FontWeight.w500,
                                                      ),
                                                    ),
                                                    const SizedBox(
                                                      height: 5,
                                                    ),
                                                    Text(
                                                      'Color: ${schedule['vehicle']['Color']}',
                                                      style: const TextStyle(
                                                        fontSize: 17,
                                                        fontWeight:
                                                            FontWeight.w500,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              );
                                            },
                                          );
                                        },
                                        child: const Icon(
                                          Icons.info_outline,
                                        ),
                                      )
                                    ],
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(
                              height: 5,
                            ),
                            Container(
                              width: double.infinity,
                              color: secondaryMainColor,
                              padding: const EdgeInsets.all(15),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Text(
                                    'Student Information',
                                    style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 20,
                                  ),
                                  Row(
                                    children: [
                                      ClipOval(
                                        child: Image.network(
                                          WEBSITE_URL +
                                              schedule['students'][0]
                                                      ['profile_image']
                                                  .toString(),
                                          height: 35,
                                          width: 35,
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                      const SizedBox(
                                        width: 10,
                                      ),
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            schedule['students'][0]
                                                    ['firstname'] +
                                                " " +
                                                schedule['students'][0]
                                                    ['lastname'],
                                            style: const TextStyle(
                                              fontSize: 17,
                                              fontWeight: FontWeight.w500,
                                            ),
                                          ),
                                          Text(
                                            schedule['students'][0]['email'],
                                            style: const TextStyle(
                                              fontSize: 14,
                                              fontWeight: FontWeight.w500,
                                            ),
                                          ),
                                        ],
                                      ),
                                      const Spacer(),
                                      GestureDetector(
                                        onTap: () {
                                          pushNewScreen(
                                            context,
                                            screen: MessagesScreen(
                                              name: schedule['students'][0]
                                                      ['firstname'] +
                                                  " " +
                                                  schedule['students'][0]
                                                      ['lastname'],
                                              profile: WEBSITE_URL +
                                                  schedule['students'][0]
                                                      ['profile_image'],
                                              userId: schedule['students'][0]
                                                  ['student_id'],
                                            ),
                                            withNavBar: false,
                                          );
                                        },
                                        child: const Icon(
                                          Icons.chat_bubble_outline,
                                        ),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(
                                    height: 20,
                                  ),
                                  const Divider(),
                                  const SizedBox(
                                    height: 20,
                                  ),
                                  Row(
                                    children: [
                                      Expanded(
                                        child: Column(
                                          children: [
                                            CircularPercentIndicator(
                                              radius: 70.0,
                                              lineWidth: 10.0,
                                              percent: double.parse((schedule[
                                                              'students'][0]
                                                          ['completed_hrs'] /
                                                      schedule[
                                                          'course_duration'])
                                                  .toString()),
                                              center: Text(
                                                "${double.parse(((schedule['students'][0]['completed_hrs'] / schedule['course_duration']) * 100).toString()).toStringAsFixed(1)}%",
                                                style: const TextStyle(
                                                  fontSize: 18,
                                                  fontWeight: FontWeight.w500,
                                                ),
                                              ),
                                              progressColor: Colors.green,
                                            ),
                                            const SizedBox(
                                              height: 20,
                                            ),
                                            const Text(
                                              'Completed Hours',
                                              style: TextStyle(
                                                fontSize: 18,
                                                fontWeight: FontWeight.w500,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      Expanded(
                                        child: Column(
                                          children: [
                                            CircularPercentIndicator(
                                              radius: 70.0,
                                              lineWidth: 10.0,
                                              percent: watch
                                                  .studentProgressPercentage(),
                                              center: Text(
                                                "${(watch.studentProgressPercentage() * 100).toStringAsFixed(2)}%",
                                                style: const TextStyle(
                                                  fontSize: 18,
                                                  fontWeight: FontWeight.w500,
                                                ),
                                              ),
                                              progressColor: Colors.green,
                                            ),
                                            const SizedBox(
                                              height: 20,
                                            ),
                                            const Text(
                                              'Progress',
                                              style: TextStyle(
                                                fontSize: 18,
                                                fontWeight: FontWeight.w500,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                          ],
                        ),
                      ),
              ),
              Visibility(
                visible: [1, 2].contains(schedule['status']),
                child: Positioned(
                  bottom: 0,
                  child: Container(
                    color: secondaryMainColor,
                    height: 75,
                    width: width,
                    padding: const EdgeInsets.all(10),
                    child: Row(
                      children: [
                        Expanded(
                          child: SizedBox(
                            height: 70,
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                elevation: 0,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20),
                                ),
                              ),
                              onPressed: () async {
                                final r =
                                    await geoLocationServices.getPermission();

                                if (context.mounted) {
                                  if (r == "granted") {
                                    showDialog(
                                      context: context,
                                      barrierDismissible: true,
                                      builder: (_) => AlertDialog(
                                        content: SingleChildScrollView(
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              const Text(
                                                'Starting Mileage:',
                                                style: TextStyle(
                                                  fontSize: 18,
                                                  fontWeight: FontWeight.w500,
                                                ),
                                              ),
                                              const SizedBox(
                                                height: 12,
                                              ),
                                              TextFormField(
                                                controller: m,
                                                keyboardType:
                                                    TextInputType.number,
                                                decoration:
                                                    const InputDecoration(
                                                  border: OutlineInputBorder(),
                                                ),
                                              ),
                                              Container(
                                                height: 48,
                                                margin: const EdgeInsets.only(
                                                  top: 10,
                                                ),
                                                width: double.infinity,
                                                child: ElevatedButton(
                                                  onPressed: () async {
                                                    if (m.text == "") {
                                                      showDialog(
                                                        context: context,
                                                        builder: (context) =>
                                                            const AlertDialog(
                                                          content: Text(
                                                              'Mileage is required.'),
                                                        ),
                                                      );
                                                    } else {
                                                      Navigator.pop(context);
                                                      showDialog(
                                                        context: context,
                                                        barrierDismissible:
                                                            true,
                                                        builder: (context) =>
                                                            const LoadingWidget(),
                                                      );
                                                      final s = await context
                                                          .read<
                                                              InstructorStartSchedulesController>()
                                                          .startSchedule(
                                                              schedule['id']
                                                                  .toString(),
                                                              m.text);
                                                      if (context.mounted) {
                                                        Navigator.pop(context);
                                                        if (s == "success") {
                                                          Navigator.of(context)
                                                              .push(
                                                            MaterialPageRoute(
                                                              builder: (context) =>
                                                                  const DrivingScreen(),
                                                            ),
                                                          );
                                                        } else {
                                                          showDialog(
                                                            context: context,
                                                            builder:
                                                                (context) =>
                                                                    AlertDialog(
                                                              content: Text(s),
                                                            ),
                                                          );
                                                        }
                                                      }
                                                    }
                                                  },
                                                  child: const Text(
                                                    'Start',
                                                  ),
                                                ),
                                              )
                                            ],
                                          ),
                                        ),
                                      ),
                                    );
                                  } else {
                                    AppSettings.openAppSettings(
                                        type: AppSettingsType.location);
                                  }
                                }
                              },
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  const Icon(Icons.navigation_sharp),
                                  const SizedBox(
                                    width: 10,
                                  ),
                                  Text(
                                    schedule['status'] == 1
                                        ? 'Start session'
                                        : 'Continue session',
                                    style: const TextStyle(
                                      fontSize: 18,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Visibility(
                visible: [3].contains(schedule['status']) &&
                    schedule['report'] == false,
                child: Positioned(
                  bottom: 0,
                  child: Container(
                    color: secondaryMainColor,
                    height: 75,
                    width: width,
                    padding: const EdgeInsets.all(10),
                    child: Row(
                      children: [
                        Expanded(
                          child: SizedBox(
                            height: 70,
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                elevation: 0,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20),
                                ),
                              ),
                              onPressed: () async {
                                Navigator.of(context).push(
                                  MaterialPageRoute(
                                    builder: (context) => ScheduleReport(
                                      scheduleId: widget.scheduleId.toString(),
                                    ),
                                  ),
                                );
                              },
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: const [
                                  Text(
                                    "Make a report",
                                    style: TextStyle(
                                      fontSize: 18,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
