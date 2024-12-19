import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:quizlet_xspin/constants/app_color.dart';
import 'package:quizlet_xspin/languages/string_extension.dart';
import 'package:quizlet_xspin/theme/theme_service.dart';
import 'package:quizlet_xspin/viewmodel/index.vm.dart';
import 'package:quizlet_xspin/viewmodel/lst_flash_card.vm.dart';
import 'package:quizlet_xspin/views/student/study.page.dart';

class MenuWidget extends StatefulWidget {
  const MenuWidget(
      {super.key, required this.indexViewModel, required this.lfcViewModel});
  final IndexViewModel indexViewModel;
  final ListFlashCardViewModel lfcViewModel;
  @override
  State<MenuWidget> createState() => _MenuWidgetState();
}

class _MenuWidgetState extends State<MenuWidget> {
  final themeService = GetIt.instance<ThemeService>();

  @override
  Widget build(BuildContext context) {
    final isDarkMode = themeService.isDarkMode;

    final colorCard = isDarkMode
        ? const Color.fromARGB(255, 45, 43, 43)
        : AppColor.extraColor;

    return Column(
      children: [
        SizedBox(
          height: MediaQuery.of(context).size.height * 0.25,
          child: Card(
            color: colorCard,
            child: GridView.count(
              crossAxisCount: 4,
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              children: [
                _buildMenuItem(Icons.school, 'study'.tr(), () async {
                  // widget.lfcViewModel.viewContext = context;
                  // await widget.lfcViewModel.getListFlashCard();
                  // Navigator.push(
                  //     context,
                  //     MaterialPageRoute(
                  //         builder: (context) => StudyPage(
                  //               viewModel: widget.lfcViewModel,
                  //               data: widget.lfcViewModel.ListData,
                  //             )));
                }, AppColor.blue),
                _buildMenuItem(
                    Icons.book, 'readbook'.tr(), () {}, AppColor.lightRed),
                _buildMenuItem(Icons.format_bold_sharp, 'grammar'.tr(), () {},
                    AppColor.green),
                _buildMenuItem(Icons.check, 'test'.tr(), () {}, AppColor.pink),
                _buildMenuItem(Icons.check, 'test'.tr(), () {}, AppColor.pink),
                _buildMenuItem(Icons.check, 'test'.tr(), () {}, AppColor.pink),
                _buildMenuItem(Icons.check, 'test'.tr(), () {}, AppColor.pink),
                _buildMenuItem(Icons.check, 'test'.tr(), () {}, AppColor.pink),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildMenuItem(
      IconData icon, String title, Function onTap, Color color) {
    return InkWell(
      child: GestureDetector(
        onTap: () {
          onTap();
        },
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: EdgeInsets.all(8),
              decoration: BoxDecoration(
                  color: color, borderRadius: BorderRadius.circular(10)),
              child: Icon(
                icon,
                size: 30,
                color: AppColor.extraColor,
              ),
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
