import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:quizlet_xspin/base/base.page.dart';
import 'package:quizlet_xspin/base/nav_bar.page.dart';
import 'package:quizlet_xspin/constants/app_color.dart';
import 'package:quizlet_xspin/languages/string_extension.dart';
import 'package:quizlet_xspin/viewmodel/lst_flash_card.vm.dart';
import 'package:stacked/stacked.dart';

class QuizView extends StatefulWidget {
  final String idListCard;
  final ListFlashCardViewModel listFlashCardViewModel;
  QuizView({required this.idListCard, required this.listFlashCardViewModel});

  @override
  State<QuizView> createState() => _QuizViewState();
}

class _QuizViewState extends State<QuizView> {
  int answeredCount = 0;
  int correctCount = 0;
  List<String> answerStatuses = [];

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder.reactive(
      disposeViewModel: false,
      viewModelBuilder: () => widget.listFlashCardViewModel,
      onViewModelReady: (viewModel) async {
        WidgetsBinding.instance.addPostFrameCallback((_) async {
          await viewModel.getFlashCard(widget.idListCard);
        });
      },
      builder: (context, model, child) {
        if (model.isBusy) {
          return BasePage(
            title: 'choose'.tr(),
            body: Center(
                child: CircularProgressIndicator(
              color: AppColor.primaryColor,
            )),
          );
        }

        if (model.lstFlashCard.isEmpty) {
          return BasePage(
            title: 'choose'.tr(),
            body: Center(child: Text('empty'.tr())),
          );
        }

        int totalQuestions = model.lstFlashCard.length;
        double progress = (answeredCount / totalQuestions).clamp(0.0, 1.0);
        double point = 10 / totalQuestions;
        double totalpoint = point * correctCount;
        // Check if all questions have been answered
        if (answeredCount == totalQuestions) {
          return BasePage(
            showLeading: true,
            body: Center(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    totalpoint < 5
                        ? Text('dworry'.tr(),
                            style: GoogleFonts.aBeeZee(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: AppColor.selectColor))
                        : Text('good'.tr(),
                            style: GoogleFonts.aBeeZee(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: AppColor.green)),
                    SizedBox(height: 20),
                    Text('${'correct'.tr()} $correctCount / $totalQuestions!',
                        style: GoogleFonts.aBeeZee(
                            fontSize: 20, fontWeight: FontWeight.w500)),
                    SizedBox(height: 20),
                    Container(
                      decoration: BoxDecoration(
                          border: Border.all(color: AppColor.green),
                          borderRadius: BorderRadius.circular(10)),
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          padding: EdgeInsets.symmetric(
                              vertical: 15, horizontal: 10),
                          textStyle: GoogleFonts.aBeeZee(
                              fontSize: 18, color: AppColor.darkColor),
                          backgroundColor: AppColor.green,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        onPressed: () {
                          setState(() {
                            // Reset quiz
                            answeredCount = 0;
                            correctCount = 0;
                            answerStatuses.clear();
                            model.generateQuestion();
                          });
                        },
                        child: Text(
                          'retry'.tr(),
                          style: GoogleFonts.aBeeZee(
                              fontSize: 20, color: AppColor.extraColor),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        }

        return BasePage(
          title: 'choose'.tr(),
          showLeading: true,
          body: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: double.infinity,
                  padding: EdgeInsets.symmetric(vertical: 10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            padding: const EdgeInsets.symmetric(
                              vertical: 5.0,
                              horizontal: 10.0,
                            ),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: Colors.greenAccent),
                            child: Text(
                              '$answeredCount',
                              style: TextStyle(
                                  fontSize: 18, fontWeight: FontWeight.bold),
                            ),
                          ),
                          Container(
                            padding: const EdgeInsets.symmetric(
                              vertical: 5.0,
                              horizontal: 10.0,
                            ),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: AppColor.lightRed),
                            child: Text(
                              '$totalQuestions',
                              style: TextStyle(
                                  fontSize: 18, fontWeight: FontWeight.bold),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 8),
                      LinearProgressIndicator(
                        value: progress,
                        minHeight: 10,
                        backgroundColor: Colors.grey[300],
                        valueColor:
                            AlwaysStoppedAnimation<Color>(Colors.greenAccent),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 16),
                Text(model.questionText,
                    style: GoogleFonts.aBeeZee(
                      fontSize: 25,
                      fontWeight: FontWeight.w500,
                    )),
                SizedBox(height: 16),
                Text('choose'.tr(),
                    style: GoogleFonts.aBeeZee(
                      fontSize: 15,
                      fontWeight: FontWeight.w500,
                    )),
                SizedBox(height: 5),
                ...model.options.map((option) {
                  int optionIndex = model.options.indexOf(option);
                  // bool isAnswerCorrect = model.correctAnswer == option;
                  return Center(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 10.0),
                      child: Container(
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: answerStatuses.isNotEmpty
                                ? (answerStatuses[optionIndex] == 'correct'
                                    ? Colors.green // Correct answer
                                    : answerStatuses[optionIndex] == 'wrong'
                                        ? Colors.red // Wrong answer
                                        : AppColor.greyColor)
                                : AppColor.greyColor,
                          ),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        width: double.infinity,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            padding: EdgeInsets.symmetric(vertical: 15),
                            textStyle: GoogleFonts.aBeeZee(
                              fontSize: 18,
                            ),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                          onPressed: () {
                            if (answerStatuses.isEmpty) {
                              bool result = model.checkAnswer(option);

                              setState(() {
                                // Update the answer status
                                answerStatuses = List.generate(
                                  model.options.length,
                                  (index) => model.options[index] == option
                                      ? (result ? 'correct' : 'wrong')
                                      : (model.options[index] ==
                                              model.correctAnswer
                                          ? 'correct' // Highlight the correct answer
                                          : ''),
                                );

                                // Update correct count if the answer is correct
                                if (result) {
                                  correctCount++;
                                }
                                answeredCount++;
                              });

                              // Proceed to the next question after a short delay
                              Future.delayed(Duration(seconds: 1), () {
                                model.generateQuestion();
                                setState(() {
                                  answerStatuses.clear();
                                });
                              });
                            }
                          },
                          child: Text(option),
                        ),
                      ),
                    ),
                  );
                }).toList(),
              ],
            ),
          ),
        );
      },
    );
  }
}
