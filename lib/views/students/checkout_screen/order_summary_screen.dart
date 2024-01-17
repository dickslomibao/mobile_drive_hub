import 'package:flutter/material.dart';
import 'package:mobile_drive_hub/controllers/student/order/order_controller.dart';
import 'package:mobile_drive_hub/services/school_services.dart';
import 'package:mobile_drive_hub/views/shared_widget/loader_widget.dart';
import 'package:mobile_drive_hub/views/students/bottom_navbar/student_screen.dart';
import 'package:provider/provider.dart';
import 'package:quickalert/quickalert.dart';

import '../../../constant/palette.dart';
import '../../../model/course_model.dart';
import 'webview_screen.dart';

class OrderSummaryScreen extends StatefulWidget {
  const OrderSummaryScreen({
    super.key,
    this.package,
    required this.courses,
    required this.paymentType,
    required this.schoolId,
  });
  final List<CourseModel> courses;
  final String paymentType;
  final String schoolId;
  final Map<String, dynamic>? package;
  @override
  State<OrderSummaryScreen> createState() => _OrderSummaryScreenState();
}

class _OrderSummaryScreenState extends State<OrderSummaryScreen> {
  bool agree = false;
  String? selectedCard;

  String getTotalPrice() {
    double price = 0;

    if (widget.package == null) {
      for (var element in widget.courses) {
        final variant = element.variants.singleWhere(
          (v) {
            return v['id'] == element.selectedVariant;
          },
        );
        price += variant['price'];
      }
    } else {
      price = double.parse(widget.package!['price'].toString());
    }
    return price.toStringAsFixed(2);
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: backgroundMainColor,
      body: SafeArea(
        child: SizedBox(
          height: height,
          child: Stack(
            children: [
              SizedBox(
                height: height - 100,
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        padding: const EdgeInsets.all(15),
                        color: Colors.white,
                        child: Row(
                          children: [
                            GestureDetector(
                              onTap: () {
                                Navigator.of(context).pop();
                              },
                              child: const Icon(
                                Icons.arrow_back,
                                size: 25,
                              ),
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            const Text(
                              "Order Summary",
                              style: TextStyle(
                                fontSize: 21,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      Container(
                        width: double.infinity,
                        padding: const EdgeInsets.all(15),
                        color: Colors.white,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              "Item(s):",
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            ListView.builder(
                              itemCount: widget.courses.length,
                              physics: const BouncingScrollPhysics(),
                              shrinkWrap: true,
                              itemBuilder: (BuildContext context, int index) {
                                final item = widget.courses[index];
                                final variant = item.variants.singleWhere(
                                  (element) {
                                    return element['id'] ==
                                        item.selectedVariant;
                                  },
                                );
                                return Container(
                                  margin: const EdgeInsets.only(
                                    top: 15,
                                  ),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          SizedBox(
                                            child: ClipRRect(
                                              borderRadius:
                                                  BorderRadius.circular(5),
                                              child: Image.network(
                                                item.thumbnail,
                                                height: 60,
                                                width: 80,
                                                fit: BoxFit.cover,
                                              ),
                                            ),
                                          ),
                                          const SizedBox(
                                            width: 10,
                                          ),
                                          Expanded(
                                            child: SizedBox(
                                              height: 60,
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Text(
                                                    'Course: ${item.name}',
                                                    style: const TextStyle(
                                                      overflow:
                                                          TextOverflow.ellipsis,
                                                      fontSize: 17,
                                                      fontWeight:
                                                          FontWeight.w500,
                                                    ),
                                                  ),
                                                  const Spacer(),
                                                  Text(
                                                    'Duration: ${variant['duration']} hrs',
                                                    style: const TextStyle(
                                                      overflow:
                                                          TextOverflow.ellipsis,
                                                      fontSize: 17,
                                                      fontWeight:
                                                          FontWeight.w500,
                                                    ),
                                                  ),
                                                  Text(
                                                    'Price: Php ${variant['price']}',
                                                    style: const TextStyle(
                                                      overflow:
                                                          TextOverflow.ellipsis,
                                                      fontSize: 17,
                                                      fontWeight:
                                                          FontWeight.w500,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                );
                              },
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            Row(
                              children: [
                                const Text(
                                  "Total Price:",
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                                const Spacer(),
                                Text(
                                  "${getTotalPrice()} Php",
                                  style: const TextStyle(
                                    fontSize: 21,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
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
                        padding: const EdgeInsets.all(15),
                        color: Colors.white,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              "Payment method:",
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            const SizedBox(
                              height: 15,
                            ),
                            if (widget.paymentType == "1")
                              Row(
                                children: [
                                  Image.asset(
                                    'assets/images/money.png',
                                    height: 25,
                                    width: 25,
                                  ),
                                  const SizedBox(
                                    width: 10,
                                  ),
                                  const Text(
                                    "Cash",
                                    style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ],
                              ),
                            if (widget.paymentType == "2")
                              Row(
                                children: [
                                  Image.asset(
                                    'assets/images/gcash.png',
                                    height: 25,
                                    width: 25,
                                  ),
                                  const SizedBox(
                                    width: 10,
                                  ),
                                  const Text(
                                    "Gcash",
                                    style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ],
                              ),
                            if (widget.paymentType == "3")
                              Row(
                                children: [
                                  Image.asset(
                                    'assets/images/atm-card.png',
                                    height: 25,
                                    width: 25,
                                  ),
                                  const SizedBox(
                                    width: 10,
                                  ),
                                  const Text(
                                    "Card",
                                    style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
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
                        padding: const EdgeInsets.only(
                          top: 15,
                          bottom: 15,
                          right: 15,
                          left: 5,
                        ),
                        color: Colors.white,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Checkbox(
                                  value: agree,
                                  onChanged: (value) {
                                    setState(() {
                                      agree = !agree;
                                    });
                                  },
                                ),
                                GestureDetector(
                                  onTap: () {
                                    showModalBottomSheet(
                                      context: context,
                                      useSafeArea: true,
                                      builder: (context) =>
                                          SingleChildScrollView(
                                        child: Padding(
                                          padding: const EdgeInsets.all(15.0),
                                          child: FutureBuilder(
                                            future:
                                                schoolServices.getSchoolPolicy(
                                                    widget.schoolId),
                                            builder: (context, snapshot) {
                                              if (snapshot.connectionState ==
                                                  ConnectionState.waiting) {
                                                return const Center(
                                                    child:
                                                        CircularProgressIndicator());
                                              }
                                              if (snapshot.hasError) {
                                                return const Center(
                                                  child: Text(
                                                    'Something went wrong.',
                                                    style: TextStyle(
                                                      fontSize: 16,
                                                      fontWeight:
                                                          FontWeight.w500,
                                                    ),
                                                  ),
                                                );
                                              }
                                              if (snapshot.data == null) {
                                                return const Center(
                                                  child: Text(
                                                    'No info yet',
                                                    style: TextStyle(
                                                      fontSize: 16,
                                                      fontWeight:
                                                          FontWeight.w500,
                                                    ),
                                                  ),
                                                );
                                              }
                                              if (snapshot.data['about'] ==
                                                  null) {
                                                return const Center(
                                                  child: Text(
                                                    'No info yet',
                                                    style: TextStyle(
                                                      fontSize: 16,
                                                      fontWeight:
                                                          FontWeight.w500,
                                                    ),
                                                  ),
                                                );
                                              }
                                              return Column(
                                                children: [
                                                  const Text(
                                                    'School Policy',
                                                    style: TextStyle(
                                                      fontSize: 18,
                                                      fontWeight:
                                                          FontWeight.w500,
                                                    ),
                                                  ),
                                                  const SizedBox(
                                                    height: 20,
                                                  ),
                                                  Text(
                                                    snapshot.data['about']
                                                        ['content'],
                                                    style: const TextStyle(
                                                      fontSize: 18,
                                                      fontWeight:
                                                          FontWeight.w500,
                                                    ),
                                                  ),
                                                ],
                                              );
                                            },
                                          ),
                                        ),
                                      ),
                                    );
                                  },
                                  child: const Text(
                                    "Agree with the driving school policy.",
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w500,
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
                              if (!agree) {
                                showDialog(
                                  context: context,
                                  builder: (context) => const AlertDialog(
                                    content: Text(
                                      "Please Agree with driving school policy",
                                      style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                  ),
                                );
                                return;
                              }
                              final read = context.read<OrderController>();
                              List<String> c = [];
                              List<String> v = [];
                              String? promoId;
                              for (var element in widget.courses) {
                                c.add(element.id);
                                v.add(element.selectedVariant.toString());
                              }
                              if (widget.package != null) {
                                promoId = widget.package!['id'];
                              }
                              showDialog(
                                barrierDismissible: false,
                                context: context,
                                builder: (context) => const LoadingWidget(),
                              );

                              final r = await read.createOrder(
                                promoId,
                                widget.courses.first.schoolId,
                                c,
                                v,
                                widget.paymentType,
                              );
                              if (context.mounted) {
                                Navigator.pop(context);

                                if (r == 'success') {
                                  if (widget.paymentType == "1") {
                                    QuickAlert.show(
                                      context: context,
                                      type: QuickAlertType.success,
                                      title: "Order placed successfully!",
                                      text: "",
                                      widget: const Text(
                                        'You can now go to Driving School to make a payment.',
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
                                        Navigator.of(context)
                                            .pushAndRemoveUntil(
                                          MaterialPageRoute(
                                            builder: (context) {
                                              return StudentMainScreen();
                                            },
                                          ),
                                          (route) => false,
                                        );
                                      },
                                    );
                                  } else {
                                    String url = read.url;

                                    QuickAlert.show(
                                      context: context,
                                      type: QuickAlertType.success,
                                      title: 'Order placed successfully!',
                                      text: "",
                                      widget: const Text(
                                        'Check your email for the payment link. You can also proceed with payment here.',
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.w400,
                                        ),
                                      ),
                                      cancelBtnText: 'Ok',
                                      confirmBtnText: 'Proceed',
                                      confirmBtnColor: primaryBg,
                                      cancelBtnTextStyle: const TextStyle(
                                        fontSize: 17,
                                        fontWeight: FontWeight.w500,
                                      ),
                                      confirmBtnTextStyle: const TextStyle(
                                        fontSize: 17,
                                        fontWeight: FontWeight.w500,
                                        color: Colors.white,
                                      ),
                                      showCancelBtn: true,
                                      onCancelBtnTap: () {
                                        Navigator.of(context)
                                            .pushAndRemoveUntil(
                                          MaterialPageRoute(
                                            builder: (context) {
                                              return StudentMainScreen();
                                            },
                                          ),
                                          (route) => false,
                                        );
                                      },
                                      onConfirmBtnTap: () {
                                        if (url != "") {
                                          Navigator.of(context).push(
                                            MaterialPageRoute(
                                              builder: (context) => MyWebView(
                                                url: url,
                                              ),
                                            ),
                                          );
                                        }
                                      },
                                    );
                                  }
                                } else {
                                  QuickAlert.show(
                                    context: context,
                                    type: QuickAlertType.error,
                                    text: "",
                                    widget: Text(
                                      r,
                                      style: const TextStyle(
                                        fontSize: 17,
                                        fontWeight: FontWeight.w400,
                                      ),
                                    ),
                                  );
                                }
                              }
                            },
                            child: const Text(
                              'Place Order',
                              style: TextStyle(
                                fontSize: 18,
                              ),
                            ),
                          ),
                        ),
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
