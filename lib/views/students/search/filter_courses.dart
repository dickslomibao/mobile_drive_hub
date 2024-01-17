import 'package:app_settings/app_settings.dart';
import 'package:flutter/material.dart';
import 'package:mobile_drive_hub/constant/palette.dart';
import 'package:mobile_drive_hub/controllers/student/search/filter_courses_controller.dart';
import 'package:mobile_drive_hub/views/students/appbar/app_bar_widget.dart';
import 'package:provider/provider.dart';
import 'package:syncfusion_flutter_sliders/sliders.dart';

import '../../../services/geo_location.dart';
import '../../shared_widget/text_form_widget.dart';
import 'courses_result_screen.dart';

class FillterCoursesScreen extends StatefulWidget {
  const FillterCoursesScreen({super.key});

  @override
  State<FillterCoursesScreen> createState() => _FillterCoursesScreenState();
}

class _FillterCoursesScreenState extends State<FillterCoursesScreen> {
  TextEditingController name = TextEditingController();
  SfRangeValues price = const SfRangeValues(0, 100000);
  SfRangeValues rating = const SfRangeValues(0, 5);
  bool type1 = true;
  bool type2 = true;

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: primaryBg,
      body: SafeArea(
          child: Container(
        color: Colors.white,
        height: height,
        child: SingleChildScrollView(
          child: Column(
            children: [
              const AppBarWidget(
                title: 'Filter Courses',
              ),
              Padding(
                padding: const EdgeInsets.all(15.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Course Name:',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    TextFormField(
                      controller: name,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                        decoration: TextDecoration.none,
                      ),
                      decoration: InputDecoration(
                        contentPadding: const EdgeInsets.symmetric(
                          vertical: 0,
                          horizontal: 10,
                        ),
                        focusedErrorBorder: OutlineInputBorder(
                          borderSide: const BorderSide(
                            color: Colors.red,
                            width: 1,
                          ),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        errorBorder: OutlineInputBorder(
                          borderSide: const BorderSide(
                            color: Colors.red,
                            width: 1,
                          ),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: const BorderSide(
                            color: primaryBg,
                            width: 1,
                          ),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        enabledBorder: OutlineInputBorder(
                          gapPadding: 0,
                          borderSide: const BorderSide(
                            width: 1,
                            color: Color.fromRGBO(0, 0, 0, .3),
                          ),
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    const Text(
                      'Type:',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    Row(
                      children: [
                        Checkbox(
                          value: type1,
                          onChanged: (value) {
                            if (type2) {
                              setState(() {
                                type1 = !type1;
                              });
                            }
                          },
                        ),
                        const Text(
                          'Theoritical Course',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Checkbox(
                          value: type2,
                          onChanged: (value) {
                            if (type1) {
                              setState(() {
                                type2 = !type2;
                              });
                            }
                          },
                        ),
                        const Text(
                          'Practical Course',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                    const Text(
                      'Price Range:',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    SfRangeSlider(
                      min: 1,
                      max: 100000,
                      values: price,
                      interval: 25000,
                      showLabels: true,
                      onChanged: (SfRangeValues value) {
                        setState(() {
                          price = value;
                        });
                      },
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'To: ${double.parse(price.start.toString()).toStringAsFixed(0)}',
                          style: const TextStyle(
                            fontSize: 17,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        Text(
                          'From : ${double.parse(price.end.toString()).toStringAsFixed(0)}',
                          style: const TextStyle(
                            fontSize: 17,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    const Text(
                      'Ratings:',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    SfRangeSlider(
                      min: 0,
                      max: 5,
                      values: rating,
                      interval: 1,
                      showLabels: true,
                      onChanged: (SfRangeValues value) {
                        setState(() {
                          rating = value;
                        });
                      },
                    ),
                    const SizedBox(
                      height: 40,
                    ),
                    Container(
                      height: 48,
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: () async {
                          final p = await geoLocationServices.getPermission();

                          if (p == 'granted') {
                            if (context.mounted) {
                              List<String> type = [];
                              if (type1) {
                                type.add("2");
                              }
                              if (type2) {
                                type.add("1");
                              }

                              context
                                  .read<FilterCoursesController>()
                                  .isLoading = true;
                              context
                                  .read<FilterCoursesController>()
                                  .filterCourses(
                                    name.text,
                                    type,
                                    double.parse(price.start.toString())
                                        .toInt(),
                                    double.parse(price.end.toString()).toInt(),
                                    double.parse(rating.start.toString()),
                                    double.parse(rating.end.toString()),
                                  );

                              Navigator.of(context).push(
                                MaterialPageRoute(
                                  builder: (context) =>
                                      const SearchCoursesResult(),
                                ),
                              );
                            }
                          } else if (p == "Turn un your location.") {
                            AppSettings.openAppSettings(
                                type: AppSettingsType.location);
                          }
                        },
                        style: ElevatedButton.styleFrom(
                          elevation: 0,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        child: const Text(
                          'Search',
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
            ],
          ),
        ),
      )),
    );
  }
}
