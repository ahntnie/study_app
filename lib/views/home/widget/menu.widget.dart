import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:quizlet_xspin/constants/app_color.dart';
import 'package:quizlet_xspin/views/student/study.page.dart';

class MenuWidget extends StatefulWidget {
  const MenuWidget({super.key});

  @override
  State<MenuWidget> createState() => _MenuWidgetState();
}

class _MenuWidgetState extends State<MenuWidget> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Card(
        color: AppColor.extraColor.withOpacity(0.85),
        elevation: 5,
        child: Column(
          children: [
            GridView.count(
              crossAxisCount: 3,
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              children: [
                _buildMenuItem(Icons.school, 'Học', () {
                  print('Nhấn 1');
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => StudyPage()));
                }),
                _buildMenuItem(Icons.fact_check, 'Kiểm tra', () {
                  print('Nhấn 2');
                }),
                _buildMenuItem(Icons.settings, 'Cài đặt', () {
                  print('Nhấn 13');
                }),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMenuItem(IconData icon, String title, Function onTap) {
    return InkWell(
      child: GestureDetector(
        onTap: () {
          onTap();
        },
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              icon,
              size: 30,
              color: Colors.pink,
            ),
            SizedBox(height: 4),
            Text(title,
                style: GoogleFonts.aBeeZee(
                    fontSize: 12, fontWeight: FontWeight.bold))
          ],
        ),
      ),
    );
  }
}
