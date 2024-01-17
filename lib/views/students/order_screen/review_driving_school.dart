import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:mobile_drive_hub/controllers/student/order/order_controller.dart';
import 'package:mobile_drive_hub/views/instructurs/bottom_navbar/instructor_screen.dart';
import 'package:mobile_drive_hub/views/shared_widget/loader_widget.dart';
import 'package:mobile_drive_hub/views/shared_widget/text_form_widget_noprefix.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';
import '../../../constant/palette.dart';
import '../../../controllers/instructor/instructor_start_practical_controller.dart';
import 'package:quickalert/quickalert.dart';
import '../../../controllers/student/course/view_mycourses_controller.dart';
import '../../../controllers/student/schedules/schedule_view_screen.dart';

class ReviewDrivingSchool extends StatefulWidget {
  const ReviewDrivingSchool(
      {super.key, required this.schoolId, required this.orderId});
  final String schoolId;
  final String orderId;
  @override
  State<ReviewDrivingSchool> createState() => _ReviewDrivingSchoolState();
}

class _ReviewDrivingSchoolState extends State<ReviewDrivingSchool> {
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

  bool hide = false;
  double rating = 1;
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
                      'Review Driving School',
                      style: TextStyle(
                        fontSize: 21,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ),
              const Divider(),
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
                          maxLength: 200,
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
                        const SizedBox(
                          height: 10,
                        ),
                        const Text(
                          'Rating:',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        RatingBar.builder(
                          initialRating: 3,
                          minRating: 1,
                          direction: Axis.horizontal,
                          allowHalfRating: true,
                          itemSize: 30,
                          itemCount: 5,
                          itemPadding:
                              const EdgeInsets.symmetric(horizontal: 4.0),
                          itemBuilder: (context, _) => const Icon(
                            Icons.star,
                            color: Colors.amber,
                          ),
                          onRatingUpdate: (r) {
                            rating = r;
                          },
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        Row(
                          children: [
                            Checkbox(
                              value: hide,
                              onChanged: (value) {
                                setState(() {
                                  hide = !hide;
                                });
                              },
                            ),
                            const Expanded(
                              child: Text(
                                'Hide my identity',
                                style: const TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                          ],
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
                                barrierDismissible: false,
                                context: context,
                                builder: (context) => const LoadingWidget(),
                              );
                              final read = context.read<OrderController>();
                              String r = await read.createReview(
                                {
                                  'school_id': widget.schoolId,
                                  'order_id': widget.orderId,
                                  'content': c.text,
                                  'hide': hide ? 2 : 1,
                                  'rating': rating,
                                },
                              );
                              if (context.mounted) {
                                Navigator.of(context).pop();
                                if (r == 'success') {
                                  QuickAlert.show(
                                    type: QuickAlertType.success,
                                    context: context,
                                    title: "Success!",
                                    barrierDismissible: false,
                                    text: '',
                                    widget: const Text(
                                      'Your review has been submited',
                                      style: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.w400,
                                      ),
                                    ),
                                    confirmBtnColor: primaryBg,
                                    onConfirmBtnTap: () {
                                      read.getStudentOrders();
                                      Navigator.of(context).pop();
                                      Navigator.of(context).pop();
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
