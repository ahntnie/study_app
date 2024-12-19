import 'package:flutter/material.dart';
import 'package:quizlet_xspin/constants/app_color.dart';
import 'package:quizlet_xspin/constants/app_fontsize.dart';

class SectionTitle extends StatelessWidget {
  final String title;

  SectionTitle({required this.title});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      child: Text(
        title,
        style: TextStyle(
            fontSize: AppFontSize.sizeMedium, fontWeight: FontWeight.w900),
      ),
    );
  }
}
