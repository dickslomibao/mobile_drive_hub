import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mobile_drive_hub/views/instructurs/bottom_navbar/instructor_screen.dart';
import 'package:mobile_drive_hub/views/shared_widget/loader_widget.dart';
import 'package:mobile_drive_hub/views/shared_widget/text_form_widget_noprefix.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';
import '../../../constant/palette.dart';
import '../../../controllers/instructor/instructor_start_practical_controller.dart';
import 'package:quickalert/quickalert.dart';

import '../../../controllers/instructor/view_schedules_controller.dart';
import '../../../controllers/student/schedules/schedule_view_screen.dart';
import 'dart:io';

class ScheduleReport extends StatefulWidget {
  const ScheduleReport({super.key, required this.scheduleId});
  final String scheduleId;
  @override
  State<ScheduleReport> createState() => _ScheduleReportState();
}

class _ScheduleReportState extends State<ScheduleReport> {
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

  List<XFile> images = [];
  Future<void> pickImages() async {
    List<XFile>? pickedImages = await ImagePicker().pickMultiImage();
    if (pickedImages.isNotEmpty) {
      setState(() {
        images = pickedImages;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
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
                      'Schedule Report',
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
                          child: OutlinedButton(
                            onPressed: () async {
                              await pickImages();
                            },
                            style: ElevatedButton.styleFrom(
                              elevation: 0,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(5),
                              ),
                            ),
                            child: Text(
                              '${images.isNotEmpty ? "Selected images" : 'Select images'} ${images.isEmpty ? '' : ' (${images.length})'}',
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                        ),
                        if (images.isNotEmpty)
                          Container(
                            margin: EdgeInsets.only(bottom: 10, top: 10),
                            child: Text(
                              'Images preview: ',
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                        if (images.isNotEmpty)
                          ListView.builder(
                            physics: BouncingScrollPhysics(),
                            shrinkWrap: true,
                            itemCount: images.length,
                            itemBuilder: (context, index) {
                              return Container(
                                margin: EdgeInsets.only(bottom: 10),
                                child: Image.file(
                                  File(images[index]
                                      .path), // Convert XFile to File
                                  fit: BoxFit.cover,
                                ),
                              );
                            },
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
                                  .read<InstructorStartSchedulesController>()
                                  .scheduleReport(
                                    widget.scheduleId,
                                    c.text.trim(),
                                    images,
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
                                      'Scheule Reported Successfully',
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
                                          .read<
                                              InstructorViewSchedulesController>()
                                          .getSingleInstructorSchedule(
                                              widget.scheduleId.toString());
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
      ),
    );
  }
}
