class NeedItemModel {
  final String img;
  final String text;

  NeedItemModel({required this.img, required this.text});

  factory NeedItemModel.fromMap(Map<String, dynamic> data) {
    return NeedItemModel(
      img: data['img'] ?? '',
      text: data['text'] ?? '',
    );
  }
}