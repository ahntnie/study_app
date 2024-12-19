import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:quizlet_xspin/app/app_sp.dart';
import 'package:quizlet_xspin/app/app_sp_key.dart';
import 'package:quizlet_xspin/constants/app_color.dart';
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
        faildDialog(
            context,
            'Tài khoản không tồn tại hoặc mật khẩu không chính xác',
            'Đăng nhập thất bại');
      }
    } catch (e) {
      print('Login failed: $e');
      faildDialog(
          context,
          'Có lỗi xảy ra trong quá trình đăng nhập, vui lòng thử lại sau',
          'Đăng nhập thất bại');
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
          'Mật khẩu và xác nhận mật khẩu không trùng khớp',
          'Đăng ký thất bại',
        );
        setBusy(false);
        return; // Dừng quá trình đăng ký nếu không khớp
      }
      data = await apiRequest.SIGNUP(phone: phone, pw: paw, name: name);
      if (data != null) {
        successDialog(
            context, 'Đăng ký ứng dụng thành công', 'Đăng ký thành công');
      } else {
        faildDialog(
            context,
            'Tài khoản đã tồn tại hoặc thông tin không chính xác',
            'Đăng ký thất bại');
      }
    } catch (e) {
      print('SignUp failed: $e');
      faildDialog(
          context,
          'Có lỗi xảy ra trong quá trình đăng ký, vui lòng thử lại sau',
          'Đăng ký thất bại');
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
      title: 'Thông báo!',
      desc: 'Bạn có muốn đăng xuất ứng dụng?',
      btnCancelOnPress: () {},
      btnCancelText: 'Hủy',
      btnOkOnPress: () {
        AppSP.set(AppSPKey.phone, '');
        AppSP.set(AppSPKey.password, '');
        AppSP.set(AppSPKey.idUser, '');
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (context) => const LoginView()),
        );
      },
      btnOkText: 'Có',
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
      btnOkText: 'Thử lại',
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
      btnOkText: 'Xác nhận',
    ).show();
  }
}
