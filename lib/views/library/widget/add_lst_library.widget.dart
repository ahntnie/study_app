import 'package:flutter/material.dart';
import 'package:quizlet_xspin/constants/app_color.dart';
import 'package:quizlet_xspin/languages/string_extension.dart';
import 'package:quizlet_xspin/viewmodel/lst_flash_card.vm.dart';

void showAddLibrary(
    BuildContext context, ListFlashCardViewModel viewModel, String idUser) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return StatefulBuilder(
        builder: (context, setState) {
          return AlertDialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
            title: Center(
              child: Text(
                'upload_new'.tr(),
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            content: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  TextField(
                    controller: viewModel.maListCard,
                    decoration: InputDecoration(
                      labelText: 'idlibrary'.tr(),
                      filled: true,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide.none,
                      ),
                      contentPadding: const EdgeInsets.symmetric(
                          vertical: 12, horizontal: 16),
                    ),
                  ),
                  const SizedBox(height: 10),
                  TextField(
                    controller: viewModel.nameListCardCreate,
                    decoration: InputDecoration(
                      labelText: 'namelibrary'.tr(),
                      filled: true,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide.none,
                      ),
                      contentPadding: const EdgeInsets.symmetric(
                          vertical: 12, horizontal: 16),
                    ),
                  ),
                  const SizedBox(height: 10),
                  TextField(
                    controller: viewModel.note,
                    maxLines: 3,
                    decoration: InputDecoration(
                      labelText: 'note'.tr(),
                      filled: true,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide.none,
                      ),
                      contentPadding: const EdgeInsets.symmetric(
                          vertical: 12, horizontal: 16),
                    ),
                  ),
                  const SizedBox(height: 10),
                  CheckboxListTile(
                    activeColor: AppColor.blue,
                    title: Text(
                      'share'.tr(),
                      style: const TextStyle(fontSize: 16),
                    ),
                    value: viewModel.shareCreate == '1',
                    onChanged: (bool? value) {
                      setState(() {
                        viewModel.shareCreate = value! ? '1' : '0';
                      });
                    },
                    controlAffinity: ListTileControlAffinity.leading,
                  ),
                ],
              ),
            ),
            actionsAlignment: MainAxisAlignment.center,
            actions: [
              TextButton(
                onPressed: () {
                  viewModel.maListCard.clear();
                  viewModel.nameListCardCreate.clear();
                  viewModel.note.clear();
                  Navigator.of(context).pop();
                },
                style: TextButton.styleFrom(
                  foregroundColor: Colors.redAccent,
                ),
                child: Text(
                  'cancel'.tr(),
                  style: const TextStyle(fontSize: 16),
                ),
              ),
              ElevatedButton(
                onPressed: () async {
                  if (viewModel.maListCard.text.isNotEmpty &&
                      viewModel.nameListCardCreate.text.isNotEmpty) {
                    await viewModel.createListFlashCard(idUser);
                    viewModel.maListCard.clear();
                    viewModel.nameListCardCreate.clear();
                    viewModel.note.clear();
                    await viewModel.getListFlashCard();
                    viewModel.notifyListeners();
                    Navigator.of(context).pop();
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text("error".tr()),
                        behavior: SnackBarBehavior.floating,
                      ),
                    );
                  }
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue,
                  padding:
                      const EdgeInsets.symmetric(vertical: 12, horizontal: 24),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: Text(
                  'confirm'.tr(),
                  style: const TextStyle(
                    fontSize: 16,
                    color: Colors.white,
                  ),
                ),
              ),
            ],
          );
        },
      );
    },
  );
}
