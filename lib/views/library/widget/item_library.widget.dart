import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:quizlet_xspin/app/app_sp.dart';
import 'package:quizlet_xspin/app/app_sp_key.dart';
import 'package:quizlet_xspin/base/nav_bar.page.dart';
import 'package:quizlet_xspin/constants/app_color.dart';
import 'package:quizlet_xspin/constants/app_fontsize.dart';
import 'package:quizlet_xspin/languages/string_extension.dart';
import 'package:quizlet_xspin/models/lst_flash_card.model.dart';
import 'package:quizlet_xspin/theme/theme_service.dart';
import 'package:quizlet_xspin/viewmodel/lst_flash_card.vm.dart';
import 'package:quizlet_xspin/views/library/widget/update_lst_library.widget.dart';

class ItemLibraryWidget extends StatefulWidget {
  const ItemLibraryWidget(
      {super.key,
      required this.onTap,
      required this.data,
      required this.viewModel});
  final VoidCallback onTap;
  final LstFlashCardModel data;
  final ListFlashCardViewModel viewModel;
  @override
  State<ItemLibraryWidget> createState() => _ItemStudyWidgetState();
}

class _ItemStudyWidgetState extends State<ItemLibraryWidget> {
  final themeService = GetIt.instance<ThemeService>();
  @override
  Widget build(BuildContext context) {
    final isDarkMode = themeService.isDarkMode;

    final colorCard = isDarkMode
        ? const Color.fromARGB(255, 45, 43, 43)
        : AppColor.extraColor;

    return InkWell(
      onTap: widget.onTap,
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        elevation: 2,
        color: colorCard,
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Row(
            children: [
              Padding(
                padding: const EdgeInsets.all(3.0),
                child: Container(
                  height: 50,
                  width: 50,
                  padding: EdgeInsets.all(8),
                  decoration: BoxDecoration(
                      color: AppColor.blueLight,
                      borderRadius: BorderRadius.circular(10)),
                  child: Icon(
                    Icons.folder,
                    color: AppColor.extraColor,
                  ),
                ),
              ),
              SizedBox(
                width: 15,
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.data.nameLstCard ?? '',
                      style: GoogleFonts.aBeeZee(
                        fontSize: AppFontSize.sizeSuperSmall,
                        fontWeight: FontWeight.bold,
                      ),
                      maxLines: 2,
                      softWrap: true,
                      overflow: TextOverflow.ellipsis,
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(
                        vertical: 3.0,
                        horizontal: 6.0,
                      ),
                      decoration: BoxDecoration(
                        color: AppColor.blueLight,
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                      child: widget.viewModel.isBusy
                          ? Center(
                              child: CircularProgressIndicator(
                                color: AppColor.primaryColor,
                              ),
                            )
                          : Text(
                              '${widget.data.countFlashCard} ${'terminology'.tr()}',
                              style: GoogleFonts.aBeeZee(
                                  color: AppColor.extraColor,
                                  fontSize: AppFontSize.sizeSuperSmall),
                            ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  child: IconButton(
                    onPressed: () {
                      _showOptionsBottomSheet(context, widget.viewModel,
                          widget.data, widget.data.idListCard ?? '');
                    },
                    icon: Icon(Icons.more_vert, size: 30),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

void _showOptionsBottomSheet(
    BuildContext context,
    ListFlashCardViewModel viewModel,
    LstFlashCardModel data,
    String idListFlashCard) {
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

                showUpdateLibrary(context, viewModel, data, idListFlashCard);
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
                await viewModel.DeleteListFlashCard(
                    AppSP.get(AppSPKey.idUser), idListFlashCard);
                await viewModel.getListFlashCard();
                Navigator.pop(context);
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
