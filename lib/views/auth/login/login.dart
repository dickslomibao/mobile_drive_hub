import 'dart:math';

import 'package:flutter/material.dart';
import 'package:mobile_drive_hub/constant/palette.dart';
import 'package:mobile_drive_hub/views/auth/login/widgets/bottom_content.dart';
import 'package:mobile_drive_hub/views/auth/login/widgets/login_button_widget.dart';
import 'package:mobile_drive_hub/views/instructurs/bottom_navbar/instructor_screen.dart';
import 'package:mobile_drive_hub/views/shared_widget/loader_widget.dart';
import 'package:mobile_drive_hub/views/students/bottom_navbar/student_screen.dart';
import 'package:provider/provider.dart';
import 'package:quickalert/quickalert.dart';

import '../../../controllers/auth/login_contoller.dart';
import '../../shared_screen/messages/conversation_screen.dart';
import '../../shared_widget/password_form_widget.dart';
import '../../shared_widget/text_form_widget.dart';
import '../register/widgets/register_title_subtitle_widget.dart';
import 'widgets/logo_title_subtitle_widget.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController usernameEmail = TextEditingController();
  final TextEditingController password = TextEditingController();

  Future login() async {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => const LoadingWidget(),
    );
    final response = await context.read<LoginController>().login(
          usernameEmail: usernameEmail.text,
          password: password.text,
        );
    if (context.mounted) {
      Navigator.of(context).pop();
      if (response == "3") {
        Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(
            builder: (context) => StudentMainScreen(),
          ),
          (route) => false,
        );
      } else if (response == "2") {
        Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(
            builder: (context) => InstructormMainScreen(),
          ),
          (route) => false,
        );
      } else {
        QuickAlert.show(
          context: context,
          type: QuickAlertType.error,
          confirmBtnColor: primaryBg,
          title: "Ooppss..",
          confirmBtnTextStyle: const TextStyle(
            fontSize: 15,
            color: Colors.white,
          ),
          text: response,
        );
      }
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
                        'Login in your account',
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
                        TextFormWidgetBuilder(
                          label: 'Username or email: ',
                          controller: usernameEmail,
                          validator: (value) {
                            if (value == "") {
                              return 'Username or email is required';
                            }
                          },
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        PasswordFormWidgetBuilder(
                          onChange: (val) {},
                          label: 'Password: ',
                          controller: password,
                          validator: (value) {
                            if (value == "") {
                              return 'Password is requried';
                            }
                          },
                        ),
                      ],
                    ),
                  ),
                  const Padding(
                    padding: EdgeInsets.only(bottom: 30.0, top: 10),
                    child: Text(
                      'Forgot password?',
                      textAlign: TextAlign.right,
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                  LoginButtonWidget(
                    onPressed: () async {
                      if (_formKey.currentState!.validate()) {
                        login();
                      }
                    },
                  ),
                  const BottomContentWidget(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
