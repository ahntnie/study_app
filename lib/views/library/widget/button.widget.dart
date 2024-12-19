import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:quizlet_xspin/constants/app_color.dart';
import 'package:quizlet_xspin/theme/theme_service.dart';

class ButtonLibraryWidget extends StatelessWidget {
  const ButtonLibraryWidget(
      {super.key,
      required this.colorIcon,
      required this.icons,
      required this.labelTitle,
      required this.onPressed});
  final String labelTitle;
  final VoidCallback onPressed;
  final Color colorIcon;
  final IconData icons;
  @override
  Widget build(BuildContext context) {
    final themeService = GetIt.instance<ThemeService>();
    final isDarkMode = themeService.isDarkMode;

    final colorCard = isDarkMode
        ? const Color.fromARGB(255, 45, 43, 43)
        : AppColor.extraColor;
    final colorTitle =
        isDarkMode ? AppColor.extraColor : Color.fromARGB(255, 45, 43, 43);

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: ElevatedButton.icon(
        onPressed: onPressed,
        icon: Icon(
          icons,
          color: colorIcon,
        ),
        label: Text(
          labelTitle,
          style: GoogleFonts.aBeeZee(
            fontSize: 16,
            color: colorTitle,
            fontWeight: FontWeight.w400,
          ),
        ),
        style: ElevatedButton.styleFrom(
          backgroundColor: colorCard,
          elevation: 2, // Shadow elevation
          padding: EdgeInsets.symmetric(vertical: 12, horizontal: 20),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
      ),
    );
  }
}
