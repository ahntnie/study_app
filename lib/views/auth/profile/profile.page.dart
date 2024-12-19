import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:quizlet_xspin/base/base.page.dart';
import 'package:quizlet_xspin/constants/app_color.dart';
import 'package:quizlet_xspin/constants/app_fontsize.dart';
import 'package:quizlet_xspin/languages/string_extension.dart';
import 'package:quizlet_xspin/viewmodel/index.vm.dart';
import 'package:quizlet_xspin/viewmodel/user_vm.dart';
import 'package:quizlet_xspin/views/auth/profile/widget/button.widget.dart';
import 'package:quizlet_xspin/views/auth/profile/widget/choose_language.widget.dart';
import 'package:quizlet_xspin/views/auth/profile/widget/selection.widget.dart';
import 'package:quizlet_xspin/views/auth/profile/widget/user.widget.dart';
import 'package:stacked/stacked.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage(
      {super.key, required this.indexViewModel, required this.userViewModel});
  final IndexViewModel indexViewModel;
  final UserViewModel userViewModel;

  @override
  State<ProfilePage> createState() => _HomePageState();
}

class _HomePageState extends State<ProfilePage> {
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder.reactive(
        disposeViewModel: false,
        viewModelBuilder: () => widget.userViewModel,
        onViewModelReady: (viewModel) async {
          await viewModel.loadUser();
          viewModel.viewContext = context;
        },
        builder: (context, viewModel, child) {
          return BasePage(
            onTap: () {
              viewModel.showLogOut(context);
            },
            // locationFloating: FloatingActionButtonLocation.startTop,
            showLogout: true,
            title: 'profile'.tr(),
            body: Column(
              children: [
                Expanded(
                    child: ListView(
                  children: [
                    UserInfo(
                      nameUser: viewModel.data?.nameUser ?? '',
                      phone: viewModel.data?.phone ?? '',
                      uidUser: viewModel.data?.maNguoiDung ?? '',
                    ),
                    SectionTitle(title: 'settings'.tr()),
                    ButtonWidget(
                      showLead: false,
                      onTap: () {},
                      icon: Icons.nights_stay,
                      color: Colors.purple,
                      title: 'displaymode'.tr(),
                    ),
                    ButtonWidget(
                      onTap: () {
                        showLanguageDialog(context);
                      },
                      icon: Icons.language,
                      color: Colors.blue,
                      title: 'language'.tr(),
                    ),
                    SectionTitle(title: 'hotline'.tr()),
                    ButtonWidget(
                      onTap: () {},
                      icon: Icons.language,
                      color: Colors.orange,
                      title: 'Website',
                    ),
                    ButtonWidget(
                      onTap: () {},
                      icon: Icons.facebook,
                      color: Colors.blue,
                      title: 'Facebook',
                    ),
                    ButtonWidget(
                      onTap: () {},
                      icon: Icons.phone,
                      color: Colors.blue,
                      title: 'Zalo',
                    ),
                    ButtonWidget(
                      onTap: () {},
                      icon: Icons.telegram,
                      color: Colors.blue,
                      title: 'Telegram',
                    ),
                  ],
                ))
              ],
            ),
          );
        });
  }
}
