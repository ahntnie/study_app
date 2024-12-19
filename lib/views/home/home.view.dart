import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:quizlet_xspin/base/base.page.dart';
import 'package:quizlet_xspin/base/nav_bar.page.dart';
import 'package:quizlet_xspin/constants/app_color.dart';
import 'package:quizlet_xspin/languages/string_extension.dart';
import 'package:quizlet_xspin/viewmodel/index.vm.dart';
import 'package:quizlet_xspin/viewmodel/lst_flash_card.vm.dart';
import 'package:quizlet_xspin/views/home/widget/menu.widget.dart';
import 'package:quizlet_xspin/views/home/widget/news.widget.dart';
import 'package:quizlet_xspin/views/home/widget/panel.widget.dart';

class HomePage extends StatefulWidget {
  const HomePage(
      {super.key,
      required this.indexViewModel,
      required this.listFlashCardViewModel});
  final IndexViewModel indexViewModel;
  final ListFlashCardViewModel listFlashCardViewModel;
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return BasePage(
        title: 'Xspin Quizlet',
        body: Center(
          child: widget.indexViewModel.listFlashCardViewModel.isBusy
              ? Center(
                  child: CircularProgressIndicator(
                    color: AppColor.primaryColor,
                    // size: 50,
                  ),
                )
              : SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Column(
                      children: [
                        Align(
                            alignment: Alignment.topLeft,
                            child: Text(
                              'source'.tr(),
                              style: GoogleFonts.aBeeZee(
                                  fontSize: 20, fontWeight: FontWeight.w900),
                            )),
                        SizedBox(
                          height: 20,
                        ),
                        PanelWidget(),
                        SizedBox(
                          height: 20,
                        ),
                        MenuWidget(
                          indexViewModel: widget.indexViewModel,
                          lfcViewModel: widget.listFlashCardViewModel,
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Align(
                            alignment: Alignment.topLeft,
                            child: Text(
                              'propose'.tr(),
                              style: GoogleFonts.aBeeZee(
                                  fontSize: 20, fontWeight: FontWeight.w900),
                            )),
                        SizedBox(
                          height: 20,
                        ),
                        NewsWidget()
                      ],
                    ),
                  ),
                ),
        ));
  }
}
