import 'dart:math';

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:quizlet_xspin/app/app_sp.dart';
import 'package:quizlet_xspin/app/app_sp_key.dart';
import 'package:quizlet_xspin/constants/app_color.dart';
import 'package:quizlet_xspin/languages/string_extension.dart';
import 'package:quizlet_xspin/models/flash_card.model.dart';
import 'package:quizlet_xspin/models/lst_flash_card.model.dart';
import 'package:quizlet_xspin/request/api_request.dart';
import 'package:quizlet_xspin/viewmodel/index.vm.dart';
import 'package:stacked/stacked.dart';

class ListFlashCardViewModel extends BaseViewModel {
  TextEditingController phone = TextEditingController();
  TextEditingController password = TextEditingController();
  TextEditingController nameUser = TextEditingController();
  TextEditingController maListCard = TextEditingController();
  TextEditingController note = TextEditingController();
  TextEditingController nameListCardCreate = TextEditingController();
  TextEditingController nameUpate = TextEditingController();
  String shareCreate = "0";
  List<TextEditingController> engLishCreate = [TextEditingController()];
  List<TextEditingController> vietNameCreate = [TextEditingController()];
  TextEditingController english = TextEditingController();
  TextEditingController vietnam = TextEditingController();
  TextEditingController inputExam = TextEditingController();
  TextEditingController newEnglishController = TextEditingController();
  TextEditingController newVietNamController = TextEditingController();

  late BuildContext viewContext;
  API_REQUEST apiRequest = API_REQUEST();
  late IndexViewModel indexViewModel;
  List<LstFlashCardModel> ListData = [];
  LstFlashCardModel? data;
  FlashCardModel? flashCardData;
  Future<void> getListFlashCard() async {
    setBusy(true);
    ListData =
        await apiRequest.GET_LIST_FLASHCARD(idUser: AppSP.get(AppSPKey.idUser));
    setBusy(false);
    notifyListeners();
  }

  List<FlashCardModel> lstFlashCard = [];

  Future<void> getCard(String idListCard) async {
    setBusy(true);
    lstFlashCard = await apiRequest.GET_FLASH_CARD(idListCard: idListCard);
    setBusy(false);
    notifyListeners();
  }

  Future<void> getFlashCard(String idListCard) async {
    setBusy(true);
    lstFlashCard = await apiRequest.GET_FLASH_CARD(idListCard: idListCard);
    setBusy(false);
    notifyListeners();
    if (lstFlashCard.isNotEmpty) {
      generateQuestion();
    }
  }

  // List<FlashCardModel> dataFlashCard = [];
  Future<void> createFlashCard(
      String idLstCard, List<FlashCardModel> flashCards) async {
    setBusy(true);
    bool isSuccess = await apiRequest.CREATE_FLASH_CARDS(
      idLstCard: idLstCard,
      flashCards: flashCards,
    );
    setBusy(false);
    if (isSuccess) {
      print("addsuccess".tr());
    } else {
      print("addfaild".tr());
    }
    notifyListeners();
  }

  Future<void> createListFlashCard(String idUser) async {
    setBusy(true);
    data = await apiRequest.CREATE_LIST_FLASH_CARD(
        idUser: idUser,
        idLstCard: maListCard.text,
        nameLstCard: nameListCardCreate.text,
        share: shareCreate);
    setBusy(false);
    notifyListeners();
  }

  Future<void> updateListFlashCard(String idLstCard, String nameLstCard) async {
    setBusy(true);
    data = await apiRequest.UPDATE_LIST_FLASHCARD(
      idLstCard: idLstCard,
      newName: nameUpate.text,
    );
    setBusy(false);
    notifyListeners();
  }

  Future<void> updateFlashCard(
      String idFlashCard, String newEnglish, String newVietNam) async {
    setBusy(true);
    flashCardData = await apiRequest.UPDATE_FLASHCARD(
        idFlashCard: idFlashCard,
        newEnglish: newEnglish,
        newVietNam: newVietNam);
    setBusy(false);
    notifyListeners();
  }

  Future<void> DeleteListFlashCard(
      BuildContext context, String idUser, String idLstFlashCard) async {
    setBusy(true);
    data = await apiRequest.DELETE_LIST_FLASHCARD(
      idUser: idUser,
      idLstCard: idLstFlashCard,
    );
    if (data == null) {
      showDialog(context, 'cantdel'.tr(), 'delfaild'.tr(), 'try'.tr(),
          DialogType.error, AppColor.selectColor);
    } else {
      showDialog(context, 'dellibsuccess'.tr(), 'delsuccess'.tr(), 'next'.tr(),
          DialogType.success, AppColor.green);
    }
    setBusy(false);
    notifyListeners();
  }

  Future<void> DeleteFlashCard(BuildContext context, String idFlashCard) async {
    setBusy(true);
    flashCardData = await apiRequest.DELETE_FLASHCARD(idFlashCard: idFlashCard);
    showDialog(context, 'dellibsuccess'.tr(), 'delsuccess'.tr(), 'next'.tr(),
        DialogType.success, AppColor.green);

    setBusy(false);
    notifyListeners();
  }

  void showDialog(BuildContext context, String desc, String title,
      String button, DialogType type, Color color) {
    AwesomeDialog(
      context: viewContext,
      dialogType: type,
      animType: AnimType.topSlide,
      showCloseIcon: true,
      title: title,
      desc: desc,
      btnOkColor: color,
      btnOkOnPress: () {},
      btnOkText: button,
    ).show();
  }

  final Random _random = Random();
  FlashCardModel? currentQuestion;
  bool askEnglish = true;
  String questionText = '';
  String correctAnswer = '';
  List<String> options = [];

  void generateQuestion() {
    if (lstFlashCard.isEmpty) return;
    currentQuestion = lstFlashCard[_random.nextInt(lstFlashCard.length)];
    askEnglish = _random.nextBool();

    if (askEnglish) {
      questionText = currentQuestion!.english ?? '';
      correctAnswer = currentQuestion!.vietnam ?? '';
      final wrongList = lstFlashCard
          .where((fc) => fc.idFlashCard != currentQuestion!.idFlashCard)
          .toList();
      wrongList.shuffle();
      final wrongAnswers =
          wrongList.take(3).map((fc) => fc.vietnam ?? '').toList();
      options = [correctAnswer, ...wrongAnswers];
    } else {
      questionText = currentQuestion!.vietnam ?? '';
      correctAnswer = currentQuestion!.english ?? '';

      final wrongList = lstFlashCard
          .where((fc) => fc.idFlashCard != currentQuestion!.idFlashCard)
          .toList();
      wrongList.shuffle();
      final wrongAnswers =
          wrongList.take(3).map((fc) => fc.english ?? '').toList();
      options = [correctAnswer, ...wrongAnswers];
    }

    options.shuffle();
    notifyListeners();
  }

  bool checkAnswer(String answer) {
    bool isCorrect = answer == correctAnswer;
    return isCorrect;
  }
}
