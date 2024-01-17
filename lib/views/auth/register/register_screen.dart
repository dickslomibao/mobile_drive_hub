import 'dart:io';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:mobile_drive_hub/constant/palette.dart';
import 'package:mobile_drive_hub/services/email_verification_services.dart';
import 'package:mobile_drive_hub/views/auth/register/select_profile_image.dart';
import 'package:mobile_drive_hub/views/auth/login/widgets/bottom_content.dart';
import 'package:mobile_drive_hub/views/auth/login/widgets/login_button_widget.dart';
import 'package:mobile_drive_hub/views/auth/register/widgets/password_validator_widget.dart';
import 'package:mobile_drive_hub/views/auth/register/widgets/register_bottom_content.dart';
import 'package:mobile_drive_hub/views/shared_widget/loader_widget.dart';
import 'package:mobile_drive_hub/views/shared_widget/text_form_widget_noprefix.dart';
import 'package:mobile_drive_hub/views/students/bottom_navbar/student_screen.dart';
import 'package:provider/provider.dart';

import '../../../controllers/auth/register_controller.dart';
import '../../shared_widget/password_form_widget.dart';
import '../../shared_widget/text_form_widget.dart';
import 'package:image_picker/image_picker.dart';
import 'widgets/register_button_widget.dart';
import 'widgets/register_title_subtitle_widget.dart';

class RegistrationScreen extends StatefulWidget {
  const RegistrationScreen({
    super.key,
  });

  @override
  State<RegistrationScreen> createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController fnameController = TextEditingController();
  final TextEditingController lnameController = TextEditingController();
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController emailControler = TextEditingController();

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
                  const SizedBox(
                    height: 20,
                  ),
                  Row(
                    children: const [
                      Icon(
                        Icons.arrow_back,
                      ),
                      SizedBox(
                        width: 20,
                      ),
                      Text(
                        'Create an account',
                        style: TextStyle(
                          fontSize: 23,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                  const RegisterLogoTitleSubtitleWidget(),
                  Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        Row(
                          children: [
                            Expanded(
                              child: TextFormWidgetNoPrefixBuilder(
                                label: 'Firstname',
                                hintText: 'Juan',
                                controller: fnameController,
                                validator: (value) {
                                  if (value == "") {
                                    return 'Firstname is required';
                                  }
                                },
                              ),
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            Expanded(
                              child: TextFormWidgetNoPrefixBuilder(
                                label: 'Lastname',
                                controller: lnameController,
                                hintText: 'Dela Cruz',
                                validator: (value) {
                                  if (value == "") {
                                    return 'Lastname is required';
                                  }
                                },
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        TextFormWidgetNoPrefixBuilder(
                          label: 'Username',
                          hintText: 'abc123',
                          controller: usernameController,
                          validator: (value) {
                            if (value == "") {
                              return 'Username is required';
                            }
                          },
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        TextFormWidgetBuilder(
                          label: 'Email',
                          hint: 'abc123@gmail.com',
                          controller: emailControler,
                          validator: (value) {
                            if (value == "") {
                              return 'Email is required';
                            }
                          },
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        PasswordFormWidgetBuilder(
                          label: 'Password: ',
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
                        PasswordFormWidgetBuilder(
                          onChange: (val) {},
                          label: 'Comfirm Password: ',
                          hint: '********',
                          controller: comfirmPasswordController,
                          validator: (value) {
                            if (value == "") {
                              return 'Cofirm Password is requried';
                            }
                            if (value != passwordController.text) {
                              return "Password didn't mached";
                            }
                          },
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  RegisterButtonWidget(
                    onPressed: () async {
                      if (_formKey.currentState!.validate()) {
                        try {
                          showDialog(
                            context: context,
                            builder: (context) => LoadingWidget(),
                          );
                          final v = await emailVerificationServices
                              .validateEmailUsername(
                                  email: emailControler.text.trim(),
                                  username: usernameController.text.trim());

                          if (context.mounted) {
                            Navigator.of(context).pop();
                            if (v['email'] == true) {
                              showDialog(
                                context: context,
                                builder: (context) => const AlertDialog(
                                  content: Text('Email already used.'),
                                ),
                              );
                              return;
                            }
                            if (v['username'] == true) {
                              showDialog(
                                context: context,
                                builder: (context) => const AlertDialog(
                                  content: Text('Username already used.'),
                                ),
                              );
                              return;
                            }
                            final read = context.read<RegisterController>();

                            read.firstname = fnameController.text.trim();
                            read.username = usernameController.text.trim();
                            read.lastname = lnameController.text.trim();
                            read.email = emailControler.text.trim();
                            read.password = passwordController.text.trim();
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (context) =>
                                    const SelectProfileImage(),
                              ),
                            );
                          }
                        } catch (e) {}
                      }
                    },
                  ),
                  const RegisterBottomContentWidget(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
