import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:quizlet_xspin/constants/app_color.dart';
import 'package:quizlet_xspin/languages/string_extension.dart';
import 'package:quizlet_xspin/viewmodel/user_vm.dart';
import 'package:quizlet_xspin/views/auth/splash/splash.view.dart';
import 'package:quizlet_xspin/views/auth/widgets/button.widget.dart';
import 'package:quizlet_xspin/views/auth/widgets/textfield.widget.dart';
import 'package:stacked/stacked.dart';

class SignUpView extends StatefulWidget {
  const SignUpView({super.key});

  @override
  State<SignUpView> createState() => _SignUpViewState();
}

class _SignUpViewState extends State<SignUpView> {
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder.reactive(
        viewModelBuilder: () => UserViewModel(),
        onViewModelReady: (viewModel) {
          viewModel.viewContext = context;
        },
        builder: (context, viewModel, child) {
          return Scaffold(
            body: SingleChildScrollView(
              child: ConstrainedBox(
                constraints: BoxConstraints(
                  minHeight: MediaQuery.of(context).size.height,
                ),
                child: IntrinsicHeight(
                  child: Container(
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
                          'signup'.tr(),
                          style: GoogleFonts.aBeeZee(
                              color: AppColor.extraColor,
                              fontSize: 35,
                              fontWeight: FontWeight.bold),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        TextFieldWidget(
                            hintText: 'nameuser'.tr(),
                            controller: viewModel.name),
                        TextFieldWidget(
                            hintText: 'phone'.tr(),
                            controller: viewModel.phone),
                        TextFieldWidget(
                            obscureText: viewModel.obscureText,
                            hintText: 'password'.tr(),
                            controller: viewModel.password),
                        TextFieldWidget(
                            obscureText: viewModel.obscureText,
                            hintText: 'repassword'.tr(),
                            controller: viewModel.rePassword),
                        SizedBox(
                          height: 50,
                        ),
                        ButtonWidget(
                            color: AppColor.selectColor,
                            title: 'signup'.tr(),
                            onTap: () {
                              viewModel.isBusy
                                  ? Center(
                                      child: CircularProgressIndicator(
                                        color: AppColor.primaryColor,
                                      ),
                                    )
                                  : viewModel.signInSuccess(
                                      context,
                                      viewModel.rePassword.text,
                                      viewModel.phone.text,
                                      viewModel.password.text,
                                      viewModel.name.text);
                            },
                            colorLight: AppColor.lightRed),
                        SizedBox(
                          height: 25,
                        ),
                        ButtonWidget(
                            color: AppColor.blue,
                            title: 'cancel'.tr(),
                            onTap: () {
                              if (Navigator.canPop(context)) {
                                Navigator.pop(context);
                              } else {
                                Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => const SplashView()),
                                );
                              }
                            },
                            colorLight: AppColor.blueLight.withOpacity(0.1)),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
        });
  }
}
