class FlashCardModel {
  int? idFlashCard;
  int? idListCard;
  String? english;
  String? vietnam;
  String? image;
  String? desc;

  FlashCardModel({
    this.idFlashCard,
    this.idListCard,
    this.english,
    this.vietnam,
    this.image,
    this.desc,
  });

  factory FlashCardModel.fromJson(Map<String, dynamic> json) {
    return FlashCardModel(
      idFlashCard: json['idFlashCard'] as int?,
      idListCard: json['idListCard'] as int?,
      english: json['EngLish'] as String?,
      vietnam: json['VietNam'] as String?,
      image: json['image'] as String?,
      desc: json['desc'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'idFlashCard': idFlashCard,
      'idListCard': idListCard,
      'EngLish': english,
      'VietNam': vietnam,
      'image': image,
      'desc': desc,
    };
  }
}
