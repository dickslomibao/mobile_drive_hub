import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:mobile_drive_hub/constant/url.dart';
import 'package:mobile_drive_hub/views/shared_widget/rating_star_builder.dart';
import 'package:persistent_bottom_nav_bar_v2/persistent-tab-view.dart';
import 'package:provider/provider.dart';

import '../../../constant/palette.dart';
import '../../../controllers/student/search/filter_courses_controller.dart';
import '../appbar/app_bar_widget.dart';
import 'package:popup_menu/popup_menu.dart';

import '../course_view/course_view_screen.dart';
import '../promo_screen/promo_view_screen.dart';

class ViewPromoScreenResukt extends StatefulWidget {
  const ViewPromoScreenResukt(
      {super.key, required this.promo, required this.schoolId});
  final List<dynamic> promo;
  final String schoolId;
  @override
  State<ViewPromoScreenResukt> createState() => _ViewPromoScreenResuktState();
}

class _ViewPromoScreenResuktState extends State<ViewPromoScreenResukt> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: primaryBg,
      body: SafeArea(
        child: Container(
          color: Colors.white,
          child: Column(
            children: [
              const AppBarWidget(title: "School promo"),
              Expanded(
                child: Container(
                  padding: const EdgeInsets.all(15),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      MasonryGridView.builder(
                        shrinkWrap: true,
                        itemCount: widget.promo.length,
                        mainAxisSpacing: 10,
                        crossAxisSpacing: 10,
                        gridDelegate:
                            const SliverSimpleGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                        ),
                        itemBuilder: (context, index) {
                          final p = widget.promo[index];

                          return GestureDetector(
                            onTap: () {
                              Navigator.of(context).push(
                                MaterialPageRoute(
                                  builder: (context) => PromoViewScreen(
                                    promo: p,
                                    schoolId: widget.schoolId,
                                  ),
                                ),
                              );
                            },
                            child: Card(
                              elevation: 0.5,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  ClipRRect(
                                    borderRadius: BorderRadius.circular(0),
                                    child: Image.network(
                                      WEBSITE_URL + p['thumbnail'],
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        const SizedBox(
                                          height: 5,
                                        ),
                                        Text(
                                          p['name'],
                                          style: const TextStyle(
                                            fontSize: 17,
                                            fontWeight: FontWeight.w500,
                                          ),
                                        ),
                                        const SizedBox(
                                          height: 2,
                                        ),
                                        Text(
                                          "Items: ${p['data'].length}",
                                          style: const TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.w500,
                                          ),
                                        ),
                                        Text(
                                          "Price: ${double.parse(p['price'].toString()).toStringAsFixed(2)}",
                                          style: const TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.w500,
                                          ),
                                        ),
                                      ],
                                    ),
                                  )
                                ],
                              ),
                            ),
                          );
                        },
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
