import 'package:flutter/material.dart';
import 'package:persistent_bottom_nav_bar_v2/persistent-tab-view.dart';
import 'package:provider/provider.dart';

import '../../../../constant/palette.dart';
import '../../../../controllers/student/order/order_controller.dart';
import '../order_view_screen.dart';
import 'order_buttons_widget.dart';
import 'order_header_widget.dart';
import 'order_list_widget.dart';

class ListOrderWidget extends StatelessWidget {
  const ListOrderWidget({super.key, this.status = 0});
  final int status;
  @override
  Widget build(BuildContext context) {
    final watch = context.watch<OrderController>();
    List<dynamic> orders = status == 0
        ? watch.orders
        : watch.orders
            .where((element) => element['order']['status'] == status)
            .toList();
    return RefreshIndicator(
      onRefresh: () async {},
      child: ListView.builder(
        physics: const BouncingScrollPhysics(),
        shrinkWrap: true,
        itemCount: orders.length,
        itemBuilder: (BuildContext context, int index) {
          final order = orders[index];
          return Container(
            margin: EdgeInsets.only(
              bottom: (orders.length - 1) != index ? 15 : 0,
            ),
            decoration: BoxDecoration(
              border: Border.all(
                color: backgroundMainColor,
              ),
            ),
            width: double.infinity,
            child: InkWell(
              splashColor: Colors.black12,
              onTap: () {
                pushNewScreen(
                  context,
                  screen: OrderViewScreen(
                    orderId: order['order']['id'],
                  ),
                  withNavBar: false,
                  pageTransitionAnimation: PageTransitionAnimation.cupertino,
                );
              },
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  OrderHeaderWidget(
                    status: order['order']['status'],
                    dateOrdered: order['order']['date_created'].toString(),
                  ),
                  const Divider(
                    color: Color.fromRGBO(0, 0, 0, 0.1),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                      top: 10,
                      bottom: 15,
                      left: 15,
                      right: 15,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "School name: ${order['order']['name']}",
                          style: const TextStyle(
                            fontSize: 17,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Text(
                          "Item(s): ${order['items'].length}",
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        OrderListWidget(
                          items: order['items'],
                          display: 1,
                        ),
                        if (order['items'].length > 1)
                          const Padding(
                            padding: EdgeInsets.only(top: 20),
                            child: Align(
                              alignment: Alignment.centerRight,
                              child: Text(
                                "View more...",
                                style: TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.w500,
                                  color: textGrey,
                                ),
                              ),
                            ),
                          ),
                        const SizedBox(
                          height: 20,
                        ),
                        Text(
                          "Total price: ${double.parse(order['order']['total_amount'].toString()).toStringAsFixed(2)}",
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        if (order['order']['payment_type'] == 1 &&
                            order['order']['status'] != 6 &&
                            order['order']['status'] != 7)
                          if ((order['order']['total_amount'] -
                                  order['cash_paid']) ==
                              0)
                            const Text(
                              'Payment Completed',
                              style: TextStyle(
                                fontSize: 17,
                                fontWeight: FontWeight.w500,
                              ),
                            )
                          else
                            Text(
                              'Remaining Balance: Php ${(order['order']['total_amount'] - order['cash_paid']).toStringAsFixed(2)}',
                              style: const TextStyle(
                                fontSize: 17,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
