import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:quizlet_xspin/constants/app_color.dart';
import 'package:quizlet_xspin/languages/languages_service.dart';
import 'package:quizlet_xspin/languages/string_extension.dart';
import 'package:quizlet_xspin/views/auth/splash/splash.view.dart';

void showLanguageDialog(BuildContext context) {
  final languageService = GetIt.instance<LanguageService>();
  String selectedLanguage =
      languageService.locale.languageCode; // Ngôn ngữ hiện tại

  showDialog(
    context: context,
    builder: (BuildContext context) {
      return StatefulBuilder(
        builder: (context, setState) {
          return AlertDialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
            title: Center(
              child: Text(
                'language'.tr(),
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                ),
              ),
            ),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Divider(thickness: 1),
                GestureDetector(
                  onTap: () {
                    setState(() {
                      selectedLanguage = 'en';
                      languageService.loadLanguage('en');
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const SplashView(),
                        ),
                      );
                    });
                  },
                  child: Row(
                    children: [
                      Image.asset(
                        'assets/eng.png',
                        width: 50, // Kích thước hình to hơn
                        height: 50,
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: Text(
                          'english'.tr(),
                          style: const TextStyle(
                            fontSize: 18, // Tăng kích thước text
                            fontWeight: FontWeight.w500,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow
                              .ellipsis, // Không cho text xuống dòng
                        ),
                      ),
                      Radio<String>(
                        value: 'en',
                        groupValue: selectedLanguage,
                        activeColor: AppColor.blueLight,
                        onChanged: (value) {
                          setState(() {
                            selectedLanguage = value!;
                            languageService.loadLanguage('en');
                            Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const SplashView(),
                              ),
                            );
                          });
                        },
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 16),
                GestureDetector(
                  onTap: () {
                    setState(() {
                      selectedLanguage = 'vi';
                      languageService.loadLanguage('vi');
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const SplashView(),
                        ),
                      );
                    });
                  },
                  child: Row(
                    children: [
                      Image.asset(
                        'assets/vietnam.png',
                        width: 50, // Kích thước hình to hơn
                        height: 50,
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: Text(
                          'vietnamese'.tr(),
                          style: const TextStyle(
                            fontSize: 18, // Tăng kích thước text
                            fontWeight: FontWeight.w500,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow
                              .ellipsis, // Không cho text xuống dòng
                        ),
                      ),
                      Radio<String>(
                        value: 'vi',
                        groupValue: selectedLanguage,
                        activeColor: AppColor.lightRed,
                        onChanged: (value) {
                          setState(() {
                            selectedLanguage = value!;
                            languageService.loadLanguage('vi');
                            Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const SplashView(),
                              ),
                            );
                          });
                        },
                      ),
                    ],
                  ),
                ),
              ],
            ),
            actionsAlignment: MainAxisAlignment.center,
            actions: [
              TextButton(
                onPressed: () => Navigator.of(context).pop(),
                style: TextButton.styleFrom(
                  foregroundColor: Colors.redAccent,
                ),
                child: Text(
                  'cancel'.tr(),
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
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
