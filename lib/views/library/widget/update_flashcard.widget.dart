import 'package:flutter/material.dart';
import 'package:quizlet_xspin/languages/string_extension.dart';
import 'package:quizlet_xspin/models/flash_card.model.dart';
import 'package:quizlet_xspin/viewmodel/lst_flash_card.vm.dart';
import 'package:quizlet_xspin/views/library/widget/library.widget.dart';

void showUpdateFlashCard(BuildContext context, ListFlashCardViewModel viewModel,
    FlashCardModel data, String idFlashCard, String idListFlashCard) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return StatefulBuilder(
        builder: (context, setState) {
          return AlertDialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
            title: Text(
              'editflashcard'.tr(),
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
              textAlign: TextAlign.center,
            ),
            content: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const SizedBox(height: 10),
                  TextField(
                    controller: viewModel.newEnglishController,
                    style: const TextStyle(fontSize: 16),
                    decoration: InputDecoration(
                      labelText: 'english'.tr(),
                      hintText: data.english ?? 'inputenglish'.tr(),
                      filled: true,
                      fillColor: Colors.grey[200],
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15),
                        borderSide: BorderSide.none,
                      ),
                      contentPadding: const EdgeInsets.symmetric(
                          vertical: 14, horizontal: 16),
                    ),
                  ),
                  const SizedBox(height: 15),
                  TextField(
                    controller: viewModel.newVietNamController,
                    style: const TextStyle(fontSize: 16),
                    decoration: InputDecoration(
                      labelText: 'vietnamese'.tr(),
                      hintText: data.vietnam ?? 'inputvietnam'.tr(),
                      filled: true,
                      fillColor: Colors.grey[200],
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15),
                        borderSide: BorderSide.none,
                      ),
                      contentPadding: const EdgeInsets.symmetric(
                          vertical: 14, horizontal: 16),
                    ),
                  ),
                ],
              ),
            ),
            actionsPadding: const EdgeInsets.symmetric(horizontal: 10),
            actions: <Widget>[
              ElevatedButton(
                onPressed: () {
                  viewModel.newEnglishController.clear();
                  viewModel.newVietNamController.clear();
                  Navigator.of(context).pop();
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.grey[400],
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                child: Text('cancel'.tr()),
              ),
              ElevatedButton(
                onPressed: () async {
                  if (viewModel.newEnglishController.text.isEmpty &&
                      viewModel.newVietNamController.text.isNotEmpty) {
                    await viewModel.updateFlashCard(
                        idFlashCard,
                        data.english ?? '',
                        viewModel.newVietNamController.text);
                    viewModel.newVietNamController.clear();
                    await viewModel.getCard(idListFlashCard);
                    Navigator.of(context).pop();
                  } else if (viewModel.newEnglishController.text.isNotEmpty &&
                      viewModel.newVietNamController.text.isEmpty) {
                    await viewModel.updateFlashCard(
                      idFlashCard,
                      viewModel.newEnglishController.text,
                      data.vietnam ?? '',
                    );
                    viewModel.newEnglishController.clear();
                    await viewModel.getCard(idListFlashCard);
                    Navigator.of(context).pop();
                  } else {
                    await viewModel.updateFlashCard(
                        idFlashCard,
                        viewModel.newEnglishController.text,
                        viewModel.newVietNamController.text);
                    viewModel.newEnglishController.clear();
                    viewModel.newVietNamController.clear();
                    await viewModel.getCard(idListFlashCard);
                    Navigator.of(context).pop();
                  }
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue,
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                child: Text('confirm'.tr()),
              ),
            ],
          );
        },
      );
    },
  );
}
