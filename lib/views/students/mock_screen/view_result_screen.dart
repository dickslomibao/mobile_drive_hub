import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:mobile_drive_hub/constant/palette.dart';
import 'package:mobile_drive_hub/controllers/student/course/mock_quiz_controller.dart';
import 'package:mobile_drive_hub/controllers/student/course/mock_screen_controller.dart';
import 'package:mobile_drive_hub/views/shared_widget/loader_widget.dart';

import 'package:provider/provider.dart';
import '../../../constant/url.dart';
import '../appbar/app_bar_widget.dart';

class ViewResultScreen extends StatefulWidget {
  const ViewResultScreen({super.key, required this.id});
  final String id;
  @override
  State<ViewResultScreen> createState() => _ViewResultScreenState();
}

class _ViewResultScreenState extends State<ViewResultScreen> {
  @override
  void initState() {
    super.initState();
    context.read<MockQuizController>().getMockQuestions(widget.id);
  }

  String value = "English";
  @override
  Widget build(BuildContext context) {
    final watch = context.watch<MockQuizController>();
    final height = MediaQuery.of(context).size.height;
    final questions = watch.questions;

    return Scaffold(
      backgroundColor: primaryBg,
      body: SafeArea(
        child: Container(
          color: Colors.white,
          height: height,
          child: Stack(
            children: [
              const AppBarWidget(
                title: 'Mock Exam',
              ),
              watch.isLoading
                  ? const Center(
                      child: CircularProgressIndicator(),
                    )
                  : Container(
                      padding: const EdgeInsets.all(15),
                      margin: const EdgeInsets.only(top: 60),
                      height: height - 105,
                      child: SingleChildScrollView(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Expanded(
                                  child: RadioListTile(
                                    value: "English",
                                    groupValue: value,
                                    onChanged: (val) {
                                      setState(() {
                                        value = val!;
                                      });
                                    },
                                    title: const Text(
                                      'English',
                                      style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                  ),
                                ),
                                Expanded(
                                  child: RadioListTile(
                                    value: "Tagalog",
                                    groupValue: value,
                                    onChanged: (val) {
                                      setState(() {
                                        value = val!;
                                      });
                                    },
                                    title: const Text(
                                      'Tagalog',
                                      style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            const Text(
                              'Mock Test Result',
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            ListView.builder(
                              physics: const BouncingScrollPhysics(),
                              shrinkWrap: true,
                              itemCount: questions.length,
                              itemBuilder: (context, index) {
                                final q = questions[index];
                                Color qC = const Color.fromRGBO(
                                  0,
                                  255,
                                  0,
                                  .1,
                                );

                                if (q['correct_answer'].toString() !=
                                    q['user_answer'].toString()) {
                                  qC = const Color.fromRGBO(
                                    255,
                                    0,
                                    0,
                                    .1,
                                  );
                                }
                                return Container(
                                  margin: const EdgeInsets.only(bottom: 15),
                                  padding: const EdgeInsets.all(15),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(15),
                                    color: qC,
                                  ),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        '${index + 1}. ${value == "English" ? q['question']['questions'] : q['question']['tagalog']}',
                                        style: const TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                      const SizedBox(
                                        height: 15,
                                      ),
                                      if (q['question']['images'].length > 0)
                                        Container(
                                          margin: const EdgeInsets.only(
                                            bottom: 20,
                                          ),
                                          child: ClipRRect(
                                            borderRadius:
                                                BorderRadius.circular(8),
                                            child: Image.network(
                                              WEBSITE_URL +
                                                  q['question']['images'],
                                            ),
                                          ),
                                        ),
                                      ListView.builder(
                                        shrinkWrap: true,
                                        physics: const BouncingScrollPhysics(),
                                        itemCount: q['choices'].length,
                                        itemBuilder: (context, index) {
                                          final c = q['choices'][index];
                                          Color color = Colors.white;
                                          Color tCOlor = Colors.black;
                                          if (c['code'].toString() ==
                                              q['correct_answer'].toString()) {
                                            color = Colors.green.shade600;
                                            tCOlor = Colors.white;
                                          } else {
                                            if (c['code'].toString() ==
                                                q['user_answer'].toString()) {
                                              color = Colors.red.shade600;
                                              tCOlor = Colors.white;
                                            }
                                          }
                                          return Container(
                                            margin: const EdgeInsets.only(
                                                bottom: 20),
                                            padding: const EdgeInsets.all(15),
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                              color: color,
                                              border: Border.all(
                                                color: backgroundMainColor,
                                              ),
                                            ),
                                            width: double.infinity,
                                            child: Text(
                                              value == "English"
                                                  ? c['body']
                                                  : c['body_tagalog'],
                                              style: TextStyle(
                                                fontSize: 18,
                                                fontWeight: FontWeight.w500,
                                                color: tCOlor,
                                              ),
                                            ),
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
                    ),
            ],
          ),
        ),
      ),
    );
  }
}
