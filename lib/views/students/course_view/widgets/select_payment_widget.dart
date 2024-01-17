import 'package:flutter/material.dart';

class SelectPaymentWidget extends StatefulWidget {
  const SelectPaymentWidget({super.key});

  @override
  State<SelectPaymentWidget> createState() => _SelectPaymentWidgetState();
}

class _SelectPaymentWidgetState extends State<SelectPaymentWidget> {
  String? selectedCard;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(15.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Select Payment Method: ',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          Column(
            children: [
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
                        setState(() {
                          selectedCard = value;
                        });
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
                        setState(() {
                          selectedCard = value;
                        });
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
                        setState(() {
                          selectedCard = value;
                        });
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
                            children: [
                              const Text(
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
          const Spacer(),
          Container(
            height: 52,
            width: double.infinity,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                elevation: 0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
              onPressed: () {
                switch (selectedCard) {
                  case "3":
                    showDialog(
                      context: context,
                      builder: (context) => const AlertDialog(
                        title: Text('Opps..'),
                        content: Text(
                          'Credit card payment is under developement',
                          style: TextStyle(fontSize: 18),
                        ),
                      ),
                    );
                    break;
                  case "2":
                    showDialog(
                      context: context,
                      builder: (context) => const AlertDialog(
                        title: Text('Opps..'),
                        content: Text(
                          'Gcash payment is under developement',
                          style: TextStyle(fontSize: 18),
                        ),
                      ),
                    );
                    break;
                  case "1":
                    showDialog(
                      context: context,
                      builder: (context) => const AlertDialog(
                        title: Text('Opps..'),
                        content: Text(
                          'Navigate',
                          style: TextStyle(fontSize: 18),
                        ),
                      ),
                    );
                    break;
                  default:
                    showDialog(
                      context: context,
                      builder: (context) => const AlertDialog(
                        title: Text('Opps..'),
                        content: Text(
                          'Select payment method',
                          style: TextStyle(fontSize: 18),
                        ),
                      ),
                    );
                }
              },
              child: const Text(
                'Next',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
