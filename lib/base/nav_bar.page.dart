import 'package:crystal_navigation_bar/crystal_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iconly/iconly.dart';
import 'package:quizlet_xspin/constants/app_color.dart';
import 'package:quizlet_xspin/languages/string_extension.dart';

class HomeNavigationBar extends StatefulWidget {
  const HomeNavigationBar({
    super.key,
    required this.currentIndex,
    required this.onTabSelected,
  });
  final int currentIndex;
  final Future<void> Function(int) onTabSelected;

  @override
  State<HomeNavigationBar> createState() => _HomeNavigationBarState();
}

class _HomeNavigationBarState extends State<HomeNavigationBar> {
  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      type: BottomNavigationBarType.fixed,
      // backgroundColor: AppColor.extraColor,
      currentIndex: widget.currentIndex,
      selectedItemColor: AppColor.navBarColor,
      unselectedItemColor: Colors.grey[500],
      onTap: (index) async {
        await widget.onTabSelected(index);
      },
      items: [
        BottomNavigationBarItem(
            icon: Icon(IconlyBold.home), label: 'menuhome'.tr()),
        BottomNavigationBarItem(
            icon: Icon(IconlyBold.document), label: 'library'.tr()),
        BottomNavigationBarItem(
            icon: Icon(IconlyBold.profile), label: 'profile'.tr()),
      ],
    );
  }
}
