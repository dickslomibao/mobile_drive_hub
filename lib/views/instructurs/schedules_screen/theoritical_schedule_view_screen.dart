import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:mobile_drive_hub/controllers/instructor/view_schedules_controller.dart';
import 'package:mobile_drive_hub/views/instructurs/drive_screen/timer_widget.dart';
import 'package:mobile_drive_hub/views/instructurs/schedules_screen/end_screen.dart';
import 'package:mobile_drive_hub/views/instructurs/schedules_screen/student_theoritical_view.dart';
import 'package:mobile_drive_hub/views/shared_widget/loader_widget.dart';
import 'package:mobile_drive_hub/views/shared_widget/text_form_widget_noprefix.dart';
import 'package:provider/provider.dart';
import 'package:quickalert/quickalert.dart';

import '../../../constant/const_method.dart';
import '../../../constant/palette.dart';
import '../../../constant/url.dart';
import '../../../controllers/instructor/instructor_schedules_controller.dart';
import '../appbar/insctructor_appbar_widget.dart';
import 'widgets/filtering_button_widget.dart';
import 'package:intl/intl.dart';

class TheoriticalViewScreen extends StatefulWidget {
  const TheoriticalViewScreen({super.key, required this.scheduleId});
  final int scheduleId;
  @override
  State<TheoriticalViewScreen> createState() => _TheoriticalViewScreenState();
}

class _TheoriticalViewScreenState extends State<TheoriticalViewScreen> {
  late Map<dynamic, dynamic> schedule;
  @override
  void initState() {
    super.initState();
    context
        .read<InstructorViewSchedulesController>()
        .getSingleInstructorSchedule(widget.scheduleId.toString());
    context.read<InstructorViewSchedulesController>().isLoading = true;
  }

  TextEditingController itemCountController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    final watch = context.watch<InstructorViewSchedulesController>();
    final read = context.read<InstructorViewSchedulesController>();
    final schedule = watch.schedule;

