import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:quizlet_xspin/base/base.page.dart';
import 'package:quizlet_xspin/constants/app_color.dart';
import 'package:quizlet_xspin/languages/string_extension.dart';
import 'package:quizlet_xspin/models/lst_flash_card.model.dart';
import 'package:quizlet_xspin/viewmodel/lst_flash_card.vm.dart';
import 'package:quizlet_xspin/views/exam/input_quiz.view.dart';
import 'package:quizlet_xspin/views/exam/quiz.view.dart';
import 'package:quizlet_xspin/views/library/widget/add_library.view.dart';
import 'package:quizlet_xspin/views/library/widget/card_library.widget.dart';
import 'package:quizlet_xspin/views/library/widget/flashcard_button.widget.dart';
import 'package:quizlet_xspin/views/library/widget/search.widget.dart';
import 'package:quizlet_xspin/views/student/widget/full.flipcard.widget.dart';
import 'package:stacked/stacked.dart';

class DataLibraryView extends StatefulWidget {
  const DataLibraryView(
      {super.key,
      required this.idListCard,
      required this.viewModel,
      required this.data});
  final String idListCard;
  final LstFlashCardModel data;
  final ListFlashCardViewModel viewModel;
  @override
  State<DataLibraryView> createState() => _DataLibraryViewState();
}

class _DataLibraryViewState extends State<DataLibraryView> {
  final FlutterTts flutterTts = FlutterTts();
  bool isSpeaking = false;

  @override
  void initState() {
    super.initState();
    flutterTts.setCompletionHandler(() {
      setState(() {
        isSpeaking = false;
      });
    });
    flutterTts.setErrorHandler((msg) {
      setState(() {
        isSpeaking = false;
      });
      print("Error: $msg");
    });
  }

  // Hàm phát âm văn bản
  Future<void> speak(String text) async {
    setState(() {
      isSpeaking = true;
    });
    await flutterTts.setLanguage("en-US");
    await flutterTts.setPitch(1.2); // Độ cao giọng nói
    await flutterTts.setSpeechRate(0.45); // Tốc độ nói
    await flutterTts.speak(text); // Phát âm văn bản
  }

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
          if (viewModel.isBusy)
            return BasePage(
                showLeading: true,
                title: widget.data.nameLstCard ?? '',
                body: Center(
                  child: CircularProgressIndicator(
                    color: AppColor.primaryColor,
                  ),
                ));
          return BasePage(
            showLeading: true,
            title: widget.data.nameLstCard ?? '',
            body: SingleChildScrollView(
              child: Column(
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: FlashcardItem(
                          title: 'flashcard'.tr(),
                          icon: Icons.book,
                          onTap: () {
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
                        ),
                      ),
                      Expanded(
                        child: FlashcardItem(
                          title: 'addword'.tr(),
                          icon: Icons.add_box_sharp,
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => InfoForm(
                                          idListCard: widget.idListCard,
                                          viewModel: viewModel,
                                        )));
                          },
                        ),
                      ),
                    ],
                  ),
                  FlashcardItem(
                    title: 'choose'.tr(),
                    icon: Icons.check_box_outlined,
                    onTap: () {
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
                  ),
                  FlashcardItem(
                    title: 'enterinput'.tr(),
                    icon: Icons.text_fields_sharp,
                    onTap: () {
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
                  ),
                  SearchWidget(),
                  AnimatedSwitcher(
                      duration: const Duration(milliseconds: 300),
                      child: Column(
                        children: [
                          ...List.generate(viewModel.lstFlashCard.length,
                              (index) {
                            return ExpressionCard(
                              data: viewModel.lstFlashCard[index],
                              viewModel: viewModel,
                              idListCard: widget.idListCard,
                              onPress: () {
                                speak(viewModel.lstFlashCard[index].english ??
                                    '');
                              },
                              english:
                                  viewModel.lstFlashCard[index].english ?? '',
                              translation:
                                  viewModel.lstFlashCard[index].vietnam ?? '',
                            );
                          }),
                        ],
                      )),
                ],
              ),
            ),
          );
        });
  }
}
