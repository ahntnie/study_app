import 'package:flutter/material.dart';
import 'package:quizlet_xspin/views/auth/profile/profile.page.dart';
import 'package:quizlet_xspin/views/exam/exam.page.dart';
import 'package:quizlet_xspin/views/home/home.view.dart';
import 'package:stacked/stacked.dart';

class IndexViewModel extends BaseViewModel {
  late BuildContext viewContext;
  int currentIndex = 0;
  IndexViewModel() {}
  Future<void> setIndex(int index) async {
    currentIndex = index;
    notifyListeners();
  }

  List<Widget> getPages() {
    return [HomePage(), ExamPage(), ProfilePage()];
  }
}
