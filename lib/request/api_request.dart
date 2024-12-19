import 'package:dio/dio.dart';
import 'package:quizlet_xspin/constants/api.dart';
import 'package:quizlet_xspin/models/flash_card.model.dart';
import 'package:quizlet_xspin/models/lst_flash_card.model.dart';
import 'package:quizlet_xspin/models/user.model.dart';
import 'package:quizlet_xspin/services/api_services.dart';

class API_REQUEST {
  Dio dio = Dio();
  Future<UserModel?> LOGIN({required String phone, required String pw}) async {
    final response = await ApiService().postRequest(
        '${API.LOCAL_HOST}${API.LOGIN}?SoDienThoai=$phone&MatKhau=$pw');
    if (response.statusCode == API.STATUS_CODE) {
      print('Response: ${response.data}'); // In dữ liệu trả về từ API

      final data = response.data;
      if (data != null) {
        final status = data['Status'];
        if (status == 0) {
          print(
              'Login failed: Tài khoản không tồn tại hoặc thông tin đăng nhập không chính xác');
          return null;
        } else {
          final user = UserModel.fromJson(data);
          return user;
        }
      } else {
        print('Không nhận được dữ liệu');
        return null;
      }
    } else {
      print('Đăng nhập thất bại: Mã trạng thái ${response.statusCode}');
      return null;
    }
  }

  Future<UserModel?> SIGNUP(
      {required String phone, required String pw, required String name}) async {
    final response = await ApiService().postRequest(
        '${API.LOCAL_HOST}${API.SIGNUP}?SoDienThoai=$phone&MatKhau=$pw&TenNguoiDung=$name');
    if (response.statusCode == API.STATUS_CODE) {
      print('Response: ${response.data}'); // In dữ liệu trả về từ API

      final data = response.data;
      if (data != null) {
        final status = data['Status'];
        if (status == 0) {
          print(
              'Login failed: Số điện thoại đã tồn tại hoặc thông tin nhập không chính xác');
          return null;
        } else {
          final user = UserModel.fromJson(data);
          return user;
        }
      } else {
        print('Không nhận được dữ liệu');
        return null;
      }
    } else {
      print('Đăng nhập thất bại: Mã trạng thái ${response.statusCode}');
      return null;
    }
  }

  Future<List<LstFlashCardModel>> GET_LIST_FLASHCARD(
      {required String idUser}) async {
    List<LstFlashCardModel> LstFlashCardModels = [];
    try {
      final response = await ApiService()
          .postRequest('${API.LOCAL_HOST}${API.GET_LIST_CARD}?idUser=$idUser');
      print('Response: ${response.data}');
      if (response.statusCode == API.STATUS_CODE) {
        List<dynamic> data = response.data;
        LstFlashCardModels =
            data.map((json) => LstFlashCardModel.fromJson(json)).toList();
      } else {
        throw Exception('Failed to load list flash card');
      }
    } catch (e) {
      print('Error: $e');
    }
    return LstFlashCardModels;
  }

  Future<List<FlashCardModel>> GET_FLASH_CARD(
      {required String idListCard}) async {
    List<FlashCardModel> lstFlashCard = [];
    try {
      final response = await ApiService().postRequest(
          '${API.LOCAL_HOST}${API.GET_FLASH_CARD}?idListCard=$idListCard');
      if (response.statusCode == API.STATUS_CODE) {
        if (response.data is Map && response.data['Status'] == 0) {
          print('rỗng');
          return lstFlashCard;
        } else {
          List<dynamic> data = response.data;
          lstFlashCard =
              data.map((json) => FlashCardModel.fromJson(json)).toList();
        }
      } else {
        throw Exception('Failed to load list flash card');
      }
    } catch (e) {
      print('Error: $e');
    }
    return lstFlashCard;
  }

  Future<LstFlashCardModel?> DELETE_LIST_FLASHCARD({
    required String idUser,
    required String idLstCard,
  }) async {
    final response = await ApiService().postRequest(
        '${API.LOCAL_HOST}${API.DELETE_LIST_FLASHCARD}?idUser=$idUser&idLstCard=$idLstCard');
    if (response.statusCode == API.STATUS_CODE) {
      print('Response: ${response.data}');
      final data = response.data;
      if (data != null) {
        final status = data['Status'];
        if (status == 0) {
          print('DELETE LIST FLASH CARD FAILD');
          return null;
        } else {
          final lst_flashCard = LstFlashCardModel.fromJson(data);
          return lst_flashCard;
        }
      } else {
        print('LIST FLASH CARD IS NULL');
        return null;
      }
    } else {
      print('DELETE LIST FLASH CARD FAILD: STATUS ${response.statusCode}');
      return null;
    }
  }

