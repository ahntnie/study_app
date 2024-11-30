import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:quizlet_xspin/constants/app_color.dart';

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
    return Container(
      decoration: BoxDecoration(
        border: Border(
          top: BorderSide(
            color: Colors.transparent
                .withOpacity(0.1), // Hoặc màu mong muốn cho gạch ngang
            width: 1.0, // Độ rộng của gạch ngang
          ),
        ),
      ),
      child: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        backgroundColor: Color.fromARGB(255, 75, 87, 160),
        currentIndex: widget.currentIndex,
        fixedColor: AppColor.extraColor,
        unselectedItemColor: Colors.grey[500],
        onTap: (index) async {
          await widget.onTabSelected(index);
        },
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home, size: 24),
            label: 'Trang chủ',
          ),
          BottomNavigationBarItem(
            icon: Container(
              decoration: BoxDecoration(
                color: AppColor.navBarColor, // Màu nền xung quanh icon
                shape: BoxShape.circle, // Hình dạng vòng tròn
                // borderRadius: BorderRadius.circular(10) // Hình dạng vòng tròn
              ),
              padding: EdgeInsets.all(
                  8.0), // Khoảng cách giữa icon và viền của vòng tròn
              child: Center(
                child: Icon(
                  Icons.add,
                  color: AppColor.extraColor, // Màu của icon
                  size: 30.0, // Kích thước icon
                ),
              ),
            ),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person, size: 24),
            label: 'Tôi',
          ),
        ],
      ),
    );
  }
}
