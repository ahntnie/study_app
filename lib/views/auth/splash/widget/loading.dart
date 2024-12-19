import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:quizlet_xspin/constants/app_color.dart';
import 'package:quizlet_xspin/constants/assets.dart';

class Loading extends StatelessWidget {
  const Loading({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: const BoxConstraints.expand(),
      color: AppColor.darkColor.withAlpha(175),
      child: Center(
        child: Lottie.asset(
          Assets.loading,
          width: 120,
          height: 120,
        ),
      ),
    );
  }
}