    Future<void> createMockExam(int mockExamCount) async {
      showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) => LoadingWidget(),
      );
      final r = await read.createMockExam(
          int.parse(itemCountController.text.toString()), mockExamCount);
      if (context.mounted) {
        Navigator.of(context).pop();
        if (r == 'success') {
          itemCountController.clear();
          QuickAlert.show(
            context: context,
            barrierDismissible: false,
            type: QuickAlertType.success,
            title: "Assigned Successfully!",
            text: "",
            widget: const Text(
              'Enjoy teaching.',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w400,
              ),
            ),
            cancelBtnTextStyle: const TextStyle(
              fontSize: 17,
              fontWeight: FontWeight.w500,
            ),
            confirmBtnColor: primaryBg,
            confirmBtnTextStyle: const TextStyle(
              fontSize: 17,
              fontWeight: FontWeight.w500,
              color: Colors.white,
            ),
            confirmBtnText: 'Okay',
            onConfirmBtnTap: () {
              Navigator.of(context).pop();
              Navigator.of(context).pop();
            },
          );
        } else {
          QuickAlert.show(
            context: context,
            type: QuickAlertType.error,
            title: "Oppss.",
            text: "",
            widget: Text(
              r,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w400,
              ),
            ),
            cancelBtnTextStyle: const TextStyle(
              fontSize: 17,
              fontWeight: FontWeight.w500,
            ),
            confirmBtnColor: primaryBg,
            confirmBtnTextStyle: const TextStyle(
              fontSize: 17,
              fontWeight: FontWeight.w500,
              color: Colors.white,
            ),
            confirmBtnText: 'Okay',
            onConfirmBtnTap: () {
              Navigator.of(context).pop();
            },
          );
        }
      }
    }

    Future<void> openModal(int mockCOunt) async {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          content: SingleChildScrollView(
            child: Container(
              width: width,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Assign First Mock Exam:',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  TextFormWidgetNoPrefixBuilder(
                    label: "Total Item: ",
                    controller: itemCountController,
                    validator: (val) {},
                    type: TextInputType.number,
                    hintText: "",
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  SizedBox(
                    width: double.infinity,
                    height: 52,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        elevation: 0,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15),
                        ),
                      ),
                      onPressed: () async {
                        await createMockExam(mockCOunt);
                      },
                      child: Text(
                        'Create Exam',
                        style: const TextStyle(
                          fontSize: 18,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      );
    }

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
                margin: const EdgeInsets.only(top: 65),
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
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      const Text(
                                        'Schedule Information',
                                        style: TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                      Container(
                                        padding: const EdgeInsets.all(10),
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          color: Color.fromRGBO(0, 0, 0, .05),
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
                                    height: 15,
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
                                    'Total hours: ${schedule['total_hours']} hrs',
                                    style: const TextStyle(
                                      fontSize: 17,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  if (schedule['status'] == 2)
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        const Divider(),
                                        const Text(
                                          'Consumed Hours:',
                                          style: TextStyle(
                                            fontSize: 17,
                                            fontWeight: FontWeight.w500,
                                          ),
                                        ),
                                        const SizedBox(
                                          height: 5,
                                        ),
                                        TimerWidget(
                                          startTime: read.getStartDate(),
                                          now: schedule['now'],
                                        ),
                                      ],
                                    ),
                                  if (schedule['status'] == 3)
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        const Divider(),
                                        const SizedBox(
                                          height: 10,
                                        ),
                                        Text(
                                          'Date Started: ${DateFormat('E - MMM d, yyyy - h:mm a').format(DateTime.parse(watch.getStartDate()))}',
                                          style: const TextStyle(
                                            fontSize: 17,
                                            fontWeight: FontWeight.w500,
                                          ),
                                        ),
                                        Text(
                                          'Date End: ${DateFormat('E - MMM d, yyyy - h:mm a').format(DateTime.parse(watch.getEndDate()))}',
                                          style: const TextStyle(
                                            height: 1.5,
                                            fontSize: 17,
                                            fontWeight: FontWeight.w500,
                                          ),
                                        ),
                                        Text(
                                          'Completed Hours: ${schedule['complete_hours']} hrs',
                                          style: const TextStyle(
                                            height: 1.5,
                                            fontSize: 17,
                                            fontWeight: FontWeight.w500,
                                          ),
                                        ),
                                        const SizedBox(
                                          height: 5,
                                        ),
                                      ],
                                    ),
                                ],
                              ),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            Container(
                              width: double.infinity,
                              color: secondaryMainColor,
                              padding: const EdgeInsets.all(15),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    children: [
                                      const Text(
                                        'List of Students',
                                        style: TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                      Spacer(),
                                      Visibility(
                                        visible: schedule['status'] == 2,
                                        child: GestureDetector(
                                          onTap: () {
                                            showModalBottomSheet(
                                              context: context,
                                              useSafeArea: true,
                                              builder: (context) {
                                                return SingleChildScrollView(
                                                  child: Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      GestureDetector(
                                                        onTap: () {
                                                          openModal(1);
                                                        },
                                                        child: const Padding(
                                                          padding:
                                                              EdgeInsets.all(
                                                                  15.0),
                                                          child: Text(
                                                            'Assign First Mock Exam',
                                                            style: TextStyle(
                                                              fontSize: 17,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w500,
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                      GestureDetector(
                                                        onTap: () {
                                                          openModal(2);
                                                        },
                                                        child: const Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                  .all(15.0),
                                                          child: Text(
                                                            'Assign Second Mock Exam',
                                                            style: TextStyle(
                                                              fontSize: 17,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w500,
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                      GestureDetector(
                                                        onTap: () {
                                                          openModal(3);
                                                        },
                                                        child: const Padding(
                                                          padding:
                                                              EdgeInsets.all(
                                                                  15.0),
                                                          child: Text(
                                                            'Assign Third Mock Exam',
                                                            style: TextStyle(
                                                              fontSize: 17,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w500,
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                );
                                              },
                                            );
                                          },
                                          child: Icon(Icons.more_vert_rounded),
                                        ),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(
                                    height: 15,
                                  ),
                                  ListView.builder(
                                    itemCount: schedule['students'].length,
                                    shrinkWrap: true,
                                    itemBuilder: (context, index) {
                                      final s = schedule['students'][index];
                                      return GestureDetector(
                                        onTap: () {
                                          Navigator.of(context).push(
                                            MaterialPageRoute(
                                              builder: (context) =>
                                                  StudenViewTheoritical(
                                                studentId: s['student_id'],
                                                orderListId: s['order_list_id'],
                                              ),
                                            ),
                                          );
                                        },
                                        child: Padding(
                                          padding: const EdgeInsets.only(
                                              bottom: 15.0),
                                          child: Row(
                                            children: [
                                              ClipOval(
                                                child: Image.network(
                                                  WEBSITE_URL +
                                                      s['profile_image']
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
                                                    s['firstname'] +
                                                        " " +
                                                        s['lastname'],
                                                    style: const TextStyle(
                                                      fontSize: 17,
                                                      fontWeight:
                                                          FontWeight.w500,
                                                    ),
                                                  ),
                                                  Text(
                                                    s['email'],
                                                    style: const TextStyle(
                                                      fontSize: 12,
                                                      fontWeight:
                                                          FontWeight.w500,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                        ),
                                      );
                                    },
                                  )
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
              ),
              if (schedule['status'] != 3)
                Positioned(
                  bottom: 0,
                  child: Container(
                    height: 82,
                    width: width,
                    padding: const EdgeInsets.all(15),
                    decoration: const BoxDecoration(
                      color: secondaryMainColor,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(20),
                        topRight: Radius.circular(20),
                      ),
                    ),
                    child: Row(
                      children: [
                        Expanded(
                          child: SizedBox(
                            height: 52,
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                elevation: 0,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(15),
                                ),
                              ),
                              onPressed: () async {
                                if (schedule['status'] == 2) {
                                  Navigator.of(context).push(
                                    MaterialPageRoute(
                                      builder: (context) => TheoriticalEnd(),
                                    ),
                                  );

                                  return;
                                }
                                showDialog(
                                  barrierDismissible: false,
                                  context: context,
                                  builder: (context) => LoadingWidget(),
                                );
                                final r = await read
                                    .startSchedule(schedule['id'].toString());
                                if (context.mounted) {
                                  Navigator.of(context).pop();
                                  if (r == 'success') {
                                    QuickAlert.show(
                                      context: context,
                                      type: QuickAlertType.success,
                                      title: "Started Successfully!",
                                      text: "",
                                      widget: const Text(
                                        'Enjoy your teaching.',
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.w400,
                                        ),
                                      ),
                                      cancelBtnTextStyle: const TextStyle(
                                        fontSize: 17,
                                        fontWeight: FontWeight.w500,
                                      ),
                                      confirmBtnColor: primaryBg,
                                      confirmBtnTextStyle: const TextStyle(
                                        fontSize: 17,
                                        fontWeight: FontWeight.w500,
                                        color: Colors.white,
                                      ),
                                      confirmBtnText: 'Okay',
                                      onConfirmBtnTap: () {
                                        Navigator.of(context).pop();
                                      },
                                    );
                                  } else {
                                    showDialog(
                                      context: context,
                                      builder: (context) => AlertDialog(
                                        content: Text(r),
                                      ),
                                    );
                                  }
                                }
                              },
                              child: Text(
                                schedule['status'] == 2
                                    ? 'End Session'
                                    : "Start",
                                style: const TextStyle(
                                  fontSize: 18,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
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
