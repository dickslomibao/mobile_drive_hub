import 'package:flutter/material.dart';
import 'package:mobile_drive_hub/model/driving_school_model.dart';
import 'package:mobile_drive_hub/services/course_sevices.dart';
import 'package:mobile_drive_hub/views/schools/widgets/promo_widget.dart';

import '../../../constant/palette.dart';
import '../../../constant/url.dart';
import '../../shared_widget/rating_star_builder.dart';
import 'courses_widget.dart';

class DrivingSchoolHomeWidget extends StatefulWidget {
  const DrivingSchoolHomeWidget({super.key, required this.drivingSchoolModel});
  final DrivingSchoolModel drivingSchoolModel;
  @override
  State<DrivingSchoolHomeWidget> createState() =>
      _DrivingSchoolHomeWidgetState();
}

class _DrivingSchoolHomeWidgetState extends State<DrivingSchoolHomeWidget>
    with SingleTickerProviderStateMixin {
  TabController? _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 7, vsync: this);
  }
  bool fullScreen = true;
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Visibility(
          visible: fullScreen,
          child: Stack(
            children: [
              Image.network(
                widget.drivingSchoolModel.profileImage,
              ),
              Positioned(
                top: 10,
                left: 10,
                child: GestureDetector(
                  onTap: () {
                    Navigator.of(context).pop();
                  },
                  child: Row(
                    children: const [
                      Card(
                        elevation: 5,
                        shape: CircleBorder(),
                        shadowColor: Colors.black38,
                        child: CircleAvatar(
                          backgroundColor: Colors.white,
                          child: Icon(
                            Icons.arrow_back,
                            color: secondaryBg,
                            size: 25,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Positioned(
                top: 10,
                right: 60,
                child: Row(
                  children: const [
                    Card(
                      elevation: 5,
                      shape: CircleBorder(),
                      shadowColor: Colors.black38,
                      child: CircleAvatar(
                        backgroundColor: Colors.white,
                        child: Icon(
                          Icons.favorite_border_outlined,
                          color: textGrey,
                          size: 25,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Positioned(
                top: 10,
                right: 10,
                child: GestureDetector(
                  onTap: () async {
                    print(widget.drivingSchoolModel.userId);
                    print(await courseServices
                        .getSchoolCourses(widget.drivingSchoolModel.userId));
                  },
                  child: Row(
                    children: const [
                      Card(
                        elevation: 5,
                        shape: CircleBorder(),
                        shadowColor: Colors.black38,
                        child: CircleAvatar(
                          backgroundColor: Colors.white,
                          child: Icon(
                            Icons.messenger_outline_outlined,
                            color: textGrey,
                            size: 25,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 15.0, left: 15, right: 15),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                widget.drivingSchoolModel.name,
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(
                height: 5,
              ),
              Text(
                "Address: ${widget.drivingSchoolModel.address}",
                style: const TextStyle(
                  color: textGrey,
                  fontSize: 15,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Row(
                children: const [
                  Text(
                    "4.0",
                    style: TextStyle(
                      color: textGrey,
                      fontSize: 15,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  StarRaitingBuilder(
                    rating: 4.0,
                    size: 20,
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Text(
                    "(107 Reviews)",
                    style: TextStyle(
                      color: textGrey,
                      fontSize: 15,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              Container(
                width: double.infinity,
                height: 1,
                color: Colors.black12,
              ),
              const SizedBox(
                height: 5,
              ),
              Align(
                alignment: Alignment.topLeft,
                child: Row(
                  children: [
                    Expanded(
                      child: TabBar(
                        indicatorColor: primaryBg,
                        isScrollable: true,
                        controller: _tabController,
                        labelStyle: const TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w500,
                        ),
                        labelColor: Colors.black,
                        tabs: const [
                          Tab(
                            text: "About",
                          ),
                          Tab(
                            text: "Courses",
                          ),
                          Tab(
                            text: "Promo",
                          ),
                          Tab(
                            text: "Instructors",
                          ),
                          Tab(
                            text: "Cars",
                          ),
                          Tab(
                            text: "Policy",
                          ),
                          Tab(
                            text: "Reviews",
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          fullScreen = !fullScreen;
                        });
                      },
                      child: Icon(
                        fullScreen
                            ? Icons.fullscreen_outlined
                            : Icons.fullscreen_exit_outlined,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        Expanded(
          child: TabBarView(controller: _tabController, children: [
            SizedBox(),
            CoursesWidget(drivingSchoolModel: widget.drivingSchoolModel),
            PromoWidget(schoolId: widget.drivingSchoolModel.userId),
            SizedBox(),
            SizedBox(),
            SizedBox(),
            SizedBox(),
          ]),
        ),
      ],
    );
  }
}
