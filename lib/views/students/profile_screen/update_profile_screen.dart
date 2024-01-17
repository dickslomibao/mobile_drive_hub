import 'package:flutter/material.dart';
import 'package:mobile_drive_hub/controllers/student/profile_screen_controller.dart';
import 'package:provider/provider.dart';
import 'package:quickalert/models/quickalert_type.dart';
import 'package:quickalert/widgets/quickalert_dialog.dart';

import '../../../constant/palette.dart';
import '../../shared_widget/loader_widget.dart';
import '../../shared_widget/password_form_widget.dart';
import '../../shared_widget/text_form_widget.dart';
import '../../shared_widget/text_form_widget_noprefix.dart';

class UpdateStudentProfileScreen extends StatefulWidget {
  const UpdateStudentProfileScreen({super.key});

  @override
  State<UpdateStudentProfileScreen> createState() =>
      _UpdateStudentProfileScreenState();
}

class _UpdateStudentProfileScreenState
    extends State<UpdateStudentProfileScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController fnameController = TextEditingController();
  final TextEditingController mnameController = TextEditingController();
  final TextEditingController pnumberController = TextEditingController();

  final TextEditingController lnameController = TextEditingController();
  final TextEditingController addressController = TextEditingController();

  String value = "";
  String bdate = "";
  RegExp nameRegex = RegExp(r'^[a-zA-Z ]+$');
  DateTime selectedDate = DateTime.now();
  DateTime initialDate = DateTime.now().subtract(Duration(days: 5443));
  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: initialDate,
      firstDate: DateTime(1900),
      lastDate: DateTime.now().subtract(Duration(days: 5443)),
    );

    if (picked != null && picked != selectedDate) {
      setState(() {
        selectedDate = picked;
        bdate =
            "${selectedDate.year}-${selectedDate.month}-${selectedDate.day}";
      });
    }
  }

  @override
  void initState() {
    final data = context.read<StudentProfileController>().data;
    fnameController.text = data['firstname'] ?? "";
    mnameController.text = data['middlename'] ?? "";
    lnameController.text = data['lastname'] ?? "";
    bdate = data['birthdate'] ?? "";
    if (bdate.isNotEmpty) {
      initialDate = DateTime.tryParse(bdate) ?? initialDate;
    }
    value = data['sex'] ?? "";
    addressController.text = data['address'] ?? "";
    pnumberController.text = data['phone_number'] ?? "";

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(15.0),
            child: Column(
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
                      'Edit Profile',
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
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      TextFormWidgetNoPrefixBuilder(
                        label: 'Firstname',
                        hintText: 'Juan',
                        controller: fnameController,
                        validator: (value) {
                          if (value == "") {
                            return 'Firstname is required';
                          }
                          if (!nameRegex.hasMatch(value)) {
                            return 'Invalid firstname';
                          }
                        },
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      TextFormWidgetNoPrefixBuilder(
                        label: 'Middlename (optional)',
                        controller: mnameController,
                        hintText: '',
                        validator: (value) {
                          if (value != null && value.toString().isNotEmpty) {
                            if (!nameRegex.hasMatch(value)) {
                              return 'Invalid Middlename';
                            }
                          }

                          return null;
                        },
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      TextFormWidgetNoPrefixBuilder(
                        label: 'Lastname',
                        controller: lnameController,
                        hintText: 'Dela Cruz',
                        validator: (value) {
                          if (value == "") {
                            return 'Lastname is required';
                          }
                          if (!nameRegex.hasMatch(value)) {
                            return 'Invalid Lastname';
                          }
                        },
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      const Text(
                        'Birthdate',
                        textAlign: TextAlign.left,
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(
                            vertical: 13, horizontal: 10),
                        decoration: BoxDecoration(
                          border: Border.all(
                            width: 1,
                            color: Color.fromRGBO(0, 0, 0, .1),
                          ),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              bdate,
                              textAlign: TextAlign.left,
                              style: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            GestureDetector(
                              onTap: () {
                                _selectDate(context);
                              },
                              child: const Icon(
                                Icons.calendar_month,
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      const Text(
                        'Sex',
                        textAlign: TextAlign.left,
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      Row(
                        children: [
                          Expanded(
                            child: RadioListTile(
                              value: "Male",
                              groupValue: value,
                              onChanged: (val) {
                                setState(() {
                                  value = val!;
                                });
                              },
                              title: const Text(
                                'Male',
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                          ),
                          Expanded(
                            child: RadioListTile(
                              value: "Female",
                              groupValue: value,
                              onChanged: (val) {
                                setState(() {
                                  value = val!;
                                });
                              },
                              title: const Text(
                                'Female',
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      TextFormWidgetNoPrefixBuilder(
                        label: 'Address',
                        controller: addressController,
                        hintText: '',
                        validator: (value) {
                          if (value == "") {
                            return 'Address is required';
                          }
                        },
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
                              if (bdate.isEmpty) {
                                showDialog(
                                  context: context,
                                  builder: (context) => const AlertDialog(
                                    content: Text(
                                      'Birthdate is required.',
                                      style: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                  ),
                                );
                                return;
                              }
                              if (value.isEmpty) {
                                showDialog(
                                  context: context,
                                  builder: (context) => const AlertDialog(
                                    content: Text(
                                      'Sex is required.',
                                      style: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                  ),
                                );
                                return;
                              }
                              showDialog(
                                context: context,
                                builder: (context) => const LoadingWidget(),
                              );
                              String data = await context
                                  .read<StudentProfileController>()
                                  .udpateInfo(
                                {
                                  'firstname': fnameController.text.trim(),
                                  'middlename': mnameController.text.trim(),
                                  'lastname': lnameController.text.trim(),
                                  'sex': value,
                                  'birthdate': bdate,
                                  'address': addressController.text.trim(),
                                },
                              );
                              if (context.mounted) {
                                Navigator.of(context).pop();
                                if (data == "success") {
                                  QuickAlert.show(
                                    context: context,
                                    type: QuickAlertType.success,
                                    title: "Success!",
                                    text: "",
                                    widget: const Text(
                                      'Profile updated successfully.',
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
                                      context
                                          .read<StudentProfileController>()
                                          .getStudentProfile();
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
                            'Save',
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
              ],
            ),
          ),
        ),
      ),
    );
  }
}
