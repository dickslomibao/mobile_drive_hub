import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class StarRaitingBuilder extends StatelessWidget {
  const StarRaitingBuilder(
      {super.key, required this.rating, required this.size});

  final double rating;
  final double size;
  final bool _isVertical = false;
  @override
  Widget build(BuildContext context) {
    return RatingBar.builder(
      initialRating: rating,
      ignoreGestures: true,
      minRating: 1,
      direction: _isVertical ? Axis.vertical : Axis.horizontal,
      allowHalfRating: true,
      unratedColor: Colors.amber.withAlpha(50),
      itemCount: 5,
      itemSize: size,
      itemPadding: EdgeInsets.symmetric(horizontal: 0),
      itemBuilder: (context, _) => Icon(
        Icons.star,
        color: Colors.amber,
      ),
      onRatingUpdate: (rating) {},
      updateOnDrag: true,
    );
  }
}
