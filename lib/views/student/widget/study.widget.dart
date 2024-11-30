import 'package:flutter/material.dart';
import 'package:quizlet_xspin/base/base.page.dart';
import 'package:quizlet_xspin/constants/app_color.dart';
import 'package:quizlet_xspin/views/home/widget/flipcard.widget.dart';
import 'package:quizlet_xspin/views/student/widget/button.widget.dart';

class StudyWidget extends StatefulWidget {
  const StudyWidget({super.key});

  @override
  State<StudyWidget> createState() => _StudyWidgetState();
}

class _StudyWidgetState extends State<StudyWidget> {
  @override
  Widget build(BuildContext context) {
    return BasePage(
        title: 'Bài học',
        showMore: true,
        body: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            FlipCardCarousel(), SizedBox(height: 20),
            ButtonStudyWidget(
              icon: Icons.menu_book_sharp,
              colorfont: AppColor.darkColor,
              title: 'Học Flash Card',
              ontap: () {},
              colorBorder: AppColor.appBarColor,
            ),
            SizedBox(height: 20), // Khoảng cách giữa các nút

            // Nút có viền màu đỏ
            ButtonStudyWidget(
              icon: Icons.check_box_outlined,
              colorfont: AppColor.darkColor,
              title: 'Chọn đáp án',
              ontap: () {},
              colorBorder: AppColor.appBarColor,
            ),
            SizedBox(height: 20),

            // Nút có viền màu xanh lá cây
            ButtonStudyWidget(
              icon: Icons.text_fields_sharp,
              colorfont: AppColor.darkColor,
              title: 'Nhập đáp án',
              ontap: () {},
              colorBorder: AppColor.appBarColor,
            ),
          ],
        ));
  }
}
