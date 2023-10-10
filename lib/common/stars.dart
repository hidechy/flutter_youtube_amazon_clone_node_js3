import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

import '../constants/global_variables.dart';

class Stars extends StatelessWidget {
  const Stars({super.key, required this.rating});

  final double rating;

  ///
  @override
  Widget build(BuildContext context) {
    return RatingBarIndicator(
      rating: rating,
      itemSize: 15,
      itemBuilder: (context, _) => const Icon(Icons.star, color: GlobalVariables.secondaryColor),
    );
  }
}
