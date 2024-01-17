import 'package:flutter/material.dart';
import 'package:mobile_drive_hub/constant/palette.dart';
import 'package:mobile_drive_hub/controllers/student/profile_screen_controller.dart';
import 'package:mobile_drive_hub/views/auth/register/widgets/password_validator_widget.dart';
import 'package:mobile_drive_hub/views/shared_widget/loader_widget.dart';
import 'package:provider/provider.dart';
import 'package:quickalert/models/quickalert_type.dart';
import 'package:quickalert/widgets/quickalert_dialog.dart';
import '../../shared_widget/password_form_widget.dart';

class ChangePasswordScreen extends StatefulWidget {
  const ChangePasswordScreen({
    super.key,
  });

  @override
  State<ChangePasswordScreen> createState() => _ChangePasswordScreenState();
}

class _ChangePasswordScreenState extends State<ChangePasswordScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController oldPassword = TextEditingController();

  final TextEditingController passwordController = TextEditingController();
  final TextEditingController comfirmPasswordController =
      TextEditingController();
  List<bool> passValid = [false, false, false, false];
  bool hideValidation = false;
  void passwordOnChange(String val) {
    hideValidation = true;
    if (val.toString().contains(RegExp(r'[a-z]'))) {
      setState(() {
        passValid[0] = true;
      });
    } else {
      setState(() {
        passValid[0] = false;
      });
    }
    if (val.toString().contains(RegExp(r'[A-Z]'))) {
      setState(() {
        passValid[1] = true;
      });
    } else {
      setState(() {
        passValid[1] = false;
      });
    }
    if (val.toString().contains(RegExp(r'[0-9]'))) {
      setState(() {
        passValid[2] = true;
      });
    } else {
      setState(() {
        passValid[2] = false;
      });
    }
    if (val.toString().length >= 8) {
      setState(() {
        passValid[3] = true;
      });
    } else {
      setState(() {
        passValid[3] = false;
      });
    }
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
                        'Change Password',
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
                        PasswordFormWidgetBuilder(
                          label: 'Old password: ',
                          hint: '********',
                          controller: oldPassword,
                          onChange: () {},
                          validator: (value) {
                            if (value == "") {
                              return 'Old password is requried';
                            }
                          },
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        PasswordFormWidgetBuilder(
                          label: 'New Password: ',
                          hint: '********',
                          controller: passwordController,
                          onChange: passwordOnChange,
                          validator: (value) {
                            if (value == "") {
                              return 'Password is requried';
                            }
                            if (value.length <= 7) {
                              return 'Password is minimum of 8 characters';
                            }
                          },
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Visibility(
                          visible: hideValidation,
                          child: Align(
                            alignment: Alignment.centerLeft,
                            child: Container(
                              padding:
                                  const EdgeInsets.only(top: 10, bottom: 20),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  PasswordValidatorWidget(
                                    isValid: passValid[0],
                                    text: 'one lowercase character',
                                  ),
                                  PasswordValidatorWidget(
                                    isValid: passValid[1],
                                    text: 'one uppercase character',
                                  ),
                                  PasswordValidatorWidget(
                                    isValid: passValid[2],
                                    text: 'one number',
                                  ),
                                  PasswordValidatorWidget(
                                    isValid: passValid[3],
                                    text: '8 character minimum',
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        PasswordFormWidgetBuilder(
                          label: 'Comfirm New Password: ',
                          hint: '********',
                          controller: comfirmPasswordController,
                          onChange: () {},
                          validator: (value) {
                            if (value == "") {
                              return 'Password is requried';
                            }
                            if (value.length <= 7) {
                              return 'Password is minimum of 8 characters';
                            }
                          },
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 30,
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
                          showDialog(
                            context: context,
                            builder: (context) => const LoadingWidget(),
                          );
                          String data = await context
                              .read<StudentProfileController>()
                              .changePassword(
                                  oldPassword.text, passwordController.text);
                          if (context.mounted) {
                            Navigator.of(context).pop();
                            if (data == "success") {
                              QuickAlert.show(
                                context: context,
                                type: QuickAlertType.success,
                                title: "Success!",
                                text: "",
                                widget: const Text(
                                  'Password changed successfully.',
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
                                  Navigator.of(context).pop();
                                  Navigator.of(context).pop();
                                },
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
                        'Change password',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