  Future<LstFlashCardModel?> UPDATE_LIST_FLASHCARD({
    required String newName,
    required String idLstCard,
  }) async {
    final response = await ApiService().postRequest(
        '${API.LOCAL_HOST}${API.UPDATE_NAME_LIST_FLASHCARD}?idLstCard=$idLstCard&nameLstCard=$newName');
    if (response.statusCode == API.STATUS_CODE) {
      print('Response: ${response.data}');
      final data = response.data;
      if (data != null) {
        final status = data['Status'];
        if (status == 0) {
          print('UPDATE LIST FLASH CARD FAILD');
          return null;
        } else {
          final lst_flashCard = LstFlashCardModel.fromJson(data);
          return lst_flashCard;
        }
      } else {
        print('LIST FLASH CARD IS NULL');
        return null;
      }
    } else {
      print('UPDATE LIST FLASH CARD FAILD: STATUS ${response.statusCode}');
      return null;
    }
  }

  Future<FlashCardModel?> UPDATE_FLASHCARD({
    required String idFlashCard,
    required String newEnglish,
    required String newVietNam,
  }) async {
    final response = await ApiService().postRequest(
        '${API.LOCAL_HOST}${API.UPDATE_NAME_FLASHCARD}?idFlashCard=$idFlashCard&newEnglish=$newEnglish&newVietNam=$newVietNam');
    if (response.statusCode == API.STATUS_CODE) {
      print('Response: ${response.data}');
      final data = response.data;
      if (data != null) {
        final status = data['Status'];
        if (status == 0) {
          print('UPDATE FLASH CARD FAILD');
          return null;
        } else {
          final flashCard = FlashCardModel.fromJson(data);
          return flashCard;
        }
      } else {
        print('FLASH CARD IS NULL');
        return null;
      }
    } else {
      print('UPDATE FLASH CARD FAILD: STATUS ${response.statusCode}');
      return null;
    }
  }

  Future<FlashCardModel?> DELETE_FLASHCARD({
    required String idFlashCard,
  }) async {
    final response = await ApiService().postRequest(
        '${API.LOCAL_HOST}${API.DELETE_FLASHCARD}?idFlashCard=$idFlashCard');
    if (response.statusCode == API.STATUS_CODE) {
      print('Response: ${response.data}');
      final data = response.data;
      if (data != null) {
        final status = data['Status'];
        if (status == 0) {
          print('DELETE FLASH CARD FAILD');
          return null;
        } else {
          final flashcard = FlashCardModel.fromJson(data);
          return flashcard;
        }
      } else {
        print('FLASH CARD IS NULL');
        return null;
      }
    } else {
      print('DELETE FLASH CARD FAILD: STATUS ${response.statusCode}');
      return null;
    }
  }

  Future<LstFlashCardModel?> CREATE_LIST_FLASH_CARD(
      {required String idUser,
      required String idLstCard,
      required String nameLstCard,
      required String share}) async {
    final response = await ApiService().postRequest(
        '${API.LOCAL_HOST}${API.CREATE_LIST_FLASH_CARD}?idUser=$idUser&idLstCard=$idLstCard&nameLstCard=$nameLstCard&share=$share');
    if (response.statusCode == API.STATUS_CODE) {
      print('Response: ${response.data}');
      final data = response.data;
      if (data != null) {
        final status = data['Status'];
        if (status == 0) {
          print('CREATE LIST FLASH CARD FAILD');
          return null;
        } else {
          final lst_flashCard = LstFlashCardModel.fromJson(data);
          return lst_flashCard;
        }
      } else {
        print('LIST FLASH CARD IS NULL');
        return null;
      }
    } else {
      print('CREATE LIST FLASH CARD FAILD: STATUS ${response.statusCode}');
      return null;
    }
  }

  Future<bool> CREATE_FLASH_CARDS({
    required String idLstCard,
    required List<FlashCardModel> flashCards,
  }) async {
    // Chuyển đổi danh sách flashCards thành JSON
    final flashCardsJson = flashCards.map((flashCard) {
      return {
        'EngLish': flashCard.english,
        'VietNam': flashCard.vietnam,
      };
    }).toList();

    final Map<String, dynamic> data = {
      'idLstCard': idLstCard,
      'flashCards': flashCardsJson,
    };

    // Gửi request POST với dữ liệu JSON
    final response = await ApiService().postRequest(
      '${API.LOCAL_HOST}${API.CREATE_FLASH_CARD}',
      queryParameters: data, // gửi body dưới dạng JSON
    );

    if (response.statusCode == API.STATUS_CODE) {
      print('Response: ${response.data}');
      final data = response.data;
      if (data != null) {
        final status = data['Status'];
        if (status == 0) {
          print('CREATE FLASH CARDS FAILED');
          return false;
        } else {
          print('CREATE FLASH CARDS SUCCESSFUL');
          return true;
        }
      } else {
        print('FLASH CARDS IS NULL');
        return false;
      }
    } else {
      print('CREATE FLASH CARDS FAILED: STATUS ${response.statusCode}');
      return false;
    }
  }
}
