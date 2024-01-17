import 'package:flutter/material.dart';
import 'package:mobile_drive_hub/services/token_services.dart';
import 'package:mobile_drive_hub/views/auth/login/login.dart';
import 'package:mobile_drive_hub/views/shared_widget/rating_star_builder.dart';
import 'package:provider/provider.dart';
import '../../../constant/palette.dart';
import '../../../constant/url.dart';
import '../../../controllers/school/school_course_view_controller.dart';
import '../../../services/course_sevices.dart';
import '../checkout_screen/order_details_screen.dart';

class CourseViewScreen extends StatefulWidget {
  const CourseViewScreen({
    super.key,
    required this.courseId,
  });
  final String courseId;
  @override
  State<CourseViewScreen> createState() => _CourseViewScreenState();
}

class _CourseViewScreenState extends State<CourseViewScreen>
    with SingleTickerProviderStateMixin {
  late TabController tabController;
  int selectedVariant = 0;
  int selectedIndex = 0;

  @override
  void initState() {
    context.read<SchoolCourseViewController>().isLoading = true;
    context.read<SchoolCourseViewController>().getSingleCourse(widget.courseId);
    tabController = TabController(length: 2, vsync: this);

    super.initState();
  }

  void availCourse() async {
    final read = context.read<SchoolCourseViewController>();
    String token = await tokenServices.getToken();
    if (token == "") {
      if (context.mounted) {
        showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              title: const Text('Oopps.'),
              content: const Text(
                'Login to avail the course.',
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.black,
                ),
              ),
              actions: [
                OutlinedButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: const Text(
                    'Close',
                    style: TextStyle(
                      fontSize: 15,
                    ),
                  ),
                ),
                ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => const LoginScreen(),
                      ),
                    );
                  },
                  child: const Text(
                    'Login',
                    style: TextStyle(
                      fontSize: 15,
                    ),
                  ),
                )
              ],
            );
          },
        );
      }
      return;
    }
    if (context.mounted) {
      read.courseModel!.selectedVariant = selectedVariant;
      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (context) => OrderDetailsScreen(
            courses: [read.courseModel!],
            schoolId: read.drivingSchoolModel!.userId,
          ),
        ),
      );
    }
  }

  void bottom() {
    final read = context.read<SchoolCourseViewController>();
    showModalBottomSheet(
      context: context,
      builder: (_) {
        return Container(
          color: backgroundMainColor,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: const EdgeInsets.only(
                  top: 15,
                  left: 15,
                  right: 15,
                ),
                child: ListView.builder(
                  shrinkWrap: true,
                  itemCount: read.courseModel!.variants.length,
                  itemBuilder: (context, index) {
                    final variant = read.courseModel!.variants[index];
                    return GestureDetector(
                      onTap: () {
                        Navigator.of(context).pop();
                        setState(() {
                          selectedVariant = variant['id'];
                          selectedIndex = index;
                        });
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: selectedVariant == variant['id']
                              ? primaryBg
                              : secondaryMainColor,
                        ),
                        margin: const EdgeInsets.only(
                          top: 10,
                        ),
                        padding: const EdgeInsets.all(20),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Duration: ${variant['duration']} hrs',
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.w500,
                                color: selectedVariant == variant['id']
                                    ? Colors.white
                                    : Colors.black,
                              ),
                            ),
                            const SizedBox(
                              height: 5,
                            ),
                            Text(
                              'Price: Php ${double.parse(variant['price'].toString()).toStringAsFixed(2)}',
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.w500,
                                color: selectedVariant == variant['id']
                                    ? Colors.white
                                    : Colors.black,
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    final watch = context.watch<SchoolCourseViewController>();
    return Scaffold(
      body: SafeArea(
        child: Container(
          height: height,
          color: secondaryMainColor,
          child: watch.isLoading
              ? const Center(child: CircularProgressIndicator())
              : Stack(
                  children: [
                    SizedBox(
                      height: height - 80,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SafeArea(
                            child: Stack(
                              children: [
                                Image.network(
                                  width: width,
                                  watch.courseModel!.thumbnail,
                                  height: height * .25,
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
                                if (watch.courseModel!.type == 2)
                                  Positioned(
                                    left: 10,
                                    bottom: 10,
                                    child: Container(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 20, vertical: 5),
                                      decoration: BoxDecoration(
                                        color: Colors.black38,
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                      child: const Text(
                                        'Theoretical Course',
                                        style: TextStyle(
                                          fontSize: 15,
                                          fontWeight: FontWeight.w500,
                                          color: Colors.white,
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
                              top: 15.0,
                              left: 15,
                              right: 15,
                              bottom: 5,
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text(
                                  'Course Name:',
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                                const SizedBox(
                                  height: 5,
                                ),
                                Text(
                                  watch.courseModel!.name,
                                  style: const TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                                if (watch.courseModel!.reviewCount > 0)
                                  Padding(
                                    padding: const EdgeInsets.only(top: 15.0),
                                    child: Row(
                                      children: [
                                        Text(
                                          double.parse(watch.courseModel!.rating
                                                  .toString())
                                              .toStringAsFixed(1),
                                          style: const TextStyle(
                                            fontSize: 17,
                                            fontWeight: FontWeight.w500,
                                          ),
                                        ),
                                        const SizedBox(
                                          width: 5,
                                        ),
                                        StarRaitingBuilder(
                                          rating: watch.courseModel!.rating,
                                          size: 20,
                                        ),
                                        const SizedBox(
                                          width: 5,
                                        ),
                                        Text(
                                          '(${watch.courseModel!.reviewCount})',
                                          style: const TextStyle(
                                            fontSize: 17,
                                            fontWeight: FontWeight.w500,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                              ],
                            ),
                          ),
                          const Divider(),
                          GestureDetector(
                            onTap: () {
                              bottom();
                            },
                            child: Container(
                              color: secondaryMainColor,
                              width: double.infinity,
                              padding: const EdgeInsets.symmetric(
                                vertical: 5,
                                horizontal: 15,
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    children: const [
                                      Text(
                                        'Select Course Variant:',
                                        style: TextStyle(
                                          fontSize: 17,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                      Spacer(),
                                      Icon(
                                        Icons.arrow_forward_ios_rounded,
                                        size: 20,
                                      )
                                    ],
                                  ),
                                  if (selectedVariant != 0)
                                    Container(
                                      decoration: const BoxDecoration(
                                        color: secondaryMainColor,
                                      ),
                                      width: double.infinity,
                                      padding: const EdgeInsets.only(top: 5),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            '${watch.courseModel!.variants[selectedIndex]['duration']} hrs -  Php ${double.parse(watch.courseModel!.variants[selectedIndex]['price'].toString()).toStringAsFixed(2)}',
                                            style: const TextStyle(
                                              fontSize: 17,
                                              fontWeight: FontWeight.w500,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                ],
                              ),
                            ),
                          ),
                          const Divider(),
                          Padding(
                            padding: const EdgeInsets.only(left: 15.0),
                            child: Align(
                              alignment: Alignment.centerLeft,
                              child: TabBar(
                                indicatorColor: primaryBg,
                                isScrollable: true,
                                controller: tabController,
                                labelStyle: const TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.w500,
                                ),
                                labelColor: Colors.black,
                                tabs: const [
                                  Tab(
                                    child: Text(
                                      'About',
                                      style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                  ),
                                  Tab(
                                    child: Text(
                                      'Reviews',
                                      style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Expanded(
                            child: TabBarView(
                              controller: tabController,
                              children: [
                                SingleChildScrollView(
                                  child: Container(
                                    padding: const EdgeInsets.only(
                                      bottom: 15,
                                      left: 15,
                                      right: 15,
                                      top: 15,
                                    ),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          watch.courseModel!.description,
                                          textAlign: TextAlign.justify,
                                          style: const TextStyle(
                                            fontSize: 17,
                                            height: 1.4,
                                            fontWeight: FontWeight.w500,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                FutureBuilder(
                                  future: courseServices
                                      .getCourseReview(widget.courseId),
                                  builder: (context, snapshot) {
                                    if (snapshot.connectionState ==
                                        ConnectionState.waiting) {
                                      return const Center(
                                          child: CircularProgressIndicator());
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
                                          return GestureDetector(
                                            onTap: () {},
                                            child: r['anonymous'] == 2
                                                ? Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      Text(
                                                        'anonymous',
                                                        style: const TextStyle(
                                                          fontSize: 17,
                                                          fontWeight:
                                                              FontWeight.w500,
                                                        ),
                                                      ),
                                                      const SizedBox(
                                                        height: 5,
                                                      ),
                                                      StarRaitingBuilder(
                                                        rating: double.parse(
                                                          r['rating']
                                                              .toString(),
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
                                                          fontWeight:
                                                              FontWeight.w500,
                                                        ),
                                                      ),
                                                    ],
                                                  )
                                                : Container(
                                                    margin:
                                                        const EdgeInsets.only(
                                                            bottom: 10),
                                                    decoration:
                                                        const BoxDecoration(
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
                                                    padding:
                                                        const EdgeInsets.all(
                                                            15),
                                                    child: Row(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: [
                                                        ClipOval(
                                                          child: Image.network(
                                                            WEBSITE_URL +
                                                                r['profile_image']
                                                                    .toString(),
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
                                                                CrossAxisAlignment
                                                                    .start,
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
                                                                        style:
                                                                            const TextStyle(
                                                                          fontSize:
                                                                              17,
                                                                          fontWeight:
                                                                              FontWeight.w500,
                                                                        ),
                                                                      ),
                                                                      // Text(
                                                                      //   schedule['instructor']
                                                                      //       [0]['email'],
                                                                      //   style:
                                                                      //       const TextStyle(
                                                                      //     fontSize: 14,
                                                                      //     fontWeight:
                                                                      //         FontWeight.w500,
                                                                      //   ),
                                                                      // ),
                                                                    ],
                                                                  ),
                                                                ],
                                                              ),
                                                              const SizedBox(
                                                                height: 5,
                                                              ),
                                                              StarRaitingBuilder(
                                                                rating: double
                                                                    .parse(
                                                                  r['rating']
                                                                      .toString(),
                                                                ),
                                                                size: 20,
                                                              ),
                                                              const SizedBox(
                                                                height: 15,
                                                              ),
                                                              Text(
                                                                r['content'],
                                                                style:
                                                                    const TextStyle(
                                                                  fontSize: 16,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w500,
                                                                ),
                                                              )
                                                            ],
                                                          ),
                                                        ),
                                                      ],
                                                    ),
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
                    Positioned(
                      bottom: 0,
                      child: Container(
                        height: 82,
                        width: width,
                        padding: const EdgeInsets.all(15),
                        decoration: const BoxDecoration(
                          color: secondaryMainColor,
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(20),
                            topRight: Radius.circular(20),
                          ),
                        ),
                        child: Row(
                          children: [
                            Expanded(
                              child: SizedBox(
                                height: 52,
                                child: ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                    elevation: 0,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(15),
                                    ),
                                  ),
                                  onPressed: () async {
                                    if (selectedVariant == 0) {
                                      return showDialog(
                                        context: context,
                                        builder: (context) => const AlertDialog(
                                          content: Text(
                                            'Plese select variant',
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                              fontSize: 18,
                                              fontWeight: FontWeight.w500,
                                            ),
                                          ),
                                        ),
                                      );
                                    }

                                    availCourse();
                                  },
                                  child: const Text(
                                    'Avail Course',
                                    style: TextStyle(
                                      fontSize: 18,
                                    ),
                                  ),
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
      ),
    );
  }
}
