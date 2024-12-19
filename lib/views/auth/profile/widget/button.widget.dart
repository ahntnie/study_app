import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:quizlet_xspin/constants/app_color.dart';
import 'package:quizlet_xspin/constants/app_fontsize.dart';
import 'package:quizlet_xspin/theme/theme_service.dart';

class ButtonWidget extends StatefulWidget {
  final String title;
  final IconData icon;
  final Color color;
  final VoidCallback onTap;
  final bool showLead;
  ButtonWidget(
      {super.key,
      this.showLead = true,
      required this.icon,
      required this.onTap,
      required this.title,
      required this.color});

  @override
  State<ButtonWidget> createState() => _ButtonWidgetState();
}

class _ButtonWidgetState extends State<ButtonWidget> {
  final themeService = GetIt.instance<ThemeService>(); // Lấy ThemeService
  bool get isSwitched => themeService.isDarkMode;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: widget.onTap,
      child: Container(
        child: ListTile(
          leading: CircleAvatar(
            backgroundColor: widget.color,
            child: Icon(widget.icon, color: AppColor.extraColor),
          ),
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                widget.title,
                style: GoogleFonts.aBeeZee(
                    fontSize: 18, fontWeight: FontWeight.w900),
              ),
              widget.showLead
                  ? Text(
                      '>',
                      style: GoogleFonts.aBeeZee(
                          color: AppColor.greyColor,
                          fontSize: AppFontSize.sizeSuperLarge),
                    )
                  : Switch(
                      value: isSwitched,
                      onChanged: (value) {
                        themeService.toggleTheme(); // Chuyển đổi theme
                        setState(() {});
                      },
                      activeColor: Colors.white,
                      activeTrackColor: Colors.blue,
                      inactiveThumbColor: Colors.white,
                      inactiveTrackColor: Colors.black26,
                    ),
            ],
          ),
        ),
      ),
    );
  }
}
