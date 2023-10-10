import 'package:flutter/material.dart';

class SingleProduct extends StatelessWidget {
  const SingleProduct({
    super.key,
    required this.image,
  });

  final String image;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 5),
      child: Container(
        width: 180,
        padding: const EdgeInsets.all(10),
        child: Image.network(image, fit: BoxFit.fitHeight),
      ),
    );
  }
}
