import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:quizlet_xspin/app/app_sp.dart';
import 'package:quizlet_xspin/app/app_sp_key.dart';
import 'package:quizlet_xspin/constants/app_color.dart';
import 'package:quizlet_xspin/languages/string_extension.dart';
import 'package:quizlet_xspin/models/user.model.dart';
import 'package:quizlet_xspin/request/api_request.dart';
import 'package:quizlet_xspin/viewmodel/index.vm.dart';
import 'package:quizlet_xspin/views/auth/login/login.view.dart';
import 'package:quizlet_xspin/views/index/index.dart';
import 'package:stacked/stacked.dart';

class UserViewModel extends BaseViewModel {
  TextEditingController phone = TextEditingController();
  TextEditingController password = TextEditingController();
  TextEditingController rePassword = TextEditingController();
  TextEditingController name = TextEditingController();
  late BuildContext viewContext;
  bool _obscureText = true;
  bool get obscureText => _obscureText;
  API_REQUEST apiRequest = API_REQUEST();
  late IndexViewModel indexViewModel;
  UserModel? data;
  loadUser() async {
    setBusy(true);
    data = await apiRequest.LOGIN(
        phone: AppSP.get(AppSPKey.phone), pw: AppSP.get(AppSPKey.password));
    setBusy(false);
    notifyListeners();
  }

  Future<void> loginSuccess(
      BuildContext context, String phone, String paw) async {
    setBusy(true);
    try {
      data = await apiRequest.LOGIN(phone: phone, pw: paw);
      if (data != null) {
        AppSP.set(AppSPKey.phone, phone);
        AppSP.set(AppSPKey.password, paw);
        AppSP.set(AppSPKey.idUser, data!.idUser.toString());
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (context) => const IndexPage()),
        );
      } else {
        faildDialog(context, 'notexist'.tr(), 'loginfaild'.tr());
      }
    } catch (e) {
      print('Login failed: $e');
      faildDialog(context, 'errorlogin'.tr(), 'loginfaild'.tr());
    }
    setBusy(false);
    notifyListeners();
  }

  Future<void> signInSuccess(BuildContext context, String rePaw, String phone,
      String paw, String name) async {
    setBusy(true);
    try {
      if (paw != rePaw) {
        faildDialog(
          context,
          'pwnotmatch'.tr(),
          'signupfaild'.tr(),
        );
        setBusy(false);
        return;
      }
      data = await apiRequest.SIGNUP(phone: phone, pw: paw, name: name);
      if (data != null) {
        successDialog(context, 'successsignupapp'.tr(), 'successsignup'.tr());
      } else {
        faildDialog(context, 'exist'.tr(), 'signupfaild'.tr());
      }
    } catch (e) {
      print('SignUp failed: $e');
      faildDialog(context, 'errorsignup'.tr(), 'signupfaild'.tr());
    }
    setBusy(false);
    notifyListeners();
  }

  void showLogOut(BuildContext context) {
    AwesomeDialog(
      context: context,
      dialogType: DialogType.question,
      animType: AnimType.topSlide,
      showCloseIcon: true,
      title: 'notifi'.tr(),
      desc: 'descnoti'.tr(),
      btnCancelOnPress: () {},
      btnCancelText: 'cancel'.tr(),
      btnOkOnPress: () {
        AppSP.set(AppSPKey.phone, '');
        AppSP.set(AppSPKey.password, '');
        AppSP.set(AppSPKey.idUser, '');
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (context) => const LoginView()),
        );
      },
      btnOkText: 'yes'.tr(),
    ).show();
  }

  void faildDialog(BuildContext context, String desc, String title) {
    AwesomeDialog(
      context: viewContext,
      dialogType: DialogType.error,
      animType: AnimType.topSlide,
      showCloseIcon: true,
      title: title,
      desc: desc,
      btnOkColor: AppColor.selectColor,
      btnOkOnPress: () {},
      btnOkText: 'try'.tr(),
    ).show();
  }

  void successDialog(BuildContext context, String desc, String title) {
    AwesomeDialog(
      context: viewContext,
      dialogType: DialogType.success,
      animType: AnimType.topSlide,
      showCloseIcon: true,
      title: title,
      desc: desc,
      btnOkColor: AppColor.green,
      btnOkOnPress: () {
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (context) => const LoginView()),
        );
      },
      btnOkText: 'confirm'.tr(),
    ).show();
  }
}
