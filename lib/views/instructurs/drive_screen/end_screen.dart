import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mobile_drive_hub/views/instructurs/bottom_navbar/instructor_screen.dart';
import 'package:mobile_drive_hub/views/shared_widget/loader_widget.dart';
import 'package:mobile_drive_hub/views/shared_widget/text_form_widget_noprefix.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';
import '../../../controllers/instructor/instructor_start_practical_controller.dart';
import 'package:quickalert/quickalert.dart';

class InstructorEndScreen extends StatefulWidget {
  const InstructorEndScreen({super.key});

  @override
  State<InstructorEndScreen> createState() => _InstructorEndScreenState();
}

class _InstructorEndScreenState extends State<InstructorEndScreen> {
  TextEditingController hr = TextEditingController();
  TextEditingController m = TextEditingController();
  TextEditingController mileage = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    hr.text = "0";
    m.text = "0";
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    hr.dispose();
    m.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final read = context.read<InstructorStartSchedulesController>();
    print(read.schedule);
    return Scaffold(
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
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
                    'End Session',
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
                  const Text(
                    'Date started:',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  Text(
                    DateFormat('E - MMMM d, yyyy : hh:mm: a')
                        .format(DateTime.parse(read.getStartDate())),
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  const Text(
                    'Hours need to complete:',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  Text(
                    "${read.schedule['total_hours']} hrs",
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  const Text(
                    'Total consume hours:',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  Text(
                    "${read.consumeHours()['hrs']} ${read.consumeHours()['hrs'] > 1 ? 'hours' : 'hour'} and ${read.consumeHours()['min']} ${read.consumeHours()['min'] > 1 ? 'minutes' : 'minute'}",
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  const Text(
                    'Completed hours:',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: TextFormWidgetNoPrefixBuilder(
                          type: TextInputType.number,
                          label: 'Hours',
                          controller: hr,
                          validator: (val) {},
                          hintText: '',
                        ),
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      Expanded(
                        child: TextFormWidgetNoPrefixBuilder(
                          type: TextInputType.number,
                          label: 'Minutes',
                          controller: m,
                          validator: (val) {},
                          hintText: '',
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  TextFormWidgetNoPrefixBuilder(
                    type: TextInputType.number,
                    label: 'Ending Mileage',
                    controller: mileage,
                    validator: (val) {},
                    hintText: '',
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 20),
                    width: double.infinity,
                    height: 52,
                    child: ElevatedButton(
                      onPressed: () async {
                        if (hr.text.isEmpty) {
                          showDialog(
                            context: context,
                            builder: (context) => const AlertDialog(
                              content: Text(
                                'Hours is required',
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                          );
                          return;
                        }
                        if (int.tryParse(hr.text) == null) {
                          showDialog(
                            context: context,
                            builder: (context) => const AlertDialog(
                              content: Text(
                                'Invalid hours',
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                          );
                          return;
                        }
                        if (m.text.isNotEmpty) {
                          if (int.tryParse(m.text) == null) {
                            showDialog(
                              context: context,
                              builder: (context) => const AlertDialog(
                                content: Text(
                                  'Invalid minutes',
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ),
                            );
                            return;
                          }
                          if (int.parse(m.text) > 60) {
                            showDialog(
                              context: context,
                              builder: (context) => const AlertDialog(
                                content: Text(
                                  'Should be less than 60',
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ),
                            );
                            return;
                          }
                        }
                        if (mileage.text.isEmpty) {
                          showDialog(
                            context: context,
                            builder: (context) => const AlertDialog(
                              content: Text(
                                'Mileage is required',
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                          );
                          return;
                        }
                        if (mileage.text.isEmpty) {
                          showDialog(
                            context: context,
                            builder: (context) => const AlertDialog(
                              content: Text(
                                'Mileage is required',
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                          );
                          return;
                        }
                        if (double.parse(mileage.text) < 0) {
                          showDialog(
                            context: context,
                            builder: (context) => const AlertDialog(
                              content: Text(
                                'Mileage is invalid',
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                          );
                          return;
                        }
                        if (m.text == "") {
                          m.text = "0";
                        }
                        if (hr.text == "") {
                          hr.text = "0";
                        }

                        if (int.parse(m.text) == 0 && int.parse(hr.text) == 0) {
                          showDialog(
                            context: context,
                            builder: (context) => const AlertDialog(
                              content: Text(
                                'Hours and minutes is required',
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                          );
                          return;
                        }
                        double sss =
                            (int.parse(hr.text) + (int.parse(m.text) / 60))
                                .toDouble();

                        if (sss >
                            double.parse(
                                read.schedule['total_hours'].toString())) {
                          showDialog(
                            context: context,
                            builder: (context) => const AlertDialog(
                              content: Text(
                                'Your input should less than hours need to complete',
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.w500,
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
                        String result = await context
                            .read<InstructorStartSchedulesController>()
                            .endSchedule(int.parse(hr.text), int.parse(m.text),
                                mileage.text);

                        if (context.mounted) {
                          Navigator.of(context).pop();
                          if (result == 'success') {
                            Navigator.of(context).pushAndRemoveUntil(
                              CupertinoPageRoute(
                                builder: (context) => InstructormMainScreen(),
                              ),
                              (route) => false,
                            );
                          } else {
                            QuickAlert.show(
                              context: context,
                              type: QuickAlertType.error,
                              text: result,
                            );
                          }
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15),
                        ),
                      ),
                      child: const Text(
                        'End',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
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
