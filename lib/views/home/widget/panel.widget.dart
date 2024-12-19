import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:quizlet_xspin/constants/app_color.dart';

class PanelWidget extends StatefulWidget {
  const PanelWidget({super.key});

  @override
  State<PanelWidget> createState() => _PanelWidgetState();
}

class _PanelWidgetState extends State<PanelWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColor.extraColor,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.3),
            spreadRadius: 2,
            blurRadius: 5,
            offset: Offset(2, 4),
          ),
        ],
      ),
      width: MediaQuery.of(context).size.width / 0.1,
      height: 200,
      child: Center(child: Image.asset('assets/logo.png')),
    );
  }
}
