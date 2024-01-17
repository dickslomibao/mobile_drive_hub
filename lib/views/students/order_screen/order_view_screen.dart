import 'package:flutter/material.dart';
import 'package:mobile_drive_hub/constant/palette.dart';
import 'package:mobile_drive_hub/controllers/student/order/order_controller.dart';
import 'package:mobile_drive_hub/views/students/order_screen/review_driving_school.dart';
import 'package:mobile_drive_hub/views/students/order_screen/widgets/order_header_widget.dart';
import 'package:mobile_drive_hub/views/students/order_screen/widgets/order_list_widget.dart';
import 'package:provider/provider.dart';

import '../../../constant/const_method.dart';
import '../appbar/app_bar_widget.dart';

class OrderViewScreen extends StatefulWidget {
  const OrderViewScreen({super.key, required this.orderId});
  final String orderId;
  @override
  State<OrderViewScreen> createState() => _OrderViewScreenState();
}

class _OrderViewScreenState extends State<OrderViewScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: primaryBg,
      body: SafeArea(
        child: Consumer<OrderController>(
          builder: (context, value, child) {
            final order = value.getSingleOrder(widget.orderId);

            return Container(
              color: backgroundMainColor,
              child: Stack(
                children: [
                  const AppBarWidget(
                    title: 'Order details',
                    leading: true,
                  ),
                  Container(
                    margin: const EdgeInsets.only(top: 55),
                    child: Column(
                      children: [
                        if (order['order']['payment_type'] == 1 &&
                            order['order']['status'] != 6 &&
                            order['order']['status'] != 7)
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 15,
                              vertical: 15,
                            ),
                            width: double.infinity,
                            color: secondaryBg,
                            child: Row(
                              children: [
                                if ((order['order']['total_amount'] -
                                        order['cash_paid']) ==
                                    0)
                                  const Text(
                                    'Payment Completed',
                                    style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.w500,
                                      color: Colors.white,
                                    ),
                                  )
                                else
                                  Text(
                                    'Balance: Php ${(order['order']['total_amount'] - order['cash_paid']).toStringAsFixed(2)}',
                                    style: const TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.w500,
                                      color: Colors.white,
                                    ),
                                  ),
                                const Spacer(),
                                const Icon(
                                  Icons.info_outline,
                                  color: Colors.white,
                                ),
                              ],
                            ),
                          ),
                        const SizedBox(
                          height: 5,
                        ),
                        Container(
                          padding: const EdgeInsets.only(bottom: 10),
                          color: Colors.white,
                          child: OrderHeaderWidget(
                            status: order['order']['status'],
                            dateOrdered:
                                order['order']['date_created'].toString(),
                          ),
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        Container(
                          padding: const EdgeInsets.all(15),
                          color: Colors.white,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  const Icon(
                                    Icons.sell_outlined,
                                    size: 22,
                                  ),
                                  const SizedBox(
                                    width: 5,
                                  ),
                                  Expanded(
                                    child: Text(
                                      order['order']['name'],
                                      overflow: TextOverflow.ellipsis,
                                      style: const TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                  ),
                                  Container(
                                    margin: const EdgeInsets.only(left: 20),
                                    padding: const EdgeInsets.all(5),
                                    decoration: BoxDecoration(
                                      border: Border.all(
                                        color: secondaryBg,
                                      ),
                                    ),
                                    child: const Text(
                                      'Visit Shop',
                                      style: TextStyle(
                                        fontSize: 15,
                                        fontWeight: FontWeight.w500,
                                        color: secondaryBg,
                                      ),
                                    ),
                                  )
                                ],
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                              OrderListWidget(
                                items: order['items'],
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                              Row(
                                children: [
                                  Text(
                                    "Payment Type: ${paymentType(order['order']['payment_type'])}",
                                    style: const TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                  if (order['order']['payment_type'] != 1)
                                    if (order['checkout'] != null)
                                      if (order['checkout']['status'] == 2)
                                        const Text(
                                          "| Paid",
                                          style: TextStyle(
                                            fontSize: 18,
                                            fontWeight: FontWeight.w500,
                                          ),
                                        ),
                                ],
                              ),
                              const SizedBox(
                                height: 5,
                              ),
                              Text(
                                "Total Price: ${double.parse(order['order']['total_amount'].toString()).toStringAsFixed(2)}",
                                style: const TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              if (order['order']['status'] == 5)
                                if (order['review'] == 0)
                                  GestureDetector(
                                    onTap: () {
                                      Navigator.of(context).push(
                                        MaterialPageRoute(
                                          builder: (context) =>
                                              ReviewDrivingSchool(
                                            schoolId: order['order']
                                                ['school_id'],
                                            orderId: order['order']['id'],
                                          ),
                                        ),
                                      );
                                    },
                                    child: Container(
                                      width: double.infinity,
                                      margin: const EdgeInsets.only(top: 20),
                                      padding: const EdgeInsets.all(10),
                                      decoration: BoxDecoration(
                                        border: Border.all(
                                          color: secondaryBg,
                                        ),
                                      ),
                                      child: const Center(
                                        child: Text(
                                          'Rate Driving School',
                                          style: TextStyle(
                                            fontSize: 15,
                                            fontWeight: FontWeight.w500,
                                            color: secondaryBg,
                                          ),
                                        ),
                                      ),
                                    ),
                                  )
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
