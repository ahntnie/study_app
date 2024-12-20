import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:quizlet_xspin/constants/app_color.dart';
import 'package:quizlet_xspin/theme/theme_service.dart';

class FlashcardItem extends StatelessWidget {
  final String title;
  final IconData icon;
  final VoidCallback onTap;

  const FlashcardItem({
    Key? key,
    required this.title,
    required this.icon,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final themeService = GetIt.instance<ThemeService>();
    final isDarkMode = themeService.isDarkMode;

    final colorCard = isDarkMode
        ? const Color.fromARGB(255, 45, 43, 43)
        : AppColor.extraColor;

    return GestureDetector(
      onTap: onTap,
      child: Card(
        color: colorCard,
        elevation: 2,
        child: Container(
          margin: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
          padding: const EdgeInsets.all(16.0),
          decoration: BoxDecoration(
            // image: DecorationImage(
            //     image: AssetImage('assets/flashcard.png'), fit: BoxFit.fill),
            borderRadius: BorderRadius.circular(12.0),
          ),
          child: Row(
            // crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Icon(
                icon,
                color: Colors.blue,
                size: 25.0,
              ),
              const SizedBox(width: 16.0),
              Expanded(
                child: Text(
                  title,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                  softWrap: true,
                  overflow: TextOverflow.clip,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
