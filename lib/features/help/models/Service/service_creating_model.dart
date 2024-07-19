import 'package:cloud_firestore/cloud_firestore.dart';

class ServiceCreatingModel {
  String serviceId;
  String serviceName;
  String serviceImage;
  List<String> warranties;

  ServiceCreatingModel({
    required this.serviceId,
    required this.serviceName,
    required this.serviceImage,
    required this.warranties,
  });

  // Empty helper function
  static ServiceCreatingModel empty() => ServiceCreatingModel(
    serviceId: '',
    serviceName: '',
    serviceImage: '',
    warranties: [],
  );

  // Convert model to JSON so we can store data on Firebase
  Map<String, dynamic> toJson() => {
    'serviceId': serviceId,
    'serviceName': serviceName,
    'serviceImage': serviceImage,
    'warranty': warranties,
  };

  // Map the JSON data to the model
  factory ServiceCreatingModel.fromSnapshot(DocumentSnapshot<Map<String, dynamic>> document) {
    final data = document.data();
    if (data != null) {
      return ServiceCreatingModel(
        serviceId: data['serviceId'] ?? '',
        serviceName: data['serviceName'] ?? '',
        serviceImage: data['serviceImage'] ?? '',
        warranties: List<String>.from(data['warranty'] ?? []),
      );
    } else {
      return ServiceCreatingModel.empty();
    }
  }

  // Map the map data to the model
  factory ServiceCreatingModel.fromMap(Map<String, dynamic> data) {
    return ServiceCreatingModel(
      serviceId: data['serviceId'] ?? '',
      serviceName: data['serviceName'] ?? '',
      serviceImage: data['serviceImage'] ?? '',
      warranties: List<String>.from(data['warranty'] ?? []),
    );
  }
}
