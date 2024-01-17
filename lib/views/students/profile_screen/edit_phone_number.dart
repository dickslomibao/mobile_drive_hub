import 'dart:math';

import 'package:flutter/material.dart';
import 'package:mobile_drive_hub/constant/palette.dart';
import 'package:mobile_drive_hub/controllers/student/profile_screen_controller.dart';
import 'package:mobile_drive_hub/views/auth/register/widgets/password_validator_widget.dart';
import 'package:mobile_drive_hub/views/shared_widget/loader_widget.dart';
import 'package:mobile_drive_hub/views/students/profile_screen/opt_verification_screen.dart';
import 'package:mobile_drive_hub/views/students/profile_screen/widget/field_widget.dart';
import 'package:persistent_bottom_nav_bar_v2/persistent-tab-view.dart';
import 'package:provider/provider.dart';
import 'package:quickalert/models/quickalert_type.dart';
import 'package:quickalert/widgets/quickalert_dialog.dart';
import '../../shared_widget/password_form_widget.dart';
import '../../shared_widget/text_form_widget_noprefix.dart';

class ChangePhoneNumber extends StatefulWidget {
  const ChangePhoneNumber({super.key, required this.phoneNumber});
  final String phoneNumber;
  @override
  State<ChangePhoneNumber> createState() => _ChangePhoneNumberState();
}

class _ChangePhoneNumberState extends State<ChangePhoneNumber> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController phonenumberController = TextEditingController();

  @override
  void initState() {
    phonenumberController.text = widget.phoneNumber;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: primaryBg,
      body: SafeArea(
        child: Container(
          height: height,
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20),
              topRight: Radius.circular(20),
            ),
          ),
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(15.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Row(
                    children: [
                      IconButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        icon: const Icon(
                          Icons.arrow_back,
                        ),
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      const Text(
                        'Change phone number',
                        style: TextStyle(
                          fontSize: 21,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        TextFormWidgetNoPrefixBuilder(
                          label: 'Phone number',
                          hintText: '+63|09..',
                          controller: phonenumberController,
                          validator: (value) {
                            final RegExp regex =
                                RegExp(r'^(09|\+639)[0-9]{9}$');
                            if (value == "") {
                              return 'Phone number is required';
                            }
                            if (!regex.hasMatch(value)) {
                              return 'Invalid phoneNumber';
                            }
                          },
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  SizedBox(
                    height: 52,
                    width: double.infinity,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        elevation: 0,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      onPressed: () async {
                        if (_formKey.currentState!.validate()) {
                          if (widget.phoneNumber ==
                              phonenumberController.text) {
                            Navigator.of(context).pop();
                            return;
                          }
                          int randomFourDigitNumber =
                              Random().nextInt(9000) + 1000;
                          showDialog(
                            context: context,
                            builder: (context) => const LoadingWidget(),
                          );
                          String data = await context
                              .read<StudentProfileController>()
                              .sendOtp(
                            {
                              'code': randomFourDigitNumber,
                              'number': phonenumberController.text,
                            },
                          );
                          if (context.mounted) {
                            Navigator.of(context).pop();
                            if (data == "success") {
                              pushNewScreen(
                                context,
                                screen: OtpVerificationScreen(
                                  phoneNumber: phonenumberController.text,
                                  code: randomFourDigitNumber.toString(),
                                ),
                                withNavBar: false,
                              );
                            } else {
                              QuickAlert.show(
                                context: context,
                                type: QuickAlertType.error,
                                title: "Opps!",
                                text: "",
                                widget: Text(
                                  data,
                                  textAlign: TextAlign.center,
                                  style: const TextStyle(
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
                                  Navigator.of(context).pop();
                                },
                              );
                            }
                          }
                        }
                      },
                      child: const Text(
                        'Change phone number',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
