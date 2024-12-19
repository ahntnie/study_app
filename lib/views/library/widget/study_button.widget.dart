import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:quizlet_xspin/constants/app_color.dart';
import 'package:quizlet_xspin/theme/theme_service.dart';

class NotificationCard extends StatelessWidget {
  final String message;
  final String buttonText;
  final VoidCallback onButtonPressed;

  const NotificationCard({
    Key? key,
    required this.message,
    required this.buttonText,
    required this.onButtonPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final themeService = GetIt.instance<ThemeService>();
    final isDarkMode = themeService.isDarkMode;

    final colorCard =
        isDarkMode ? const Color.fromARGB(255, 45, 43, 43) : Colors.blue[50];

    return Container(
      padding: const EdgeInsets.all(16.0),
      margin: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      decoration: BoxDecoration(
        color: colorCard, // Màu nền nhạt
        borderRadius: BorderRadius.circular(12.0),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(Icons.info_outline, color: Colors.blue),
              const SizedBox(width: 8.0),
              Expanded(
                child: Text(
                  message,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 16.0),
          ElevatedButton(
            onPressed: onButtonPressed,
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.blue, // Nền xanh đậm
              foregroundColor: Colors.white, // Chữ trắng
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8.0),
              ),
              padding: const EdgeInsets.symmetric(vertical: 12.0),
            ),
            child: Center(
              child: Text(
                buttonText,
                style:
                    const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
