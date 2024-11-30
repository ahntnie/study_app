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
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        decoration: BoxDecoration(
          color: AppColor.extraColor.withOpacity(0.7),
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.3), // Màu của bóng với độ mờ
              spreadRadius: 2, // Bán kính mở rộng của bóng
              blurRadius: 5, // Bán kính làm mờ bóng
              offset: Offset(2, 4), // Độ lệch của bóng theo trục x và y
            ),
          ],
        ),
        width: MediaQuery.of(context).size.width / 0.1,
        height: 200,
        child: Center(child: Image.asset('assets/logo.png')),
      ),
    );
  }
}
