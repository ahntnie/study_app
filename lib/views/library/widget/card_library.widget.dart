import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:quizlet_xspin/constants/app_color.dart';
import 'package:quizlet_xspin/languages/string_extension.dart';
import 'package:quizlet_xspin/models/flash_card.model.dart';
import 'package:quizlet_xspin/theme/theme_service.dart';
import 'package:quizlet_xspin/viewmodel/lst_flash_card.vm.dart';
import 'package:quizlet_xspin/views/library/widget/update_flashcard.widget.dart';

class ExpressionCard extends StatefulWidget {
  final String english;
  final VoidCallback onPress;
  final String translation;
  final String idListCard;
  final ListFlashCardViewModel viewModel;
  final FlashCardModel data;
  ExpressionCard(
      {required this.english,
      required this.translation,
      required this.data,
      required this.onPress,
      required this.idListCard,
      required this.viewModel});

  @override
  State<ExpressionCard> createState() => _ExpressionCardState();
}

class _ExpressionCardState extends State<ExpressionCard> {
  final themeService = GetIt.instance<ThemeService>();

  @override
  Widget build(BuildContext context) {
    final isDarkMode = themeService.isDarkMode;

    final colorCard = isDarkMode
        ? const Color.fromARGB(255, 45, 43, 43)
        : AppColor.extraColor;

    return Card(
      color: colorCard,
      margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 10),
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Text(
                    widget.english,
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.blue,
                    ),
                    softWrap: true,
                    overflow: TextOverflow.visible,
                  ),
                ),
                IconButton(
                  onPressed: () {
                    _showOptionsBottomSheet(
                      context,
                      widget.viewModel,
                      widget.data.idFlashCard.toString(),
                      widget.idListCard,
                      widget.data,
                    );
                  },
                  icon: Icon(Icons.more_vert, size: 20),
                ),
              ],
            ),
            SizedBox(height: 5),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Text(
                    widget.translation,
                    style: TextStyle(fontSize: 15),
                    softWrap: true,
                    overflow: TextOverflow.visible,
                  ),
                ),
                IconButton(
                  onPressed: widget.onPress,
                  icon: Icon(Icons.volume_down_sharp, size: 20),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

void _showOptionsBottomSheet(
    BuildContext context,
    ListFlashCardViewModel viewModel,
    String idFlashCard,
    String idListCard,
    FlashCardModel data) {
  showModalBottomSheet(
    context: context,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(
        top: Radius.circular(20),
      ),
    ),
    builder: (BuildContext context) {
      return Padding(
        padding: const EdgeInsets.symmetric(vertical: 20.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              title: Center(
                child: Text(
                  "edit".tr(),
                  style: GoogleFonts.aBeeZee(
                    fontSize: 20,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ),
              onTap: () async {
                Navigator.pop(context);
                showUpdateFlashCard(
                    context, viewModel, data, idFlashCard, idListCard);
              },
            ),
            Divider(height: 1),
            ListTile(
              title: Center(
                child: Text(
                  "delete".tr(),
                  style: GoogleFonts.aBeeZee(
                    fontSize: 20,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ),
              onTap: () async {
                await viewModel.DeleteFlashCard(idFlashCard);
                await viewModel.getFlashCard(idListCard);
                Navigator.pop(context);
                // Logic xóa ở đây
              },
            ),
            Divider(height: 1),
            ListTile(
              title: Center(
                child: Text(
                  "cancel".tr(),
                  style: GoogleFonts.aBeeZee(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.red,
                  ),
                ),
              ),
              onTap: () {
                Navigator.pop(context);
              },
            ),
          ],
        ),
      );
    },
  );
}
