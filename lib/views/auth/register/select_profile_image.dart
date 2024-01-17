import 'dart:io';
import 'dart:math';

import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mobile_drive_hub/constant/palette.dart';
import 'package:mobile_drive_hub/controllers/email_verification_controller.dart';
import 'package:mobile_drive_hub/views/auth/login/widgets/login_button_widget.dart';
import 'package:mobile_drive_hub/views/auth/register/widgets/register_button_widget.dart';
import 'package:mobile_drive_hub/views/instructurs/bottom_navbar/instructor_screen.dart';
import 'package:mobile_drive_hub/views/shared_widget/loader_widget.dart';
import 'package:mobile_drive_hub/views/students/bottom_navbar/student_screen.dart';
import 'package:provider/provider.dart';
import 'package:quickalert/quickalert.dart';

import '../../../controllers/auth/register_controller.dart';
import 'camera_screen.dart';
import 'email_verify_screen.dart';
import 'widgets/register_title_subtitle_widget.dart';

class SelectProfileImage extends StatefulWidget {
  const SelectProfileImage({super.key});

  @override
  State<SelectProfileImage> createState() => _SelectProfileImageState();
}

class _SelectProfileImageState extends State<SelectProfileImage> {
  File? _photo;

  final ImagePicker _picker = ImagePicker();

  Future imgFromGallery() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.gallery);

    if (context.mounted) {
      if (pickedFile != null) {
        _photo = File(pickedFile.path);
        context.read<RegisterController>().profileChange(
              _photo!,
            );
      } else {}
    }
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final watch = context.watch<RegisterController>();
    final read = context.read<RegisterController>();

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
                crossAxisAlignment: CrossAxisAlignment.center,
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
                        'Select profile image',
                        style: TextStyle(
                          fontSize: 21,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 40,
                  ),
                  const RegisterLogoTitleSubtitleWidget(),
                  Container(
                    height: 200,
                    width: 200,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: watch.profileimage != null
                        ? ClipRRect(
                            borderRadius: BorderRadius.circular(20),
                            child: Image.file(
                              watch.profileimage!,
                              fit: BoxFit.cover,
                            ),
                          )
                        : ClipRRect(
                            borderRadius: BorderRadius.circular(20),
                            child: Image.asset(
                              'assets/images/s_profile.jpg',
                              fit: BoxFit.cover,
                            ),
                          ),
                  ),
                  const SizedBox(
                    height: 40,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      TextButton(
                        onPressed: () async {
                          await imgFromGallery();
                        },
                        child: const Text(
                          'Open gallery',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                      TextButton(
                        onPressed: () async {
                          await availableCameras().then(
                            (value) => Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (_) => CameraPage(cameras: value),
                              ),
                            ),
                          );
                        },
                        child: const Text(
                          'Open Camera',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 40,
                  ),
                  Container(
                    width: double.infinity,
                    child: RegisterButtonWidget(
                      onPressed: () async {
                        if (read.profileimage != null) {
                          showDialog(
                            context: context,
                            builder: (context) => const LoadingWidget(),
                          );
                          final read = context.read<RegisterController>();

                          final result = await context
                              .read<EmailVerificationController>()
                              .sendVerificationEmail(read.email);
                          if (context.mounted) {
                            Navigator.of(context).pop();
                            if (result == 'success') {
                              context.read<RegisterController>().vId = context
                                  .read<EmailVerificationController>()
                                  .id;
                              Navigator.of(context).push(
                                MaterialPageRoute(
                                  builder: (context) =>
                                      const EmailVerifyScreen(),
                                ),
                              );
                            } else {
                              showDialog(
                                context: context,
                                builder: (context) => AlertDialog(
                                  title: const Text('Oppss...'),
                                  content: Text(result),
                                ),
                              );
                            }
                          }
                        }
                      },
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
