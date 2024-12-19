import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:quizlet_xspin/base/base.page.dart';
import 'package:quizlet_xspin/constants/app_color.dart';
import 'package:quizlet_xspin/languages/string_extension.dart';
import 'package:quizlet_xspin/models/flash_card.model.dart';
import 'package:quizlet_xspin/theme/theme_service.dart';
import 'package:quizlet_xspin/viewmodel/lst_flash_card.vm.dart';

class InfoForm extends StatefulWidget {
  const InfoForm(
      {super.key, required this.idListCard, required this.viewModel});
  final String idListCard;
  final ListFlashCardViewModel viewModel;
  @override
  State<InfoForm> createState() => _InfoFormState();
}

class _InfoFormState extends State<InfoForm> {
  final themeService = GetIt.instance<ThemeService>();

  // Hàm để thêm một Card mới
  void _addCard() {
    if (widget.viewModel.engLishCreate.last.text.isEmpty ||
        widget.viewModel.vietNameCreate.last.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("error".tr())),
      );
    } else {
      setState(() {
        widget.viewModel.engLishCreate.add(TextEditingController());
        widget.viewModel.vietNameCreate.add(TextEditingController());
      });
    }
    for (int i = 0; i < widget.viewModel.engLishCreate.length; i++) {
      String englishValue = widget.viewModel.engLishCreate[i].text;
      String vietnamValue = widget.viewModel.vietNameCreate[i].text;
      print(
          "Card ${i + 1}: English = $englishValue, Vietnamese = $vietnamValue");
    }
  }

  Future<void> _submitData() async {
    bool hasEmptyField = false;
    for (int i = 0; i < widget.viewModel.engLishCreate.length; i++) {
      if (widget.viewModel.engLishCreate[i].text.isEmpty ||
          widget.viewModel.vietNameCreate[i].text.isEmpty) {
        hasEmptyField = true;
        break;
      }
    }

    if (hasEmptyField) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("error".tr())),
      );
    } else {
      List<FlashCardModel> flashCards = [];
      for (int i = 0; i < widget.viewModel.engLishCreate.length; i++) {
        flashCards.add(FlashCardModel(
          english: widget.viewModel.engLishCreate[i].text,
          vietnam: widget.viewModel.vietNameCreate[i].text,
        ));
      }
      await widget.viewModel.createFlashCard(
        widget.idListCard,
        flashCards,
      );
      setState(() {
        widget.viewModel.engLishCreate.clear();
        widget.viewModel.vietNameCreate.clear();
        Navigator.pop(context);
      });
      await widget.viewModel.getFlashCard(widget.idListCard);
    }
  }

  @override
  void initState() {
    super.initState();

    // Đảm bảo luôn có ít nhất một trường mặc định khi khởi tạo
    if (widget.viewModel.engLishCreate.isEmpty) {
      widget.viewModel.engLishCreate.add(TextEditingController());
      widget.viewModel.vietNameCreate.add(TextEditingController());
    }
  }

  @override
  Widget build(BuildContext context) {
    final isDarkMode = themeService.isDarkMode;

    final colorCard = isDarkMode
        ? const Color.fromARGB(255, 45, 43, 43)
        : AppColor.extraColor;

    return BasePage(
      floating: FloatingActionButton(
        backgroundColor: AppColor.blueLight,
        onPressed: _addCard,
        child: Icon(
          Icons.add,
          color: AppColor.extraColor,
          size: 30,
          weight: 30,
        ),
      ),
      showFinal: true,
      showLeading: true,
      onTap: _submitData,
      body: SingleChildScrollView(
        child: AnimatedSwitcher(
          duration: const Duration(milliseconds: 300),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ...List.generate(
                  widget.viewModel.engLishCreate.length,
                  (index) {
                    return Card(
                      elevation: 5,
                      color: colorCard,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                      margin: const EdgeInsets.symmetric(vertical: 8),
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Column(
                          children: [
                            TextField(
                              controller: widget.viewModel.engLishCreate[index],
                              decoration: InputDecoration(
                                labelText: 'english'.tr(),
                                border: OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(15)),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(15)),
                                  borderSide:
                                      BorderSide(color: Colors.green, width: 2),
                                ),
                                focusColor: Colors.green,
                                floatingLabelStyle:
                                    GoogleFonts.aBeeZee(color: Colors.green),
                              ),
                            ),
                            const SizedBox(height: 20),
                            TextField(
                              controller:
                                  widget.viewModel.vietNameCreate[index],
                              decoration: InputDecoration(
                                labelText: 'vietnamese'.tr(),
                                border: OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(15)),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(15)),
                                  borderSide:
                                      BorderSide(color: Colors.green, width: 2),
                                ),
                                focusColor: Colors.green,
                                floatingLabelStyle:
                                    GoogleFonts.aBeeZee(color: Colors.green),
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
