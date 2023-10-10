import 'package:flutter/material.dart';

import '../constants/global_variables.dart';

class CustomButton extends StatelessWidget {
  const CustomButton({
    super.key,
    required this.text,
    required this.onTap,
    this.color = GlobalVariables.secondaryColor,
  });

  final String text;
  final VoidCallback onTap;
  final Color? color;

  ///
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onTap,
      style: ElevatedButton.styleFrom(
        backgroundColor: color,
        minimumSize: const Size(double.infinity, 50),
      ),
      child: Text(text),
    );
  }
}
