import 'package:cloud_firestore/cloud_firestore.dart';
class CategoryModelTabs {
  String id;
  String category;
  String icon;
  bool isFeatured;

  CategoryModelTabs({
    required this.id,
    required this.category,
    required this.icon,
    required this.isFeatured,
  });

  // Empty helper function
  static CategoryModelTabs empty() =>
      CategoryModelTabs(id: '', category: '', icon: '', isFeatured: false);

  //convert model to json so we can store data on firebase
  Map<String, dynamic> toJson() =>
      {
        'id': id,
        'category': category,
        'icon': icon,
        'isFeatured': isFeatured,
      };

  //map the json data to the model

  factory CategoryModelTabs.fromSnapshot(
      DocumentSnapshot<Map<String, dynamic>> document){
    if (document.data() != null) {
      final data = document.data()!;

      return CategoryModelTabs(
          id: document.id,
          category: data['category'] ?? '',
          icon: data['icon'] ?? '',
          isFeatured: data['isFeatured'] ?? false);
    }else{
      return CategoryModelTabs.empty();
    }
  }


}