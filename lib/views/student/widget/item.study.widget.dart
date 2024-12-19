import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:quizlet_xspin/constants/app_color.dart';
import 'package:quizlet_xspin/constants/app_fontsize.dart';
import 'package:quizlet_xspin/languages/string_extension.dart';
import 'package:quizlet_xspin/models/lst_flash_card.model.dart';
import 'package:quizlet_xspin/viewmodel/lst_flash_card.vm.dart';
import 'package:quizlet_xspin/views/student/widget/study.widget.dart';

class ItemStudyWidget extends StatefulWidget {
  const ItemStudyWidget(
      {super.key,
      required this.onTap,
      required this.data,
      required this.viewModel});
  final VoidCallback onTap;
  final LstFlashCardModel data;
  final ListFlashCardViewModel viewModel;
  @override
  State<ItemStudyWidget> createState() => _ItemStudyWidgetState();
}

class _ItemStudyWidgetState extends State<ItemStudyWidget> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: widget.onTap,
      child: Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: Colors.cyan[100],
            border: Border.all(color: AppColor.greyColor, width: 2)),
        height: MediaQuery.of(context).size.height * 0.15,
        // Màu sắc dựa trên chỉ mục
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Text(
              widget.data.nameLstCard ?? '',
              style: GoogleFonts.aBeeZee(
                  fontSize: AppFontSize.sizeMedium,
                  fontWeight: FontWeight.bold),
            ),
            Container(
              padding: const EdgeInsets.symmetric(
                vertical: 5.0,
                horizontal: 10.0,
              ),
              decoration: BoxDecoration(
                color: Colors.grey[500],
                borderRadius: BorderRadius.circular(8.0),
              ),
              child: widget.viewModel.isBusy
                  ? Center(
                      child: CircularProgressIndicator(
                        color: AppColor.primaryColor,
                        // size: 50,
                      ),
                    )
                  : Text(
                      '${widget.data.countFlashCard} ${'terminology'.tr()}',
                      style:
                          GoogleFonts.aBeeZee(fontSize: AppFontSize.sizeSmall),
                    ),
            )
          ]),
        ),
      ),
    );
  }
}
