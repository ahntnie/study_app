import 'package:flutter/material.dart';
import 'package:quizlet_xspin/app/app_sp.dart';
import 'package:quizlet_xspin/app/app_sp_key.dart';
import 'package:quizlet_xspin/base/base.page.dart';
import 'package:quizlet_xspin/base/nav_bar.page.dart';
import 'package:quizlet_xspin/constants/app_color.dart';
import 'package:quizlet_xspin/languages/string_extension.dart';
import 'package:quizlet_xspin/viewmodel/lst_flash_card.vm.dart';
import 'package:quizlet_xspin/views/library/widget/add_lst_library.widget.dart';
import 'package:quizlet_xspin/views/library/widget/button.widget.dart';
import 'package:quizlet_xspin/views/library/widget/item_library.widget.dart';
import 'package:quizlet_xspin/views/library/widget/library.widget.dart';
import 'package:stacked/stacked.dart';

class AddLibraryView extends StatefulWidget {
  const AddLibraryView({super.key, required this.viewModel});
  final ListFlashCardViewModel viewModel;
  @override
  State<AddLibraryView> createState() => _AddLibraryViewState();
}

class _AddLibraryViewState extends State<AddLibraryView> {
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
          viewModel.viewContext = context;
          await viewModel.getListFlashCard();
          viewModel.notifyListeners();
        },
        builder: (context, viewModel, child) {
          return BasePage(
            title: 'my_library'.tr(),
            locationFloating: FloatingActionButtonLocation.endTop,
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
                    child: Column(
                      children: [
                        SizedBox(
                          height: 10,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            ButtonLibraryWidget(
                              icons: Icons.folder,
                              colorIcon: AppColor.blueLight,
                              onPressed: () {
                                showAddLibrary(context, viewModel,
                                    AppSP.get(AppSPKey.idUser));
                              },
                              labelTitle: 'upload_new'.tr(),
                            ),
                            ButtonLibraryWidget(
                              icons: Icons.my_library_books,
                              colorIcon: AppColor.green,
                              onPressed: () {},
                              labelTitle: 'download_w'.tr(),
                            )
                          ],
                        ),
                        Expanded(
                          child: viewModel.isBusy
                              ? Center(
                                  child: CircularProgressIndicator(
                                    color: AppColor.primaryColor,
                                    // size: 50,
                                  ),
                                )
                              : ListView.builder(
                                  itemCount: viewModel.ListData.length,
                                  itemBuilder: (context, index) {
                                    return Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: ItemLibraryWidget(
                                            onTap: () {
                                              Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                      builder: (context) =>
                                                          DataLibraryView(
                                                            data: viewModel
                                                                    .ListData[
                                                                index],
                                                            idListCard: viewModel
                                                                    .ListData[
                                                                        index]
                                                                    .idListCard ??
                                                                '',
                                                            viewModel:
                                                                viewModel,
                                                          )));
                                            },
                                            data: viewModel.ListData[index],
                                            viewModel: viewModel));
                                  },
                                ),
                        ),
                      ],
                    ),
                  ),
          );
        });
  }
}
