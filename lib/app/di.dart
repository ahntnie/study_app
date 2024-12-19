import 'dart:io';

import 'package:device_info_plus/device_info_plus.dart';
import 'package:get_it/get_it.dart';
import 'package:quizlet_xspin/languages/languages_service.dart';
import 'package:quizlet_xspin/theme/theme_service.dart';
import 'package:shared_preferences/shared_preferences.dart';

final getIt = GetIt.instance;

class Di {
  static final Di _singleton = Di._internal();

  factory Di() {
    return _singleton;
  }

  Di._internal();

  Future<void> init() async {
    final prefs = await SharedPreferences.getInstance();
    getIt.registerSingleton(prefs);
  }
}

final class DependencyInjection {
  static Future<void> init() async {
    await Di().init();

    final deviceInfoPlugin = DeviceInfoPlugin();

    if (Platform.isAndroid) {
      final androidDeviceInfo = await deviceInfoPlugin.androidInfo;
      getIt.registerSingleton(androidDeviceInfo);
    }

    if (Platform.isIOS) {
      final iOSDeviceInfo = await deviceInfoPlugin.iosInfo;
      getIt.registerSingleton(iOSDeviceInfo);
    }
    getIt.registerSingleton<ThemeService>(ThemeService());
    final languageService = LanguageService();
    await languageService.loadSavedLanguage();
    GetIt.instance.registerSingleton<LanguageService>(languageService);
  }
}
