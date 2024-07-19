import 'package:cloud_firestore/cloud_firestore.dart';

class BookServiceModel {
  String? liveServiceId;
  String? additionalCost;
  String? category;
  String? cost;
  String? address;
  String? postalCode;
  String? serviceName;
  String? userName;
  String? professionalId;
  String? userPhone;
  String? userEmail;
  String? warranty;
  String? bookingTime;
  String? serviceId;
  String? bookingStatus; // New field added

  BookServiceModel({
    this.bookingTime,
    this.liveServiceId,
    this.additionalCost,
    this.category,
    this.cost,
    this.address,
    this.postalCode,
    this.serviceName,
    this.userName,
    this.professionalId,
    this.userPhone,
    this.userEmail,
    this.warranty,
    this.serviceId,
    this.bookingStatus, // Initialize the new field in the constructor
  });

  factory BookServiceModel.fromJson(Map<String, dynamic> json) {
    return BookServiceModel(
      liveServiceId: json['liveServiceId'],
      additionalCost: json['additionalCost'],
      category: json['category'],
      cost: json['cost'],
      address: json['address'],
      postalCode: json['postalCode'],
      serviceName: json['serviceName'],
      userName: json['userName'],
      professionalId: json['professionalId'],
      userPhone: json['userPhone'],
      userEmail: json['userEmail'],
      warranty: json['warranty'],
      serviceId: json['serviceId'],
      bookingStatus: json['bookingStatus'], // Parse the new field from JSON
      bookingTime: json['bookingTime'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'liveServiceId': liveServiceId,
      'additionalCost': additionalCost,
      'category': category,
      'cost': cost,
      'address': address,
      'postalCode': postalCode,
      'serviceName': serviceName,
      'userName': userName,
      'professionalId': professionalId,
      'userPhone': userPhone,
      'userEmail': userEmail,
      'warranty': warranty,
      'serviceId': serviceId,
      'bookingStatus': bookingStatus, // Include the new field in the generated JSON
      'bookingTime': bookingTime,
    };
  }
}
