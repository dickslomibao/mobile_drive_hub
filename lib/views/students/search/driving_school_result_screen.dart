import 'package:flutter/material.dart';
import 'package:mobile_drive_hub/constant/url.dart';
import 'package:mobile_drive_hub/controllers/student/search/filter_driving_school_controller.dart';
import 'package:mobile_drive_hub/model/driving_school_model.dart';
import 'package:mobile_drive_hub/views/schools/school_home_screen.dart';
import 'package:mobile_drive_hub/views/shared_widget/rating_star_builder.dart';
import 'package:provider/provider.dart';

import '../../../constant/palette.dart';
import '../../../services/geo_location.dart';
import '../appbar/app_bar_widget.dart';
import 'package:popup_menu/popup_menu.dart';

class DrivingSchoolResultScreen extends StatefulWidget {
  const DrivingSchoolResultScreen({
    super.key,
    required this.name,
    required this.start,
    required this.end,
    required this.rStart,
    required this.rEnd,
  });
  final String name;
  final double start;
  final double end;
  final double rStart;
  final double rEnd;
  @override
  State<DrivingSchoolResultScreen> createState() =>
      _DrivingSchoolResultScreenState();
}

class _DrivingSchoolResultScreenState extends State<DrivingSchoolResultScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    initData();
  }

  void initData() async {
    context.read<FilterDrivingSchoolController>().isLoading = true;
    final location = await geoLocationServices.getPosition();
    if (context.mounted) {
      await context.read<FilterDrivingSchoolController>().filterSchool(
            widget.name,
            location.latitude,
            location.longitude,
            widget.start,
            widget.end,
            widget.rStart,
            widget.rEnd,
          );
    }
  }

  void _showPopupMenu(BuildContext context) {
    final RenderBox button = context.findRenderObject() as RenderBox;
    final Offset offset =
        button.localToGlobal(Offset.zero, ancestor: context.findRenderObject());
    final read = context.read<FilterDrivingSchoolController>();
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
            read.distanceAsc();
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
            read.distanceDesc();
          },
          child: const Text(
            'Distance (Descending)',
            style: TextStyle(
              fontWeight: FontWeight.w500,
              fontSize: 16,
            ),
          ),
        ),
        PopupMenuItem(
          onTap: () {
            read.ratingAsc();
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
            read.ratingDesc();
          },
          child: const Text(
            'Rating (Descending)',
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
    final watch = context.watch<FilterDrivingSchoolController>();
    final schools = watch.schools;
    print(schools);
    return Scaffold(
      backgroundColor: primaryBg,
      body: SafeArea(
          child: Container(
        color: Colors.white,
        child: Column(
          children: [
            const AppBarWidget(title: "Search School", leading: true),
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
                              Text(
                                'Results:(${schools.length})',
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
                                itemCount: schools.length,
                                itemBuilder: (context, index) {
                                  final s = schools[index];
                                  return Container(
                                    padding: const EdgeInsets.all(15),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      border: Border.all(
                                        color: backgroundMainColor,
                                        width: 1,
                                      ),
                                    ),
                                    margin: const EdgeInsets.only(bottom: 10),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(5),
                                          child: Image.network(
                                            WEBSITE_URL + s['profile_image'],
                                            width: double.infinity,
                                            height: 150,
                                            fit: BoxFit.cover,
                                          ),
                                        ),
                                        const SizedBox(
                                          height: 10,
                                        ),
                                        Text(
                                          s['name'],
                                          style: const TextStyle(
                                            fontWeight: FontWeight.w500,
                                            fontSize: 16,
                                          ),
                                        ),
                                        const SizedBox(
                                          height: 5,
                                        ),
                                        Text(
                                          "Address: ${s['address']}",
                                          style: const TextStyle(
                                            fontWeight: FontWeight.w500,
                                            fontSize: 14,
                                            color: textGrey,
                                          ),
                                        ),
                                        const SizedBox(
                                          height: 20,
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Row(
                                              children: [
                                                const Icon(
                                                  Icons.location_on_rounded,
                                                  size: 20,
                                                  color: primaryBg,
                                                ),
                                                const SizedBox(
                                                  width: 10,
                                                ),
                                                Text(
                                                  "${double.parse(s['distance'].toString()).toStringAsFixed(2)} km",
                                                  style: const TextStyle(
                                                    fontWeight: FontWeight.w500,
                                                    fontSize: 16,
                                                  ),
                                                ),
                                              ],
                                            ),
                                            Row(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.center,
                                              children: [
                                                StarRaitingBuilder(
                                                  rating: double.parse(
                                                      s['rating'].toString()),
                                                  size: 20,
                                                ),
                                                const SizedBox(
                                                  width: 10,
                                                ),
                                                Text(
                                                  "${double.parse(s['rating'].toString()).toStringAsFixed(1)} (${s['review_count']})",
                                                  style: const TextStyle(
                                                    fontWeight: FontWeight.w500,
                                                    fontSize: 16,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                        const SizedBox(
                                          height: 20,
                                        ),
                                        Container(
                                          height: 42,
                                          width: double.infinity,
                                          child: ElevatedButton(
                                            style: ElevatedButton.styleFrom(
                                                elevation: 0,
                                                shape: RoundedRectangleBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            5))),
                                            onPressed: () {
                                              Navigator.of(context)
                                                  .push(MaterialPageRoute(
                                                builder: (context) =>
                                                    SchoolHomeScreen(
                                                        drivingSchoolModel:
                                                            DrivingSchoolModel
                                                                .fromJson(s)),
                                              ));
                                            },
                                            child: const Text(
                                              "Visit School",
                                              style: TextStyle(
                                                fontWeight: FontWeight.w500,
                                                fontSize: 16,
                                              ),
                                            ),
                                          ),
                                        )
                                      ],
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
      )),
    );
  }
}
