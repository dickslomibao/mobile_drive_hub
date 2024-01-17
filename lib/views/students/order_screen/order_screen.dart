import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:mobile_drive_hub/constant/palette.dart';
import 'package:mobile_drive_hub/controllers/student/order/order_controller.dart';
import 'package:provider/provider.dart';
import 'package:pusher_channels_flutter/pusher_channels_flutter.dart';
import '../../../services/token_services.dart';
import '../../splash/last_screen.dart';
import '../appbar/app_bar_widget.dart';
import 'widgets/list_order_widget.dart';

class OrdersScreen extends StatefulWidget {
  const OrdersScreen({super.key});

  @override
  State<OrdersScreen> createState() => _OrdersScreenState();
}

class _OrdersScreenState extends State<OrdersScreen>
    with SingleTickerProviderStateMixin {
  PusherChannelsFlutter pusher = PusherChannelsFlutter.getInstance();

  @override
  void initState() {
    tabController = TabController(length: 8, vsync: this);
    context.read<OrderController>().getStudentOrders();
    // connect();
    super.initState();
  }

  // void connect() async {
  //   String userId = await tokenServices.getUserId();
  //   await pusher.init(
  //     apiKey: '40178e8c6a9375e09f5c',
  //     cluster: 'ap1',
  //   );
  //   await pusher.connect();
  //   await pusher.subscribe(
  //     channelName: "order_change_$userId",
  //     onEvent: event,
  //   );
  // }

  late TabController tabController;

  @override
  Widget build(BuildContext context) {
    final watch = context.watch<OrderController>();
    final height = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: primaryBg,
      body: SafeArea(
        child: Container(
          color: Colors.white,
          height: height,
          child: Stack(
            children: [
              const AppBarWidget(
                title: 'Orders',
              ),
              watch.isLoading
                  ? const Center(
                      child: CircularProgressIndicator(),
                    )
                  : Container(
                      padding: const EdgeInsets.only(
                        top: 15,
                        right: 15,
                        left: 15,
                        bottom: 15,
                      ),
                      margin: const EdgeInsets.only(top: 60),
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Expanded(
                                child: Align(
                                  alignment: Alignment.centerLeft,
                                  child: TabBar(
                                    controller: tabController,
                                    isScrollable: true,
                                    tabs: const [
                                      Tab(
                                        child: Text(
                                          'All',
                                          style: TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.w500,
                                          ),
                                        ),
                                      ),
                                      Tab(
                                        child: Text(
                                          'Pending',
                                          style: TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.w500,
                                          ),
                                        ),
                                      ),
                                      Tab(
                                        child: Text(
                                          'To pay',
                                          style: TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.w500,
                                          ),
                                        ),
                                      ),
                                      Tab(
                                        child: Text(
                                          'Waiting',
                                          style: TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.w500,
                                          ),
                                        ),
                                      ),
                                      Tab(
                                        child: Text(
                                          'Ongoing order',
                                          style: TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.w500,
                                          ),
                                        ),
                                      ),
                                      Tab(
                                        child: Text(
                                          'Completed order',
                                          style: TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.w500,
                                          ),
                                        ),
                                      ),
                                      Tab(
                                        child: Text(
                                          'Cancelled',
                                          style: TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.w500,
                                          ),
                                        ),
                                      ),
                                      Tab(
                                        child: Text(
                                          'Refunded',
                                          style: TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.w500,
                                          ),
                                        ),
                                      ),
                                    ],
                                    labelColor: Colors.black,
                                  ),
                                ),
                              ),
                              IconButton(
                                onPressed: () async {
                                  Fluttertoast.showToast(
                                    msg: "Refreshing",
                                    toastLength: Toast.LENGTH_SHORT,
                                    gravity: ToastGravity.CENTER,
                                    timeInSecForIosWeb: 1,
                                    backgroundColor: primaryBg,
                                    textColor: Colors.white,
                                    fontSize: 16.0,
                                  );
                                  await context
                                      .read<OrderController>()
                                      .getStudentOrders();
                                  Fluttertoast.showToast(
                                    msg: "Refresh Success",
                                    toastLength: Toast.LENGTH_SHORT,
                                    gravity: ToastGravity.CENTER,
                                    timeInSecForIosWeb: 1,
                                    backgroundColor: primaryBg,
                                    textColor: Colors.white,
                                    fontSize: 16.0,
                                  );
                                },
                                icon: Icon(Icons.refresh_rounded),
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Expanded(
                            child: TabBarView(
                              controller: tabController,
                              children: const [
                                ListOrderWidget(),
                                ListOrderWidget(status: 1),
                                ListOrderWidget(status: 2),
                                ListOrderWidget(status: 3),
                                ListOrderWidget(status: 4),
                                ListOrderWidget(status: 5),
                                ListOrderWidget(status: 6),
                                ListOrderWidget(status: 7),
                              ],
                            ),
                          )
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
