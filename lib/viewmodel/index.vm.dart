import 'package:flutter/material.dart';
import 'package:quizlet_xspin/viewmodel/lst_flash_card.vm.dart';
import 'package:quizlet_xspin/viewmodel/user_vm.dart';
import 'package:quizlet_xspin/views/auth/profile/profile.page.dart';
import 'package:quizlet_xspin/views/home/home.view.dart';
import 'package:quizlet_xspin/views/library/library.view.dart';
import 'package:stacked/stacked.dart';

class IndexViewModel extends BaseViewModel {
  late BuildContext viewContext;
  int currentIndex = 0;
  late UserViewModel userViewModel;
  late ListFlashCardViewModel listFlashCardViewModel;
  IndexViewModel() {
    userViewModel = UserViewModel();
    listFlashCardViewModel = ListFlashCardViewModel();
  }
  Future<void> setIndex(int index) async {
    currentIndex = index;
    notifyListeners();
  }

  List<Widget> getPages() {
    return [
      HomePage(
        indexViewModel: this,
        listFlashCardViewModel: listFlashCardViewModel,
      ),
      AddLibraryView(
        viewModel: listFlashCardViewModel,
      ),
      ProfilePage(
        indexViewModel: this,
        userViewModel: userViewModel,
      )
    ];
  }
}
