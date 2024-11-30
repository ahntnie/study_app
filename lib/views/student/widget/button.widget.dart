import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:google_fonts/google_fonts.dart';

class ButtonStudyWidget extends StatelessWidget {
  String title;
  Color colorfont;
  Color colorBorder;
  VoidCallback ontap;
  IconData icon;
  ButtonStudyWidget(
      {super.key,
      required this.colorfont,
      required this.title,
      required this.ontap,
      required this.colorBorder,
      required this.icon});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: OutlinedButton(
        onPressed: ontap,
        style: OutlinedButton.styleFrom(
            side: BorderSide(color: colorBorder, width: 2),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            minimumSize: Size(MediaQuery.of(context).size.width / 0.9, 60)),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Icon(
              icon,
              color: colorfont,
            ),
            SizedBox(
              width: 15,
            ),
            Text(
              title,
              style: GoogleFonts.aBeeZee(color: colorfont),
            ),
          ],
        ),
      ),
    );
  }
}
