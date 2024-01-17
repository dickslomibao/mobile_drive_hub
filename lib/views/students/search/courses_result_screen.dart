import 'package:flutter/material.dart';
import 'package:mobile_drive_hub/constant/url.dart';
import 'package:mobile_drive_hub/views/shared_widget/rating_star_builder.dart';
import 'package:mobile_drive_hub/views/students/search/view_promo_screen.dart';
import 'package:persistent_bottom_nav_bar_v2/persistent-tab-view.dart';
import 'package:provider/provider.dart';

import '../../../constant/palette.dart';
import '../../../controllers/student/search/filter_courses_controller.dart';
import '../appbar/app_bar_widget.dart';
import 'package:popup_menu/popup_menu.dart';

import '../course_view/course_view_screen.dart';

class SearchCoursesResult extends StatefulWidget {
  const SearchCoursesResult({super.key});

  @override
  State<SearchCoursesResult> createState() => _SearchCoursesResultState();
}

class _SearchCoursesResultState extends State<SearchCoursesResult> {
  void _showPopupMenu(BuildContext context) {
    final RenderBox button = context.findRenderObject() as RenderBox;
    final Offset offset =
        button.localToGlobal(Offset.zero, ancestor: context.findRenderObject());
    final read = context.read<FilterCoursesController>();

    showMenu(
      context: context,
      position: RelativeRect.fromLTRB(
        offset.dx + (button.size.width * .9),
        offset.dy + (button.size.height * .18),
        offset.dx + button.size.width,
        offset.dy + button.size.height + 10,
      ),
      items: <PopupMenuItem>[
        PopupMenuItem(
          onTap: () {
            read.sortPrice(true);
          },
          child: const Text(
            'Price (Ascending)',
            style: TextStyle(
              fontWeight: FontWeight.w500,
              fontSize: 16,
            ),
          ),
        ),
        PopupMenuItem(
          onTap: () {
            read.sortPrice(false);
          },
          child: const Text(
            'Price (Descending)',
            style: TextStyle(
              fontWeight: FontWeight.w500,
              fontSize: 16,
            ),
          ),
        ),
        PopupMenuItem(
          onTap: () {
            read.sortRating(true);
          },
          child: const Text(
            'Rating (Ascending)',
            style: TextStyle(
              fontWeight: FontWeight.w500,
              fontSize: 16,
            ),
          ),
        ),
        PopupMenuItem(
          onTap: () {
            read.sortRating(false);
          },
          child: const Text(
            'Rating (Descending)',
            style: TextStyle(
              fontWeight: FontWeight.w500,
              fontSize: 16,
            ),
          ),
        ),
        PopupMenuItem(
          onTap: () {
            read.sortDistance(true);
          },
          child: const Text(
            'Distance (Ascending)',
            style: TextStyle(
              fontWeight: FontWeight.w500,
              fontSize: 16,
            ),
          ),
        ),
        PopupMenuItem(
          onTap: () {
            read.sortDistance(false);
          },
          child: const Text(
            'Distance (Descending)',
            style: TextStyle(
              fontWeight: FontWeight.w500,
              fontSize: 16,
            ),
          ),
        ),
        // Add more menu items as needed
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    final watch = context.watch<FilterCoursesController>();
    final courses = watch.courses;
    print(courses);
    return Scaffold(
      backgroundColor: primaryBg,
      body: SafeArea(
        child: Container(
          color: Colors.white,
          child: Column(
            children: [
              const AppBarWidget(title: "Search Course"),
              Expanded(
                child: Container(
                  padding: const EdgeInsets.all(15),
                  child: watch.isLoading
                      ? const Center(child: CircularProgressIndicator())
                      : Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                const Icon(
                                  Icons.arrow_back_rounded,
                                  size: 25,
                                ),
                                const SizedBox(
                                  width: 10,
                                ),
                                Text(
                                  'Results:(${courses.length})',
                                  style: const TextStyle(
                                    fontWeight: FontWeight.w500,
                                    fontSize: 18,
                                  ),
                                ),
                                const Spacer(),
                                TextButton(
                                  onPressed: () {
                                    _showPopupMenu(context);
                                  },
                                  child: const Text(
                                    'Sort by:',
                                    style: TextStyle(
                                      fontWeight: FontWeight.w500,
                                      fontSize: 18,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(
                              height: 15,
                            ),
                            Expanded(
                              child: RefreshIndicator(
                                onRefresh: () async {},
                                child: ListView.builder(
                                  itemCount: courses.length,
                                  itemBuilder: (context, index) {
                                    final c = courses[index];
                                    return GestureDetector(
                                      onTap: () {
                                        pushNewScreen(
                                          context,
                                          screen: CourseViewScreen(
                                            courseId: c['id'],
                                          ),
                                          withNavBar: false,
                                          pageTransitionAnimation:
                                              PageTransitionAnimation.cupertino,
                                        );
                                      },
                                      child: Container(
                                        padding: const EdgeInsets.all(15),
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          border: Border.all(
                                            color: backgroundMainColor,
                                            width: 1,
                                          ),
                                        ),
                                        margin:
                                            const EdgeInsets.only(bottom: 10),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Row(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                ClipRRect(
                                                  borderRadius:
                                                      BorderRadius.circular(5),
                                                  child: Image.network(
                                                    WEBSITE_URL +
                                                        c['thumbnail'],
                                                    width: 130,
                                                    height: 100,
                                                    fit: BoxFit.cover,
                                                  ),
                                                ),
                                                const SizedBox(
                                                  width: 10,
                                                ),
                                                Expanded(
                                                  child: Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      const Text(
                                                        'Course Name:',
                                                        style: TextStyle(
                                                          fontWeight:
                                                              FontWeight.w500,
                                                          fontSize: 16,
                                                        ),
                                                      ),
                                                      const SizedBox(
                                                        height: 2,
                                                      ),
                                                      Text(
                                                        c['name'],
                                                        maxLines: 2,
                                                        overflow: TextOverflow
                                                            .ellipsis,
                                                        style: const TextStyle(
                                                          fontWeight:
                                                              FontWeight.w500,
                                                          fontSize: 16,
                                                        ),
                                                      ),
                                                      const SizedBox(
                                                        height: 5,
                                                      ),
                                                      const Text(
                                                        "Price Start:",
                                                        style: TextStyle(
                                                          fontWeight:
                                                              FontWeight.w500,
                                                          fontSize: 16,
                                                        ),
                                                      ),
                                                      const SizedBox(
                                                        height: 2,
                                                      ),
                                                      Text(
                                                        "${double.parse(c['min_price'].toString()).toStringAsFixed(2)} Php",
                                                        style: const TextStyle(
                                                          fontWeight:
                                                              FontWeight.w500,
                                                          fontSize: 16,
                                                        ),
                                                      ),
                                                      const SizedBox(
                                                        height: 8,
                                                      ),
                                                      if (c['review_count'] ==
                                                          0)
                                                        const Text(
                                                          'No rating yet.',
                                                          style: TextStyle(
                                                            fontWeight:
                                                                FontWeight.w500,
                                                            fontSize: 16,
                                                          ),
                                                        ),
                                                      if (c['review_count'] > 0)
                                                        Row(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .spaceBetween,
                                                          children: [
                                                            StarRaitingBuilder(
                                                              rating:
                                                                  double.parse(
                                                                c['rating']
                                                                    .toString(),
                                                              ),
                                                              size: 18,
                                                            ),
                                                            Text(
                                                              '${double.parse(c['rating'].toString()).toStringAsFixed(1)} (${c['review_count']})',
                                                              style:
                                                                  const TextStyle(
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w500,
                                                                fontSize: 16,
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                    ],
                                                  ),
                                                ),
                                              ],
                                            ),
                                            const SizedBox(
                                              height: 10,
                                            ),
                                            Text(
                                              'School: ${c['school']['name']}',
                                              style: const TextStyle(
                                                fontWeight: FontWeight.w500,
                                                fontSize: 17,
                                              ),
                                            ),
                                            const SizedBox(
                                              height: 5,
                                            ),
                                            Text(
                                              '${c['school']['address']}',
                                              style: const TextStyle(
                                                fontWeight: FontWeight.w500,
                                                fontSize: 16,
                                              ),
                                            ),
                                            const SizedBox(
                                              height: 5,
                                            ),
                                            Text(
                                              '${c['distance']} away from you.',
                                              style: const TextStyle(
                                                fontWeight: FontWeight.w500,
                                                fontSize: 16,
                                              ),
                                            ),
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.end,
                                              children: [
                                                TextButton(
                                                  onPressed: () {
                                                    Navigator.of(context).push(
                                                      MaterialPageRoute(
                                                        builder: (context) =>
                                                            ViewPromoScreenResukt(
                                                          promo: c['school']
                                                              ['promos'],
                                                          schoolId: c['school']
                                                              ['user_id'],
                                                        ),
                                                      ),
                                                    );
                                                  },
                                                  child: Text(
                                                    'View school promo (${c['school']['promos'].length})',
                                                    style: const TextStyle(
                                                      color: secondaryBg,
                                                      fontSize: 15,
                                                    ),
                                                  ),
                                                )
                                              ],
                                            )
                                          ],
                                        ),
                                      ),
                                    );
                                  },
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
