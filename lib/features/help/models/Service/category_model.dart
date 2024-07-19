import 'package:cloud_firestore/cloud_firestore.dart';

class CategoryModel {
  String category;
  List<Service> services;

  CategoryModel({
    required this.category,
    required this.services,
  });

  factory CategoryModel.fromJson(Map<String, dynamic> json) {
    return CategoryModel(
      category: json['category'],
      services: (json['services'] as List)
          .map((service) => Service.fromJson(service))
          .toList(),
    );
  }

  static Future<List<CategoryModel>> getCategories() async {
    QuerySnapshot querySnapshot = await FirebaseFirestore.instance
        .collection('categories')
        .get();

    return querySnapshot.docs
        .map((doc) => CategoryModel.fromJson(doc.data() as Map<String, dynamic>))
        .toList();
  }

  Future<List<Service>> getServicesForCategory() async {
    QuerySnapshot querySnapshot = await FirebaseFirestore.instance
        .collection('categories')
        .doc(category)
        .get()
        .then((documentSnapshot) => documentSnapshot.reference
        .collection('services')
        .get());

    return querySnapshot.docs
        .map((doc) => Service.fromJson(doc.data() as Map<String, dynamic>))
        .toList();
  }
}

class Service {
  String serviceId;
  String serviceName;
  String serviceImage;
  List<String> warranty;

  Service({
    required this.serviceId,
    required this.serviceName,
    required this.serviceImage,
    required this.warranty,
  });

  factory Service.fromJson(Map<String, dynamic> json) {
    return Service(
      serviceId: json['serviceId'],
      serviceName: json['serviceName'],
      serviceImage: json['serviceImage'],
      warranty: (json['warranty'] as List)
          .map((warranty) => warranty as String)
          .toList(),
    );
  }
}
