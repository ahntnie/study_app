import 'package:flutter/material.dart';
import 'package:quizlet_xspin/languages/string_extension.dart';
import 'package:quizlet_xspin/models/lst_flash_card.model.dart';
import 'package:quizlet_xspin/viewmodel/lst_flash_card.vm.dart';

void showUpdateLibrary(BuildContext context, ListFlashCardViewModel viewModel,
    LstFlashCardModel data, String idListCard) {
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
              'editlibrary'.tr(),
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
              textAlign: TextAlign.center,
            ),
            content: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const SizedBox(height: 10),
                  TextField(
                    controller: viewModel.nameUpate,
                    style: const TextStyle(fontSize: 16),
                    decoration: InputDecoration(
                      labelText: 'inputnewname'.tr(),
                      hintText: data.nameLstCard ?? 'inputnewname'.tr(),
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
                  viewModel.nameUpate.clear();
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
                  if (viewModel.nameUpate.text.isNotEmpty) {
                    await viewModel.updateListFlashCard(
                        idListCard, viewModel.nameUpate.text);
                    viewModel.nameUpate.clear();
                    await viewModel.getListFlashCard();
                    viewModel.notifyListeners();
                    Navigator.of(context).pop();
                  } else {
                    // Hiển thị thông báo lỗi nếu input rỗng
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text('error'.tr()),
                        duration: Duration(seconds: 2),
                      ),
                    );
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
