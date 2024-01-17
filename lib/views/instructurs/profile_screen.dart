import 'package:flutter/material.dart';
import 'package:mobile_drive_hub/constant/palette.dart';
import 'package:mobile_drive_hub/constant/url.dart';
import 'package:mobile_drive_hub/controllers/student/profile_screen_controller.dart';
import 'package:mobile_drive_hub/services/hive_services.dart';
import 'package:mobile_drive_hub/views/students/profile_screen/change_password.dart';
import 'package:mobile_drive_hub/views/students/profile_screen/edit_phone_number.dart';
import 'package:mobile_drive_hub/views/students/profile_screen/update_profile_screen.dart';
import 'package:mobile_drive_hub/views/students/profile_screen/widget/field_widget.dart';
import 'package:persistent_bottom_nav_bar_v2/persistent-tab-view.dart';
import 'package:provider/provider.dart';

import '../../controllers/instructor/instructor_profile_controller.dart';
import 'edit_profile_screen.dart';

class InstructorProfileScreen extends StatefulWidget {
  const InstructorProfileScreen({super.key});
  @override
  State<InstructorProfileScreen> createState() =>
      _InstructorProfileScreenState();
}

class _InstructorProfileScreenState extends State<InstructorProfileScreen> {
  @override
  void initState() {
    super.initState();
    context.read<InstructorProfileController>().getInstructorProfile();
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final watch = context.watch<InstructorProfileController>();
    return Scaffold(
      body: SafeArea(
        child: watch.isLoading
            ? const Center(
                child: CircularProgressIndicator(),
              )
            : SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      height: 200,
                      width: double.infinity,
                      child: Stack(
                        children: [
                          Container(
                            height: 155,
                            color: primaryBg,
                          ),
                          Positioned(
                            bottom: 0,
                            width: width,
                            child: Center(
                              child: CircleAvatar(
                                backgroundColor: Colors.white,
                                radius: 90,
                                child: CircleAvatar(
                                  radius: 80,
                                  backgroundImage: NetworkImage(
                                    WEBSITE_URL + hiveServices.getProfile(),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.only(
                        left: 15.0,
                        right: 15,
                        bottom: 15,
                        top: 5,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            '${watch.data['firstname']} ${watch.data['lastname']}',
                            style: const TextStyle(
                              fontSize: 21,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          const SizedBox(
                            height: 5,
                          ),
                          Text(
                            watch.data['email'],
                            style: const TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                        vertical: 5,
                        horizontal: 15,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Expanded(
                            child: TextButton(
                              onPressed: () {
                                pushNewScreen(
                                  context,
                                  screen: const UpdateInstructorProfileScreen(),
                                  withNavBar: false,
                                );
                              },
                              child: const Text(
                                'Edit profile',
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          Expanded(
                            child: TextButton(
                              onPressed: () {
                                pushNewScreen(
                                  context,
                                  screen: const ChangePasswordScreen(),
                                  withNavBar: false,
                                );
                              },
                              child: const Text(
                                'Change password',
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          FieldWidget(
                            label: "Username",
                            input: "${watch.data['username'] ?? ""}",
                          ),
                          FieldWidget(
                            label: "Email",
                            input: "${watch.data['email'] ?? ""}",
                          ),
                          FieldWidget(
                            label: "Firstname",
                            input: "${watch.data['firstname'] ?? ""}",
                          ),
                          FieldWidget(
                            label: "Middlename",
                            input: "${watch.data['middlename'] ?? ""}",
                          ),
                          FieldWidget(
                            label: "Lastname",
                            input: "${watch.data['lastname'] ?? ""}",
                          ),
                          Row(
                            children: [
                              Expanded(
                                child: FieldWidget(
                                  label: "Phone number",
                                  input: "${watch.data['phone_number'] ?? ""}",
                                ),
                              ),
                              GestureDetector(
                                onTap: () {
                                  pushNewScreen(
                                    context,
                                    screen: ChangePhoneNumber(
                                      phoneNumber:
                                          watch.data['phone_number'] ?? "",
                                    ),
                                    withNavBar: false,
                                  );
                                },
                                child: const Icon(
                                  Icons.mode_edit_outline_outlined,
                                ),
                              ),
                            ],
                          ),
                          FieldWidget(
                            label: "Birthdate",
                            input: "${watch.data['birthdate'] ?? ""}",
                          ),
                          FieldWidget(
                            label: "Sex",
                            input: "${watch.data['sex'] ?? ""}",
                          ),
                          FieldWidget(
                            label: "Address",
                            input: "${watch.data['address'] ?? ""}",
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 30,
                    )
                  ],
                ),
              ),
      ),
    );
  }
}
