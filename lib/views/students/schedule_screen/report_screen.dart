import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mobile_drive_hub/views/instructurs/bottom_navbar/instructor_screen.dart';
import 'package:mobile_drive_hub/views/shared_widget/loader_widget.dart';
import 'package:mobile_drive_hub/views/shared_widget/text_form_widget_noprefix.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';
import '../../../constant/palette.dart';
import '../../../controllers/instructor/instructor_start_practical_controller.dart';
import 'package:quickalert/quickalert.dart';

import '../../../controllers/student/schedules/schedule_view_screen.dart';

class ReportInstructorScreen extends StatefulWidget {
  const ReportInstructorScreen(
      {super.key, required this.scheduleId, required this.instructorId});
  final String scheduleId;
  final String instructorId;
  @override
  State<ReportInstructorScreen> createState() => _ReportInstructorScreenState();
}

class _ReportInstructorScreenState extends State<ReportInstructorScreen> {
  TextEditingController c = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState

    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    c.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(
                left: 15.0,
                right: 15,
                top: 15,
                bottom: 10,
              ),
              child: Row(
                children: const [
                  Icon(
                    Icons.arrow_back,
                  ),
                  SizedBox(
                    width: 20,
                  ),
                  Text(
                    'Report Instructor',
                    style: TextStyle(
                      fontSize: 21,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ),
            Divider(),
            Padding(
              padding: const EdgeInsets.all(15.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Content:',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      TextFormField(
                        controller: c,
                        validator: (e) {},
                        maxLength: 500,
                        maxLines: 10,
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w500,
                          decoration: TextDecoration.none,
                        ),
                        decoration: InputDecoration(
                          hintText: "Enter here...",
                          contentPadding: const EdgeInsets.symmetric(
                            vertical: 10,
                            horizontal: 10,
                          ),
                          focusedErrorBorder: OutlineInputBorder(
                            borderSide: const BorderSide(
                              color: Colors.red,
                              width: 1,
                            ),
                            borderRadius: BorderRadius.circular(10),
                          ),
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
                            borderRadius: BorderRadius.circular(5),
                          ),
                        ),
                      ),
                      Container(
                        margin: const EdgeInsets.only(top: 20),
                        width: double.infinity,
                        height: 52,
                        child: ElevatedButton(
                          onPressed: () async {
                            if (c.text.trim() == "") {
                              showDialog(
                                barrierDismissible: false,
                                context: context,
                                builder: (context) => const AlertDialog(
                                  content: Text(
                                    'Content is required',
                                    style: TextStyle(
                                      fontSize: 18,
                                    ),
                                  ),
                                ),
                              );
                              return;
                            }
                            showDialog(
                              context: context,
                              builder: (context) => LoadingWidget(),
                            );
                            final r = await context
                                .read<StudentViewSchedulesController>()
                                .reportInsructor(
                                  scheduleId: widget.scheduleId,
                                  instructorId: widget.instructorId,
                                  comments: c.text,
                                );
                            if (context.mounted) {
                              Navigator.of(context).pop();
                              if (r == 'success') {
                                QuickAlert.show(
                                  type: QuickAlertType.success,
                                  context: context,
                                  barrierDismissible: false,
                                  text: '',
                                  widget: const Text(
                                    'Reported Successfully',
                                    style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.w400,
                                    ),
                                  ),
                                  confirmBtnColor: primaryBg,
                                  onConfirmBtnTap: () {
                                    Navigator.of(context).pop();
                                    Navigator.of(context).pop();
                                    context
                                        .read<StudentViewSchedulesController>()
                                        .getSingleStudentSchedule();
                                  },
                                );
                              } else {
                                QuickAlert.show(
                                  type: QuickAlertType.error,
                                  context: context,
                                  text: '',
                                  widget: Text(
                                    r,
                                    style: const TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.w400,
                                    ),
                                  ),
                                  confirmBtnColor: primaryBg,
                                  onConfirmBtnTap: () {
                                    Navigator.of(context).pop();
                                  },
                                );
                              }
                            }
                          },
                          style: ElevatedButton.styleFrom(
                            elevation: 0,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(5),
                            ),
                          ),
                          child: const Text(
                            'Submit',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
