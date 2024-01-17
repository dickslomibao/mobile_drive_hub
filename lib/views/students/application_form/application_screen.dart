import 'package:flutter/material.dart';
import 'package:mobile_drive_hub/controllers/student_controller.dart';
import 'package:mobile_drive_hub/views/shared_widget/loader_widget.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../../../model/driving_school_model.dart';
import '../../shared_widget/date_picker_widget.dart';
import '../../shared_widget/text_form_widget_noprefix.dart';

class StudentApplicationScreen extends StatefulWidget {
  const StudentApplicationScreen({super.key, required this.drivingSchoolModel});
  final DrivingSchoolModel drivingSchoolModel;
  @override
  State<StudentApplicationScreen> createState() =>
      _StudentApplicationScreenState();
}

class _StudentApplicationScreenState extends State<StudentApplicationScreen> {
  final TextEditingController fnameController = TextEditingController();
  final TextEditingController mnameController = TextEditingController();
  final TextEditingController lnameController = TextEditingController();
  final TextEditingController mnumberController = TextEditingController();
  final TextEditingController birthdateController = TextEditingController();
  final TextEditingController addressController = TextEditingController();
  final TextEditingController bplaceController = TextEditingController();

  String gender = "dick";
  DateTime selectedDate = DateTime.now();

  Future<void> _selectDate() async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime(2015, 8),
      lastDate: DateTime(2101),
    );
    if (picked != null && picked != selectedDate) {
      setState(() {
        selectedDate = picked;
        birthdateController.text = DateFormat.yMMMMd().format(selectedDate);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: double.infinity,
                color: Color.fromRGBO(0, 0, 0, .02),
                padding: EdgeInsets.all(15.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.drivingSchoolModel.name,
                      style: const TextStyle(
                        fontSize: 23,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    const Text(
                      'Registration Form',
                      style: TextStyle(
                        fontSize: 21,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ),
              Form(
                child: Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      TextFormWidgetNoPrefixBuilder(
                        label: 'Firstname',
                        controller: fnameController,
                        validator: (val) {},
                        hintText: 'Juan',
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      TextFormWidgetNoPrefixBuilder(
                        label: 'Middlename (optional)',
                        controller: mnameController,
                        validator: (val) {},
                        hintText: 'Pustora',
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      TextFormWidgetNoPrefixBuilder(
                        label: 'Lastname',
                        controller: lnameController,
                        validator: (val) {},
                        hintText: 'Dela Cuz',
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      TextFormWidgetNoPrefixBuilder(
                        label: 'Mobile Number',
                        controller: mnumberController,
                        validator: (val) {},
                        hintText: '+63|09........',
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      const Text(
                        'Gender',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      Row(
                        children: [
                          Row(
                            children: [
                              Radio(
                                value: "male",
                                groupValue: gender,
                                onChanged: (value) {
                                  setState(() {
                                    gender = value.toString();
                                  });
                                  print(gender);
                                },
                              ),
                              const Text(
                                'Male',
                                style: TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(
                            width: 20,
                          ),
                          Row(
                            children: [
                              Radio(
                                value: "female",
                                groupValue: gender,
                                onChanged: (value) {
                                  setState(() {
                                    gender = value.toString();
                                  });
                                  print(gender);
                                },
                              ),
                              const Text(
                                'Female',
                                style: TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                      TextFormWidgetNoPrefixBuilder(
                        label: 'Address',
                        controller: addressController,
                        validator: (val) {},
                        hintText: 'Alitaya, Mangaldan, Pangasinan',
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      DatePickerFormWidgetBuilder(
                        controller: birthdateController,
                        label: 'Date of Birth',
                        onTap: () {
                          _selectDate();
                        },
                        validator: (val) {},
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      TextFormWidgetNoPrefixBuilder(
                        label: 'Birthplace',
                        controller: bplaceController,
                        validator: (val) {},
                        hintText: 'Dagupat City',
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      SizedBox(
                        height: 52,
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed: () async {
                            showDialog(
                              context: context,
                              builder: (context) => const LoadingWidget(),
                            );
                            String message = await context
                                .read<StudentController>()
                                .createStudent(
                              {
                                'school_id': widget.drivingSchoolModel.userId,
                                'firstname': fnameController.text.trim(),
                                'middlename': mnameController.text.trim(),
                                'lastname': lnameController.text.trim(),
                                'sex': gender,
                                'mobile_number': mnumberController.text.trim(),
                                'birthdate':
                                    "${selectedDate.year}-${selectedDate.month}-${selectedDate.day}",
                                'birthplace': bplaceController.text.trim(),
                                'address': addressController.text.trim(),
                              },
                            );
                            if (context.mounted) {
                              Navigator.of(context).pop();
                              if (message == 'success') {
                                showDialog(
                                  context: context,
                                  builder: (context) => const AlertDialog(
                                    title: Text('Success'),
                                    content: Text('Successfully created'),
                                  ),
                                );
                              } else {
                                showDialog(
                                  context: context,
                                  builder: (context) => AlertDialog(
                                    title: Text('Oppss...'),
                                    content: Text(message),
                                  ),
                                );
                              }
                            }
                          },
                          style: ElevatedButton.styleFrom(
                            elevation: 0,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(5),
                            ),
                          ),
                          child: const Text(
                            'Register',
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
              ),
            ],
          ),
        ),
      ),
    );
  }
}
