import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:mobile_drive_hub/constant/const_method.dart';

class OrderHeaderWidget extends StatelessWidget {
  const OrderHeaderWidget(
      {super.key, required this.status, required this.dateOrdered});
  final int status;
  final String dateOrdered;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        top: 15.0,
        right: 15,
        left: 15,
        bottom: 5,
      ),
      child: Row(
        children: [
          CircleAvatar(
            backgroundColor: const Color.fromRGBO(0, 0, 0, .03),
            child: Image.asset(
              'assets/images/waiting.png',
              width: 30,
              height: 30,
            ),
          ),
          const SizedBox(
            width: 10,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                orderStatus(status),
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                ),
              ),
              Text(
                'Ordered Date: ${DateFormat('MMM d, yyyy - h:mm a ').format(DateTime.parse(dateOrdered))}',
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                  color: Color.fromRGBO(0, 0, 0, .7),
                ),
              ),
            ],
          ),
          const Spacer(),
          const Icon(Icons.info_outline),
        ],
      ),
    );
  }
}
