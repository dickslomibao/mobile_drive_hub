import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';

import '../../../constant/palette.dart';
import '../../../controllers/instructor/instructor_start_practical_controller.dart';
import '../appbar/insctructor_appbar_widget.dart';

class StudentPracticalChecklistScreen extends StatefulWidget {
  const StudentPracticalChecklistScreen({super.key});

  @override
  State<StudentPracticalChecklistScreen> createState() =>
      _StudentPracticalChecklistScreenState();
}

class _StudentPracticalChecklistScreenState
    extends State<StudentPracticalChecklistScreen> {
  @override
  Widget build(BuildContext context) {
    final schedule =
        context.read<InstructorStartSchedulesController>().schedule;
    final height = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: primaryBg,
      body: SafeArea(
        child: Container(
          height: height,
          color: backgroundMainColor,
          child: Stack(
            children: [
              const InstrcutorAppBarWidget(
                title: 'Student Course Progress',
                leading: true,
              ),
              Container(
                margin: const EdgeInsets.only(top: 60),
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(
                        height: 10,
                      ),
                      ListView.builder(
                        physics: const BouncingScrollPhysics(),
                        itemCount: schedule['students'][0]['progress'].length,
                        shrinkWrap: true,
                        itemBuilder: (context, index) {
                          final p = schedule['students'][0]['progress'][index];
                          return Container(
                            color: secondaryMainColor,
                            padding: const EdgeInsets.all(15),
                            margin: const EdgeInsets.only(bottom: 10),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  p['progress']['title'],
                                  style: const TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                                const SizedBox(
                                  height: 5,
                                ),
                                ListView.builder(
                                  physics: const BouncingScrollPhysics(),
                                  itemCount: p['sub_progress'].length,
                                  shrinkWrap: true,
                                  itemBuilder: (context, i) {
                                    final s = p['sub_progress'][i];
                                    return Row(
                                      children: [
                                        Checkbox(
                                          value: s['status'] != 1,
                                          onChanged: (value) async {
                                            Fluttertoast.showToast(
                                              msg: "Cheking",
                                              toastLength: Toast.LENGTH_SHORT,
                                              gravity: ToastGravity.BOTTOM,
                                              timeInSecForIosWeb: 1,
                                              backgroundColor: primaryBg,
                                              textColor: Colors.white,
                                              fontSize: 16.0,
                                            );
                                            await context
                                                .read<
                                                    InstructorStartSchedulesController>()
                                                .checkProgress(
                                                    s['id'].toString());

                                            Fluttertoast.showToast(
                                              msg: "Checked",
                                              toastLength: Toast.LENGTH_SHORT,
                                              gravity: ToastGravity.BOTTOM,
                                              timeInSecForIosWeb: 1,
                                              backgroundColor: primaryBg,
                                              textColor: Colors.white,
                                              fontSize: 16.0,
                                            );
                                            setState(() {
                                              schedule['students'][0]
                                                          ['progress'][index]
                                                      ['sub_progress'][i]
                                                  ['status'] = 2;
                                            });
                                          },
                                        ),
                                        Expanded(
                                          child: Text(
                                            s['title'],
                                            style: const TextStyle(
                                              fontSize: 16,
                                              fontWeight: FontWeight.w500,
                                            ),
                                          ),
                                        ),
                                      ],
                                    );
                                  },
                                ),
                              ],
                            ),
                          );
                        },
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
