class UserModel {
  int? idUser;
  String? maNguoiDung;
  String? role;
  String? phone;
  String? nameUser;
  String? createDate;
  String? image;
  String? email;

  UserModel({
    this.idUser,
    this.maNguoiDung,
    this.role,
    this.phone,
    this.nameUser,
    this.createDate,
    this.image,
    this.email,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      idUser: json['idUser'] as int?,
      maNguoiDung: json['maNguoiDung'] as String?,
      role: json['role'] as String?,
      phone: json['phone'] as String?,
      nameUser: json['nameUser'] as String?,
      createDate: json['createDate'] as String?,
      image: json['image'] as String?,
      email: json['email'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'idUser': idUser,
      'maNguoiDung': maNguoiDung,
      'role': role,
      'phone': phone,
      'nameUser': nameUser,
      'createDate': createDate,
      'image': image,
      'email': email,
    };
  }
}
