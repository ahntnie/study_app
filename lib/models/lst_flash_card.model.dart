class LstFlashCardModel {
  final int? idCard;
  final String? idListCard;
  final int? idUser;
  final String? nameLstCard;
  final String? note;
  final String? image;
  final String? createDate;
  final bool? share;
  final int? idSourceFlashCard;
  final int? countFlashCard;

  LstFlashCardModel(
      {this.idCard,
      this.idListCard,
      this.idUser,
      this.nameLstCard,
      this.note,
      this.image,
      this.createDate,
      this.share,
      this.idSourceFlashCard,
      this.countFlashCard});

  factory LstFlashCardModel.fromJson(Map<String, dynamic> json) {
    return LstFlashCardModel(
        idCard: json['idCard'] as int?,
        idListCard:
            json['idListCard'] != null ? json['idListCard'].toString() : null,
        idUser: json['idUser'] as int?,
        nameLstCard: json['nameLstCard'] as String?,
        note: json['note'] as String?,
        image: json['image'] as String?,
        createDate: json['createDate'] as String?,
        share: json['share'] as bool?,
        idSourceFlashCard: json['idSourceFlashCard'] as int?,
        countFlashCard: json['countFlashCard'] as int?);
  }

  Map<String, dynamic> toJson() {
    return {
      'idCard': idCard,
      'idListCard': idListCard,
      'idUser': idUser,
      'nameLstCard': nameLstCard,
      'note': note,
      'image': image,
      'createDate': createDate,
      'share': share,
      'idSourceFlashCard': idSourceFlashCard,
      'countFlashCard': countFlashCard
    };
  }
}
