import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:mobile_drive_hub/constant/palette.dart';
import 'package:mobile_drive_hub/controllers/student/course/mock_screen_controller.dart';
import 'package:mobile_drive_hub/controllers/student/order/order_controller.dart';
import 'package:mobile_drive_hub/views/instructurs/appbar/insctructor_appbar_widget.dart';
import 'package:mobile_drive_hub/views/students/mock_screen/view_result_screen.dart';
import 'package:provider/provider.dart';
import 'package:pusher_channels_flutter/pusher_channels_flutter.dart';
import '../../../services/token_services.dart';
import '../../splash/last_screen.dart';
import '../appbar/app_bar_widget.dart';
import 'quiz_screen.dart';

class MockListScreen extends StatefulWidget {
  const MockListScreen({super.key, required this.id, this.instructor = false});
  final String id;
  final bool instructor;
  @override
  State<MockListScreen> createState() => _MockListScreenState();
}

class _MockListScreenState extends State<MockListScreen> {
  @override
  void initState() {
    super.initState();
    context.read<GetMockListController>().orderListId = widget.id;
    context.read<GetMockListController>().getMockList();
  }

  @override
  Widget build(BuildContext context) {
    final watch = context.watch<GetMockListController>();
    final height = MediaQuery.of(context).size.height;
    final mock = watch.mocks;
    print(mock);
    return Scaffold(
      backgroundColor: primaryBg,
      body: SafeArea(
        child: Container(
          color: Colors.white,
          height: height,
          child: Stack(
            children: [
              if (widget.instructor)
                const InstrcutorAppBarWidget(
                  title: 'Student Exam',
                  leading: true,
                ),
              if (!widget.instructor)
                const AppBarWidget(
                  title: 'Course Mock Exam',
                  leading: true,
                ),
              watch.isLoading
                  ? const Center(
                      child: CircularProgressIndicator(),
                    )
                  : Container(
                      padding: const EdgeInsets.all(15),
                      margin: const EdgeInsets.only(top: 70),
                      child: SingleChildScrollView(
                        child: ListView.builder(
                          physics: const BouncingScrollPhysics(),
                          shrinkWrap: true,
                          itemCount: mock.length,
                          itemBuilder: (context, index) {
                            final m = mock[index];
                            String status = "Waiting to take";
                            String btnText = "Start Mock Exam";
                            if (m['status'] == 2) {
                              btnText = "Continue Mock Exam";
                              status = "Already started";
                            }
                            if (m['status'] == 3) {
                              btnText = "View Result";
                              status = "Completed";
                            }
                            return Container(
                              padding: const EdgeInsets.all(15),
                              margin: const EdgeInsets.only(
                                bottom: 20,
                              ),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(15),
                                border: Border.all(
                                  color: backgroundMainColor,
                                ),
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Status: $status',
                                    style: const TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 5,
                                  ),
                                  Text(
                                    'Mock Exam: ${m['mock_count']}',
                                    style: const TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 5,
                                  ),
                                  Text(
                                    'Date Assigned: ${m['date_created']}',
                                    style: const TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 5,
                                  ),
                                  Text(
                                    'Items: ${m['items']}',
                                    style: const TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                  if (m['status'] == 3)
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        const SizedBox(
                                          height: 5,
                                        ),
                                        Text(
                                          'Score: ${m['score']}/${m['items']}  | ${(m['score'] / m['items']) * 100}%',
                                          style: const TextStyle(
                                            fontSize: 18,
                                            fontWeight: FontWeight.w500,
                                          ),
                                        ),
                                        const SizedBox(
                                          height: 5,
                                        ),
                                      ],
                                    ),
                                  if ((widget.instructor && m['status'] == 3) ||
                                      !widget.instructor)
                                    Container(
                                      height: 48,
                                      margin: EdgeInsets.only(top: 20),
                                      width: double.infinity,
                                      child: ElevatedButton(
                                        onPressed: () {
                                          if (m['status'] == 3) {
                                            Navigator.of(context).push(
                                              MaterialPageRoute(
                                                builder: (context) {
                                                  return ViewResultScreen(
                                                    id: m['id'].toString(),
                                                  );
                                                },
                                              ),
                                            );
                                          } else {
                                            Navigator.of(context).push(
                                              MaterialPageRoute(
                                                builder: (context) {
                                                  return QuizScreen(
                                                    id: m['id'].toString(),
                                                  );
                                                },
                                              ),
                                            );
                                          }
                                        },
                                        style: ElevatedButton.styleFrom(
                                          backgroundColor: secondaryBg,
                                          elevation: 0,
                                          shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(10),
                                          ),
                                        ),
                                        child: Text(
                                          btnText,
                                          style: const TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.w500,
                                            color: Colors.white,
                                          ),
                                        ),
                                      ),
                                    ),
                                ],
                              ),
                            );
                          },
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
