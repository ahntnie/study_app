import 'package:flutter/material.dart';
import 'package:quizlet_xspin/base/base.page.dart';
import 'package:quizlet_xspin/base/nav_bar.page.dart';
import 'package:quizlet_xspin/constants/app_color.dart';
import 'package:quizlet_xspin/languages/string_extension.dart';
import 'package:quizlet_xspin/models/lst_flash_card.model.dart';
import 'package:quizlet_xspin/viewmodel/lst_flash_card.vm.dart';
import 'package:quizlet_xspin/views/student/widget/item.study.widget.dart';
import 'package:quizlet_xspin/views/student/widget/study.widget.dart';
import 'package:stacked/stacked.dart';

class StudyPage extends StatefulWidget {
  const StudyPage({
    super.key,
    required this.data,
    required this.viewModel,
  });
  final List<LstFlashCardModel> data;
  final ListFlashCardViewModel viewModel;

  @override
  State<StudyPage> createState() => _StudyPageState();
}

class _StudyPageState extends State<StudyPage> {
  Future<void> _refreshData() async {
    await widget.viewModel.getListFlashCard();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder.reactive(
        disposeViewModel: false,
        viewModelBuilder: () => widget.viewModel,
        onViewModelReady: (viewModel) async {
          WidgetsBinding.instance.addPostFrameCallback((_) async {
            await viewModel.getListFlashCard();
          });
        },
        builder: (context, viewModel, child) {
          return BasePage(
            showLeading: true,
            title: 'study'.tr(),
            body: viewModel.isBusy
                ? Center(
                    child: CircularProgressIndicator(
                      color: AppColor.primaryColor,
                      // size: 50,
                    ),
                  )
                : RefreshIndicator(
                    onRefresh: _refreshData,
                    color: AppColor.primaryColor,
                    child: ListView.builder(
                      itemCount: widget.data.length,
                      itemBuilder: (context, index) {
                        return Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: ItemStudyWidget(
                                onTap: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => StudyWidget(
                                                idListCard: widget.data[index]
                                                        .idListCard ??
                                                    '',
                                                viewModel: widget.viewModel,
                                              )));
                                },
                                data: widget.data[index],
                                viewModel: widget.viewModel));
                      },
                    ),
                  ),
          );
        });
  }
}
