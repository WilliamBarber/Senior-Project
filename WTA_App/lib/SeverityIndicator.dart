import 'package:flutter/material.dart';
import 'package:custom_rating_bar/custom_rating_bar.dart';

double severity = 0;

class SeverityIndicator extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(children: [
      RatingBar(
        filledIcon: Icons.star,
        emptyIcon: Icons.star_border,
        onRatingChanged: (value) => severity = value,
        initialRating: 1,
        maxRating: 5,
      ),
      Text('Issue severity (5 stars is highest severity)'),
    ]);
  }
}