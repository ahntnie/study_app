import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:quizlet_xspin/app/app_sp.dart';
import 'package:quizlet_xspin/app/app_sp_key.dart';
import 'package:quizlet_xspin/base/nav_bar.page.dart';
import 'package:quizlet_xspin/constants/app_color.dart';
import 'package:quizlet_xspin/languages/languages_service.dart';
import 'package:quizlet_xspin/languages/string_extension.dart';
import 'package:quizlet_xspin/views/auth/login/login.view.dart';
import 'package:quizlet_xspin/views/auth/signup/signup.view.dart';
import 'package:quizlet_xspin/views/auth/splash/widget/loading.dart';
import 'package:quizlet_xspin/views/auth/widgets/button.widget.dart';
import 'package:quizlet_xspin/views/index/index.dart';

class SplashView extends StatefulWidget {
  const SplashView({super.key});

  @override
  State<SplashView> createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView> {
  final languageService = GetIt.instance<LanguageService>();
  @override
  void initState() {
    super.initState();
    _navigateToNextScreen();
  }

  void _navigateToNextScreen() async {
    if (AppSP.get(AppSPKey.phone) != null &&
        AppSP.get(AppSPKey.password) != null &&
        AppSP.get(AppSPKey.idUser) != null &&
        AppSP.get(AppSPKey.phone) != '' &&
        AppSP.get(AppSPKey.password) != '' &&
        AppSP.get(AppSPKey.idUser) != '') {
      await languageService.loadSavedLanguage(); // Tải ngôn ngữ đã lưu

      await Future.delayed(const Duration(seconds: 2), () {});
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) => const IndexPage()),
      );
    } else {
      await languageService.loadSavedLanguage(); // Tải ngôn ngữ đã lưu
      await Future.delayed(const Duration(seconds: 2), () {});
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) => const LoginView()),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Loading(),
      ),
    );
  }
}
