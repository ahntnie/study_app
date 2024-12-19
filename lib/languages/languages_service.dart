import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:quizlet_xspin/app/app_sp.dart';
import 'package:quizlet_xspin/app/app_sp_key.dart';

class LanguageService extends ChangeNotifier {
  Map<String, String> _localizedStrings = {};
  Locale _locale = const Locale('vi'); // Mặc định là tiếng Việt

  Locale get locale => _locale;

  Future<void> loadLanguage(String languageCode) async {
    _locale = Locale(languageCode);
    final String jsonString =
        await rootBundle.loadString('assets/languages/$languageCode.json');
    final Map<String, dynamic> jsonMap = json.decode(jsonString);

    _localizedStrings =
        jsonMap.map((key, value) => MapEntry(key, value.toString()));
    AppSP.set(AppSPKey.languageCode, languageCode);
    notifyListeners();
  }

  Future<void> loadSavedLanguage() async {
    final savedLanguage = AppSP.get('languageCode') ?? 'vi';
    await loadLanguage(savedLanguage);
  }

  String translate(String key) {
    return _localizedStrings[key] ?? key;
  }
}
