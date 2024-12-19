import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:quizlet_xspin/base/base.page.dart';
import 'package:quizlet_xspin/base/nav_bar.page.dart';
import 'package:quizlet_xspin/constants/app_color.dart';
import 'package:quizlet_xspin/constants/app_fontsize.dart';
import 'package:quizlet_xspin/languages/string_extension.dart';
import 'package:quizlet_xspin/viewmodel/lst_flash_card.vm.dart';
import 'package:quizlet_xspin/views/exam/input_quiz.view.dart';
import 'package:quizlet_xspin/views/exam/quiz.view.dart';
import 'package:quizlet_xspin/views/student/widget/button.widget.dart';
import 'package:quizlet_xspin/views/student/widget/flipcard.widget.dart';
import 'package:quizlet_xspin/views/student/widget/full.flipcard.widget.dart';
import 'package:stacked/stacked.dart';

class StudyWidget extends StatefulWidget {
  const StudyWidget(
      {super.key, required this.idListCard, required this.viewModel});
  final String idListCard;
  final ListFlashCardViewModel viewModel;
  @override
  State<StudyWidget> createState() => _StudyWidgetState();
}

class _StudyWidgetState extends State<StudyWidget> {
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder.reactive(
        disposeViewModel: false,
        viewModelBuilder: () => widget.viewModel,
        onViewModelReady: (viewModel) async {
          WidgetsBinding.instance.addPostFrameCallback((_) async {
            await viewModel.getFlashCard(widget.idListCard);
          });
        },
        builder: (context, viewModel, child) {
          return BasePage(
              showLeading: true,
              title: 'lesson'.tr(),
              showMore: true,
              body: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  widget.viewModel.isBusy
                      ? CircularProgressIndicator(
                          color: AppColor.oceanColor,
                        )
                      : viewModel.lstFlashCard.isEmpty
                          ? Padding(
                              padding: const EdgeInsets.all(16.0),
                              child: Container(
                                  decoration: BoxDecoration(
                                    color: AppColor.extraColor.withOpacity(0.7),
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
                                  width:
                                      MediaQuery.of(context).size.width / 0.1,
                                  height: 200,
                                  child: Center(
                                      child: Text(
                                    'empty'.tr(),
                                    style: GoogleFonts.aBeeZee(
                                        fontSize: AppFontSize.sizeLarge),
                                  ))),
                            )
                          : FlipCardCarousel(
                              idListCard: widget.idListCard,
                              viewModel: widget.viewModel,
                            ),
                  SizedBox(height: 20),
                  ButtonStudyWidget(
                    icon: Icons.menu_book_sharp,
                    colorfont: AppColor.darkColor,
                    title: 'flashcard'.tr(),
                    ontap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => FullScreenFlashcardsPage(
                            lstFlashCard: widget.viewModel.lstFlashCard,
                            initialIndex: 0,
                          ),
                        ),
                      );
                    },
                    colorBorder: AppColor.appBarColor,
                  ),
                  SizedBox(height: 20),
                  ButtonStudyWidget(
                    icon: Icons.check_box_outlined,
                    colorfont: AppColor.darkColor,
                    title: 'choose'.tr(),
                    ontap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => QuizView(
                            idListCard: widget
                                .idListCard, // Pass the list to the next page
                            listFlashCardViewModel: widget.viewModel,
                          ),
                        ),
                      );
                    },
                    colorBorder: AppColor.appBarColor,
                  ),
                  SizedBox(height: 20),
                  ButtonStudyWidget(
                    icon: Icons.text_fields_sharp,
                    colorfont: AppColor.darkColor,
                    title: 'enterinput'.tr(),
                    ontap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => InputQuizView(
                            idListCard: widget
                                .idListCard, // Pass the list to the next page
                            listFlashCardViewModel: widget.viewModel,
                          ),
                        ),
                      );
                    },
                    colorBorder: AppColor.appBarColor,
                  ),
                ],
              ));
        });
  }
}
