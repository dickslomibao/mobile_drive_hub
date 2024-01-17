import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:provider/provider.dart';

import '../../../constant/url.dart';
import '../../../controllers/school/promo_controller.dart';
import '../../students/promo_screen/promo_view_screen.dart';

class PromoWidget extends StatefulWidget {
  const PromoWidget({super.key, required this.schoolId});
  final String schoolId;

  @override
  State<PromoWidget> createState() => _PromoWidgetState();
}

class _PromoWidgetState extends State<PromoWidget> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    context.read<PromoController>().getPromo(widget.schoolId);
  }

  @override
  Widget build(BuildContext context) {
    final watch = context.watch<PromoController>();
    final promo = watch.promos;
    if (watch.isLoading) {
      return const Center(child: CircularProgressIndicator());
    } else {
      return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15.0),
        child: MasonryGridView.builder(
          padding: const EdgeInsets.only(
            top: 15,
          ),
          itemCount: promo.length,
          mainAxisSpacing: 10,
          crossAxisSpacing: 10,
          gridDelegate: const SliverSimpleGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
          ),
          itemBuilder: (context, index) {
            final p = promo[index];

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
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(
                            height: 5,
                          ),
                          Text(
                            p['name'],
                            style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          const SizedBox(
                            height: 2,
                          ),
                          Text(
                            "Items: ${p['data'].length}",
                            style: const TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          Text(
                            "Price: ${double.parse(p['price'].toString()).toStringAsFixed(2)}",
                            style: const TextStyle(
                              fontSize: 15,
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
      );
    }
  }
}
