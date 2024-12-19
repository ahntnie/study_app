import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:quizlet_xspin/constants/app_color.dart';
import 'package:quizlet_xspin/languages/string_extension.dart';
import 'package:quizlet_xspin/viewmodel/user_vm.dart';
import 'package:quizlet_xspin/views/auth/signup/signup.view.dart';
import 'package:quizlet_xspin/views/auth/widgets/button.widget.dart';
import 'package:quizlet_xspin/views/auth/widgets/textfield.widget.dart';
import 'package:stacked/stacked.dart';

class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder.reactive(
        viewModelBuilder: () => UserViewModel(),
        onViewModelReady: (viewModel) {
          viewModel.viewContext = context;
        },
        builder: (context, viewModel, child) {
          return Scaffold(
            body: Container(
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    Color(0xFF141E30), // Dark blue background
                    Color(0xFF243B55), // Lighter blue
                  ],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                ),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'signin'.tr(),
                    style: GoogleFonts.aBeeZee(
                        color: AppColor.extraColor,
                        fontSize: 35,
                        fontWeight: FontWeight.bold),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  TextFieldWidget(
                      hintText: 'phone'.tr(), controller: viewModel.phone),
                  TextFieldWidget(
                      obscureText: viewModel.obscureText,
                      hintText: 'password'.tr(),
                      controller: viewModel.password),
                  const SizedBox(height: 30),
                  ButtonWidget(
                      color: AppColor.selectColor,
                      title: 'signin'.tr(),
                      onTap: () {
                        viewModel.isBusy
                            ? Center(
                                child: CircularProgressIndicator(
                                  color: AppColor.primaryColor,
                                ),
                              )
                            : viewModel.loginSuccess(context,
                                viewModel.phone.text, viewModel.password.text);
                      },
                      colorLight: AppColor.lightRed),
                  SizedBox(
                    height: 25,
                  ),
                  ButtonWidget(
                      color: AppColor.blue,
                      title: 'signup'.tr(),
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const SignUpView()));
                      },
                      colorLight: AppColor.blueLight.withOpacity(0.1)),
                ],
              ),
            ),
          );
        });
  }
}
