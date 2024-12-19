import 'package:get_it/get_it.dart';
import 'package:quizlet_xspin/languages/languages_service.dart';

extension LocalizationExtension on String {
  String tr() {
    final languageService = GetIt.instance<LanguageService>();
    return languageService.translate(this);
  }
}
