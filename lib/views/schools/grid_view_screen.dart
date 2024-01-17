import 'package:flutter/material.dart';
import 'package:mobile_drive_hub/model/driving_school_model.dart';
import 'package:mobile_drive_hub/views/schools/school_home_screen.dart';
import 'package:persistent_bottom_nav_bar_v2/persistent-tab-view.dart';

import '../../constant/palette.dart';
import '../shared_widget/rating_star_builder.dart';
import 'widgets/home_widgets.dart';

class GridDrivingSchoolView extends StatelessWidget {
  const GridDrivingSchoolView({super.key, required this.listDrivingSchool});
  final List<DrivingSchoolModel> listDrivingSchool;

  void _showPopupMenu(BuildContext context) {
    final RenderBox button = context.findRenderObject() as RenderBox;
    final Offset offset =
        button.localToGlobal(Offset.zero, ancestor: context.findRenderObject());
    // final read = context.read<FilterCoursesController>();
    showMenu(
      context: context,
      position: RelativeRect.fromLTRB(
        offset.dx + (button.size.width * .9),
        offset.dy + (button.size.height * .13),
        offset.dx + button.size.width,
        offset.dy + button.size.height + 10,
      ),
      items: <PopupMenuItem>[
        const PopupMenuItem(
          child: Text(
            'Rating (Ascending)',
            style: TextStyle(
              fontWeight: FontWeight.w500,
              fontSize: 16,
            ),
          ),
        ),
        const PopupMenuItem(
          child: Text(
            'Rating (Descending)',
            style: TextStyle(
              fontWeight: FontWeight.w500,
              fontSize: 16,
            ),
          ),
        ),
        const PopupMenuItem(
          child: Text(
            'Distance (Ascending)',
            style: TextStyle(
              fontWeight: FontWeight.w500,
              fontSize: 16,
            ),
          ),
        ),
        const PopupMenuItem(
          child: Text(
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
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  const Icon(
                    Icons.arrow_back,
                  ),
                  const SizedBox(
                    width: 5,
                  ),
                  const Text(
                    "List of Driving school",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  Spacer(),
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
              SizedBox(
                height: 15,
              ),
              Expanded(
                child: ListView.builder(
                  itemCount: listDrivingSchool.length,
                  itemBuilder: (context, index) {
                    final school = listDrivingSchool[index];
                    return Container(
                      margin: const EdgeInsets.only(
                        bottom: 15,
                      ),
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: const Color.fromRGBO(
                            0,
                            0,
                            0,
                            .1,
                          ),
                        ),
                      ),
                      child: GestureDetector(
                        onTap: () {
                          pushNewScreen(
                            context,
                            screen:
                                SchoolHomeScreen(drivingSchoolModel: school),
                            withNavBar: false,
                            pageTransitionAnimation:
                                PageTransitionAnimation.cupertino,
                          );
                        },
                        child: Padding(
                          padding: const EdgeInsets.all(15.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            // mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Image.network(
                                school.profileImage,
                                height: 200,
                                width: double.infinity,
                                fit: BoxFit.cover,
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              Text(
                                school.name,
                                style: const TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              const SizedBox(
                                height: 5,
                              ),
                              Text(
                                "Address: ${school.address}",
                                style: const TextStyle(
                                  color: textGrey,
                                  fontSize: 15,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              if (school.reviewCount == 0)
                                const Text(
                                  'No review yet.',
                                  style: TextStyle(
                                    color: textGrey,
                                    fontSize: 15,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              if (school.reviewCount > 0)
                                Row(
                                  children: [
                                    Text(
                                      school.rating.toStringAsFixed(1),
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
                                      rating: school.rating,
                                      size: 20,
                                    ),
                                    const SizedBox(
                                      width: 10,
                                    ),
                                    Text(
                                      "(${school.reviewCount} ${school.reviewCount == 1 ? 'Review' : 'Reviews'} )",
                                      style: const TextStyle(
                                        color: textGrey,
                                        fontSize: 15,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                  ],
                                ),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
