import 'package:flutter/material.dart';

class PaymentMethodWidget extends StatelessWidget {
  const PaymentMethodWidget({
    super.key,
    required this.onChange,
    this.selectedCard,
  });
  final Function onChange;
  final String? selectedCard;
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(15),
      color: Colors.white,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "Select payment method:",
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          Row(
            children: [
              Expanded(
                child: RadioListTile(
                  title: Row(
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
                        "Credit Card",
                        style: TextStyle(
                          fontSize: 18,
                        ),
                      ),
                    ],
                  ),
                  value: "3",
                  groupValue: selectedCard,
                  onChanged: (value) {
                    onChange(value);
                  },
                ),
              ),
              const Icon(Icons.info_outline_rounded),
            ],
          ),
          Row(
            children: [
              Expanded(
                child: RadioListTile(
                  title: Row(
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
                        ),
                      ),
                    ],
                  ),
                  value: "2",
                  groupValue: selectedCard,
                  onChanged: (value) {
                    onChange(value);
                  },
                ),
              ),
              const Icon(Icons.info_outline_rounded),
            ],
          ),
          Row(
            children: [
              Expanded(
                child: RadioListTile(
                  title: Row(
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
                        ),
                      ),
                    ],
                  ),
                  value: "1",
                  groupValue: selectedCard,
                  onChanged: (value) {
                    onChange(value);
                  },
                ),
              ),
              GestureDetector(
                onTap: () {
                  showModalBottomSheet(
                    context: context,
                    builder: (context) => Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: const [
                          Text(
                            "Cash Payment",
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          Text('')
                        ],
                      ),
                    ),
                  );
                },
                child: const Icon(Icons.info_outline_rounded),
              ),
            ],
          )
        ],
      ),
    );
  }
}
