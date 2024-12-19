import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:quizlet_xspin/base/base.page.dart';
import 'package:quizlet_xspin/constants/app_color.dart';
import 'package:quizlet_xspin/languages/string_extension.dart';
import 'package:quizlet_xspin/viewmodel/lst_flash_card.vm.dart';
import 'package:stacked/stacked.dart';

class InputQuizView extends StatefulWidget {
  const InputQuizView(
      {super.key,
      required this.idListCard,
      required this.listFlashCardViewModel});
  final String idListCard;
  final ListFlashCardViewModel listFlashCardViewModel;
  @override
  State<InputQuizView> createState() => _InputQuizViewState();
}

class _InputQuizViewState extends State<InputQuizView> {
  bool isAnswerChecked = false;
  bool isInkwell = false;
  int correctCount = 0;

  int answeredCount = 0;
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
              title: 'enterinput'.tr(),
              body: Center(
                  child: CircularProgressIndicator(
                color: AppColor.primaryColor,
              )),
            );
          }

          if (model.lstFlashCard.isEmpty) {
            return BasePage(
              title: 'enterinput'.tr(),
              body: Center(child: Text('empty'.tr())),
            );
          }
          int totalQuestions = model.lstFlashCard.length;
          double progress = (answeredCount / totalQuestions).clamp(0.0, 1.0);
          double point = 10 / totalQuestions;
          double totalpoint = point * correctCount;
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
            showLeading: true,
            title: 'enterinput'.tr(),
            body: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  LinearProgressIndicator(
                    value: progress, // Set progress value (0.0 to 1.0)
                    backgroundColor: Colors.grey[300],
                    color: Colors.blue,
                  ),
                  const SizedBox(height: 16.0),
                  Align(
                    alignment: Alignment.topLeft,
                    child: Text(
                      model.questionText,
                      style: TextStyle(fontSize: 18.0),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  const Spacer(),
                  Align(
                    alignment: Alignment.bottomRight,
                    child: InkWell(
                      child: Text(
                        'dknow'.tr(),
                        style: GoogleFonts.aBeeZee(color: AppColor.blue),
                      ),
                      onTap: () {
                        setState(() {
                          isInkwell = true;
                        });
                      },
                    ),
                  ),
                  if (isInkwell)
                    Text(
                      '${'answer'.tr()} ${model.correctAnswer}',
                      style: TextStyle(fontSize: 16.0, color: Colors.green),
                    ),
                  if (isAnswerChecked)
                    Text(
                      model.correctAnswer ==
                              model.inputExam.text.trim().toLowerCase()
                          ? '${'correct'.tr()}! 🎉'
                          : '${'wrong'.tr()}! ${'answer'.tr()} ${'correct'.tr()}: ${model.correctAnswer}',
                      style: TextStyle(
                        fontSize: 16.0,
                        color:
                            model.correctAnswer == model.inputExam.text.trim()
                                ? Colors.green
                                : Colors.red,
                      ),
                    ),
                  const SizedBox(height: 16.0),
                  TextField(
                    controller: model.inputExam,
                    decoration: InputDecoration(
                      hintText: 'enterinput'.tr(),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                      contentPadding: const EdgeInsets.symmetric(
                        vertical: 10.0,
                        horizontal: 12.0,
                      ),
                    ),
                    textInputAction: TextInputAction.done,
                    onSubmitted: (value) {
                      setState(() {
                        final isCorrect = model.checkAnswer(value.trim());
                        isAnswerChecked = true;
                        isInkwell = false;

                        if (!isCorrect) {
                          // Nếu sai, hiện đáp án đúng nhưng không chuyển tiếp
                          isAnswerChecked = true;
                        }
                      });
                    },
                  ),
                  const SizedBox(height: 16.0),
                  if (isAnswerChecked)
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(height: 16.0),
                        ElevatedButton(
                          onPressed: () {
                            setState(() {
                              // Kiểm tra lần nữa
                              if (model.correctAnswer ==
                                  model.inputExam.text.trim().toLowerCase()) {
                                // Chuyển tiếp nếu đúng
                                correctCount++;
                                answeredCount++;
                                model.inputExam.clear();
                                model.generateQuestion();
                                isAnswerChecked = false;
                              } else {
                                // Nếu vẫn sai, yêu cầu nhập lại
                                model.inputExam
                                    .clear(); // Xóa input cho lần nhập lại
                                isAnswerChecked = true;
                              }
                            });
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: AppColor.blue,
                            padding: const EdgeInsets.symmetric(
                                vertical: 12, horizontal: 16),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8.0),
                            ),
                          ),
                          child: Text(
                            model.correctAnswer ==
                                    model.inputExam.text.trim().toLowerCase()
                                ? 'next'.tr()
                                : 'retry'.tr(),
                            style: GoogleFonts.aBeeZee(
                                color: Colors.white, fontSize: 16),
                          ),
                        ),
                      ],
                    ),
                ],
              ),
            ),
          );
        });
  }
}
