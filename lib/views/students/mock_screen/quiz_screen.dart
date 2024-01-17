import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:mobile_drive_hub/constant/palette.dart';
import 'package:mobile_drive_hub/controllers/student/course/mock_quiz_controller.dart';
import 'package:mobile_drive_hub/controllers/student/course/mock_screen_controller.dart';
import 'package:mobile_drive_hub/views/shared_widget/loader_widget.dart';

import 'package:provider/provider.dart';
import '../../../constant/url.dart';
import '../appbar/app_bar_widget.dart';

class QuizScreen extends StatefulWidget {
  const QuizScreen({super.key, required this.id});
  final String id;
  @override
  State<QuizScreen> createState() => _QuizScreenState();
}

class _QuizScreenState extends State<QuizScreen> {
  int count = 0;
  bool pop = false;
  @override
  void initState() {
    super.initState();
    context.read<MockQuizController>().getMockQuestions(widget.id);
  }

  void submit() {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        content: SingleChildScrollView(
          child: Container(
            width: MediaQuery.of(context).size.width,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(child: Image.asset('assets/images/qmark.png')),
                const SizedBox(
                  height: 30,
                ),
                const Center(
                  child: Text(
                    'Are you sure you want\nsubmit already?',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
                const SizedBox(
                  height: 40,
                ),
                Row(
                  children: [
                    Expanded(
                      child: SizedBox(
                        height: 48,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color.fromRGBO(0, 0, 0, .05),
                            elevation: 0,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15),
                            ),
                          ),
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                          child: const Text(
                            'No',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                              color: Colors.black87,
                            ),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    Expanded(
                      child: SizedBox(
                        height: 48,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            elevation: 0,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15),
                            ),
                          ),
                          onPressed: () async {
                            Navigator.of(context).pop();
                            showDialog(
                              context: context,
                              builder: (context) => const LoadingWidget(),
                            );
                            final s = await context
                                .read<MockQuizController>()
                                .submitAnswer();

                            if (context.mounted) {
                              await context
                                  .read<GetMockListController>()
                                  .getMockList();
                              if (context.mounted) {
                                if (s == "success") {
                                  pop = true;
                                  Navigator.of(context).pop();
                                  Navigator.of(context).pop();
                                }
                              }
                            }
                          },
                          child: const Text(
                            'Yes',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      ),
                    )
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  String value = "English";
  @override
  Widget build(BuildContext context) {
    final watch = context.watch<MockQuizController>();
    final read = context.read<MockQuizController>();
    final height = MediaQuery.of(context).size.height;
    final tempq = watch.questions;
    final questions = tempq.isEmpty ? [] : tempq[count];

    print(questions);
    return WillPopScope(
      onWillPop: () async {
        return pop;
      },
      child: Scaffold(
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
                    : tempq.isEmpty
                        ? SizedBox()
                        : Container(
                            padding: const EdgeInsets.all(15),
                            margin: const EdgeInsets.only(top: 50),
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
                                  Text(
                                    '${count + 1}. ${value == "English" ? questions['question']['questions'] : questions['question']['tagalog']}',
                                    style: const TextStyle(
                                      fontSize: 22,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 20,
                                  ),
                                  if (questions['question']['images'].length >
                                      0)
                                    Container(
                                      margin: const EdgeInsets.only(
                                        bottom: 20,
                                      ),
                                      child: Image.network(
                                        WEBSITE_URL +
                                            questions['question']['images'],
                                      ),
                                    ),
                                  ListView.builder(
                                    shrinkWrap: true,
                                    itemCount: questions['choices'].length,
                                    itemBuilder: (context, index) {
                                      final c = questions['choices'][index];
                                      Color color = Colors.white;
                                      Color tCOlor = Colors.black;
                                      if (questions['user_answer'] ==
                                          c['code']) {
                                        color = secondaryBg;
                                        tCOlor = Colors.white;
                                      }
                                      return GestureDetector(
                                        onTap: () {
                                          read.saveAnswer(
                                              questions['question_id'],
                                              c['code']);
                                        },
                                        child: Container(
                                          margin: EdgeInsets.only(bottom: 20),
                                          padding: EdgeInsets.all(15),
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
                                        ),
                                      );
                                    },
                                  ),
                                  const SizedBox(
                                    height: 20,
                                  ),
                                  Row(
                                    children: [
                                      if (count != 0)
                                        Expanded(
                                          child: Container(
                                            height: 48,
                                            width: double.infinity,
                                            child: OutlinedButton(
                                              onPressed: () {
                                                setState(() {
                                                  --count;
                                                });
                                              },
                                              style: OutlinedButton.styleFrom(
                                                side: const BorderSide(
                                                  color: Color.fromRGBO(
                                                      84, 94, 225, 1),
                                                ),
                                                elevation: 0,
                                                shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(10),
                                                ),
                                              ),
                                              child: const Text(
                                                'Previous',
                                                style: TextStyle(
                                                  fontSize: 18,
                                                  fontWeight: FontWeight.w500,
                                                  color: Color.fromRGBO(
                                                      84, 94, 225, 1),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                      if (count != 0)
                                        const SizedBox(
                                          width: 10,
                                        ),
                                      if (tempq.length - 1 != count)
                                        Expanded(
                                          child: Container(
                                            height: 48,
                                            width: double.infinity,
                                            child: ElevatedButton(
                                              onPressed: () {
                                                setState(() {
                                                  ++count;
                                                });
                                              },
                                              style: ElevatedButton.styleFrom(
                                                backgroundColor: primaryBg,
                                                elevation: 0,
                                                shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(10),
                                                ),
                                              ),
                                              child: const Text(
                                                'Next',
                                                style: TextStyle(
                                                  fontSize: 18,
                                                  fontWeight: FontWeight.w500,
                                                  color: Colors.white,
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                      if (tempq.length - 1 == count)
                                        Expanded(
                                          child: Container(
                                            height: 48,
                                            width: double.infinity,
                                            child: ElevatedButton(
                                              onPressed: () {
                                                submit();
                                              },
                                              style: ElevatedButton.styleFrom(
                                                backgroundColor: primaryBg,
                                                elevation: 0,
                                                shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(10),
                                                ),
                                              ),
                                              child: const Text(
                                                'Submit',
                                                style: TextStyle(
                                                  fontSize: 18,
                                                  fontWeight: FontWeight.w500,
                                                  color: Colors.white,
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                    ],
                                  ),
                                ],
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
}
