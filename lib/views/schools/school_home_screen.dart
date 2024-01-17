import 'package:flutter/material.dart';
import 'package:mobile_drive_hub/services/school_services.dart';
import 'package:mobile_drive_hub/views/schools/widgets/courses_widget.dart';
import 'package:mobile_drive_hub/views/schools/widgets/promo_widget.dart';

import '../../constant/palette.dart';
import '../../constant/url.dart';
import '../../model/driving_school_model.dart';
import '../shared_screen/messages/messages_screen.dart';
import '../shared_widget/rating_star_builder.dart';

class SchoolHomeScreen extends StatefulWidget {
  const SchoolHomeScreen({super.key, required this.drivingSchoolModel});

  final DrivingSchoolModel drivingSchoolModel;
  @override
  State<SchoolHomeScreen> createState() => _SchoolHomeScreenState();
}

class _SchoolHomeScreenState extends State<SchoolHomeScreen>
    with SingleTickerProviderStateMixin {
  TabController? _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 5, vsync: this);
  }

  bool fullScreen = true;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Visibility(
              visible: fullScreen,
              child: Stack(
                children: [
                  Image.network(
                    widget.drivingSchoolModel.profileImage,
                    width: double.infinity,
                    height: 200,
                    fit: BoxFit.cover,
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
                  // Positioned(
                  //   top: 10,
                  //   right: 60,
                  //   child: Row(
                  //     children: const [
                  //       Card(
                  //         elevation: 5,
                  //         shape: CircleBorder(),
                  //         shadowColor: Colors.black38,
                  //         child: CircleAvatar(
                  //           backgroundColor: Colors.white,
                  //           child: Icon(
                  //             Icons.favorite_border_outlined,
                  //             color: textGrey,
                  //             size: 21,
                  //           ),
                  //         ),
                  //       ),
                  //     ],
                  //   ),
                  // ),
                  Positioned(
                    top: 10,
                    right: 10,
                    child: GestureDetector(
                      onTap: () async {
                        Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) {
                            return MessagesScreen(
                              userId: widget.drivingSchoolModel.userId,
                              profile: widget.drivingSchoolModel.profileImage,
                              name: widget.drivingSchoolModel.name,
                            );
                          },
                        ));
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
                                Icons.chat_bubble_outline_rounded,
                                color: textGrey,
                                size: 21,
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
                    height: 10,
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Icon(
                        Icons.location_pin,
                        size: 20,
                        color: primaryBg,
                      ),
                      const SizedBox(
                        width: 5,
                      ),
                      Expanded(
                        child: Text(
                          widget.drivingSchoolModel.address,
                          style: const TextStyle(
                            color: textGrey,
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Text(
                    "${widget.drivingSchoolModel.distance} km away from you",
                    style: const TextStyle(
                      color: textGrey,
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  if (widget.drivingSchoolModel.reviewCount == 0)
                    const Text(
                      "No ratings yet.",
                      style: TextStyle(
                        color: textGrey,
                        fontSize: 15,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  if (widget.drivingSchoolModel.reviewCount > 0)
                    Row(
                      children: [
                        Text(
                          widget.drivingSchoolModel.rating.toStringAsFixed(1),
                          style: const TextStyle(
                            color: textGrey,
                            fontSize: 15,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        const SizedBox(
                          width: 5,
                        ),
                        StarRaitingBuilder(
                          rating: widget.drivingSchoolModel.rating,
                          size: 20,
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        Text(
                          "(${widget.drivingSchoolModel.reviewCount} ${widget.drivingSchoolModel.reviewCount == 1 ? 'Review' : 'Reviews'})",
                          style: const TextStyle(
                            color: textGrey,
                            fontSize: 15,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                  const SizedBox(
                    height: 10,
                  ),
                  if (widget.drivingSchoolModel.accredited == 1)
                    const Text(
                      "Not yet accredited.",
                      style: TextStyle(
                        color: textGrey,
                        fontSize: 15,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  if (widget.drivingSchoolModel.accredited == 2)
                    Row(
                      children: const [
                        Icon(Icons.check),
                        SizedBox(
                          width: 10,
                        ),
                        Text(
                          "Accredited",
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
              child: TabBarView(
                controller: _tabController,
                children: [
                  FutureBuilder(
                    future: schoolServices
                        .getSchoolAbout(widget.drivingSchoolModel.userId),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const Center(child: CircularProgressIndicator());
                      }
                      if (snapshot.hasError) {
                        return const Center(
                          child: Text(
                            'Something went wrong.',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        );
                      }
                      if (snapshot.data == null) {
                        return const Center(
                          child: Text(
                            'No info yet',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        );
                      }
                      if (snapshot.data['about'] == null) {
                        return const Center(
                          child: Text(
                            'No info yet',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        );
                      }
                      return SingleChildScrollView(
                        child: Padding(
                          padding: const EdgeInsets.all(15.0),
                          child: Text(
                            snapshot.data['about']['content'],
                            textAlign: TextAlign.justify,
                            style: const TextStyle(
                              fontSize: 17,
                              fontWeight: FontWeight.w500,
                              height: 1.5,
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                  CoursesWidget(drivingSchoolModel: widget.drivingSchoolModel),
                  PromoWidget(schoolId: widget.drivingSchoolModel.userId),
                  FutureBuilder(
                    future: schoolServices
                        .getSchoolPolicy(widget.drivingSchoolModel.userId),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const Center(child: CircularProgressIndicator());
                      }
                      if (snapshot.hasError) {
                        return const Center(
                          child: Text(
                            'Something went wrong.',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        );
                      }
                      if (snapshot.data == null) {
                        return const Center(
                          child: Text(
                            'No info yet',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        );
                      }
                      if (snapshot.data['about'] == null) {
                        return const Center(
                          child: Text(
                            'No info yet',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        );
                      }
                      return SingleChildScrollView(
                        child: Padding(
                          padding: const EdgeInsets.all(15.0),
                          child: Text(
                            snapshot.data['about']['content'],
                            textAlign: TextAlign.justify,
                            style: const TextStyle(
                              fontSize: 17,
                              fontWeight: FontWeight.w500,
                              height: 1.5,
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                  FutureBuilder(
                    future: schoolServices
                        .getSchoolReview(widget.drivingSchoolModel.userId),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const Center(child: CircularProgressIndicator());
                      }
                      if (snapshot.hasError) {
                        return const Center(
                          child: Text(
                            'Something went wrong.',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        );
                      }
                      final reviews = snapshot.data!;
                      if (reviews.isEmpty) {
                        return const Center(
                          child: Text(
                            'No review yet',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        );
                      }
                      return Padding(
                        padding: const EdgeInsets.only(
                          bottom: 15,
                          left: 15,
                          right: 15,
                        ),
                        child: ListView.builder(
                          padding: const EdgeInsets.only(),
                          itemCount: reviews.length,
                          itemBuilder: (context, index) {
                            final r = reviews[index];
                            return Container(
                              margin: const EdgeInsets.only(bottom: 10),
                              decoration: const BoxDecoration(
                                border: Border(
                                  bottom: BorderSide(
                                    color: Color.fromRGBO(
                                      0,
                                      0,
                                      0,
                                      .1,
                                    ),
                                  ),
                                ),
                              ),
                              padding: const EdgeInsets.all(15),
                              child: r['anonymous'] == 2
                                  ? Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          'anonymous',
                                          style: const TextStyle(
                                            fontSize: 17,
                                            fontWeight: FontWeight.w500,
                                          ),
                                        ),
                                        const SizedBox(
                                          height: 5,
                                        ),
                                        StarRaitingBuilder(
                                          rating: double.parse(
                                            r['rating'].toString(),
                                          ),
                                          size: 20,
                                        ),
                                        const SizedBox(
                                          height: 15,
                                        ),
                                        Text(
                                          r['content'],
                                          style: const TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.w500,
                                          ),
                                        ),
                                      ],
                                    )
                                  : Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        ClipOval(
                                          child: Image.network(
                                            WEBSITE_URL +
                                                r['profile_image'].toString(),
                                            height: 35,
                                            width: 35,
                                            fit: BoxFit.cover,
                                          ),
                                        ),
                                        const SizedBox(
                                          width: 15,
                                        ),
                                        Expanded(
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Row(
                                                children: [
                                                  Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      Text(
                                                        r['firstname'] +
                                                            " " +
                                                            r['lastname'],
                                                        style: const TextStyle(
                                                          fontSize: 17,
                                                          fontWeight:
                                                              FontWeight.w500,
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ],
                                              ),
                                              const SizedBox(
                                                height: 5,
                                              ),
                                              StarRaitingBuilder(
                                                rating: double.parse(
                                                  r['rating'].toString(),
                                                ),
                                                size: 20,
                                              ),
                                              const SizedBox(
                                                height: 15,
                                              ),
                                              Text(
                                                r['content'],
                                                style: const TextStyle(
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.w500,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                            );
                          },
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
