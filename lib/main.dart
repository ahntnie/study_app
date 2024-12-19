import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:quizlet_xspin/app/di.dart';
import 'package:quizlet_xspin/languages/languages_service.dart';
import 'package:quizlet_xspin/theme/theme_service.dart';
import 'package:quizlet_xspin/views/auth/splash/splash.view.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await DependencyInjection.init();
  await Future.delayed(const Duration(seconds: 1));
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    final themeService = getIt<ThemeService>();
    final languageService = GetIt.instance<LanguageService>();
    return AnimatedBuilder(
      animation: themeService,
      builder: (context, _) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          locale: languageService.locale,
          theme: themeService.currentTheme,
          home: SplashView(),
        );
      },
    );
  }
}
