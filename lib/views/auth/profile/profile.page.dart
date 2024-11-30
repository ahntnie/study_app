import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:quizlet_xspin/base/base.page.dart';
import 'package:quizlet_xspin/constants/app_color.dart';
import 'package:quizlet_xspin/constants/app_fontsize.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _HomePageState();
}

class _HomePageState extends State<ProfilePage> {
  @override
  Widget build(BuildContext context) {
    return BasePage(
        floating: FloatingActionButton(
          backgroundColor: AppColor.extraColor.withOpacity(0.3),
          onPressed: () {},
          child: Icon(Icons.edit),
        ),
        title: 'Profile',
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment
                  .stretch, // Đảm bảo phần tử bên trong có toàn bộ chiều rộng
              children: [
                Center(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      SizedBox(
                        height: 20,
                      ),
                      CircleAvatar(
                        radius: 40,
                        backgroundImage: NetworkImage(
                            'https://mandalay.com.vn/wp-content/uploads/2023/06/co-4-la-may-man-avatar-dep-34.jpg',
                            scale: 1),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                        'Test abc',
                        style: GoogleFonts.aBeeZee(
                            fontSize: AppFontSize.sizeMedium),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment
                        .start, // Căn trái cho "Tên người dùng"
                    children: [
                      Text(
                        'Tên người dùng',
                        style: GoogleFonts.aBeeZee(
                            fontSize: AppFontSize.sizeSmall,
                            fontWeight: FontWeight.w800),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Container(
                        width: MediaQuery.of(context).size.width * 0.95,
                        padding: const EdgeInsets.all(8.0),
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.grey, width: 1.5),
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        child: Text(
                          'Test sabc',
                          style: GoogleFonts.aBeeZee(
                              fontSize: AppFontSize.sizeSmall),
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                        'Email',
                        style: GoogleFonts.aBeeZee(
                            fontSize: AppFontSize.sizeSmall,
                            fontWeight: FontWeight.w800),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Container(
                        width: MediaQuery.of(context).size.width * 0.95,
                        padding: const EdgeInsets.all(8.0),
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.grey, width: 1.5),
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        child: Text(
                          'test@gmail.com',
                          style: GoogleFonts.aBeeZee(
                              fontSize: AppFontSize.sizeSmall),
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                        'SĐT',
                        style: GoogleFonts.aBeeZee(
                            fontSize: AppFontSize.sizeSmall,
                            fontWeight: FontWeight.w800),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Container(
                        width: MediaQuery.of(context).size.width * 0.95,
                        padding: const EdgeInsets.all(8.0),
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.grey, width: 1.5),
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        child: Text(
                          '0909889988',
                          style: GoogleFonts.aBeeZee(
                              fontSize: AppFontSize.sizeSmall),
                        ),
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
        ));
  }
}
