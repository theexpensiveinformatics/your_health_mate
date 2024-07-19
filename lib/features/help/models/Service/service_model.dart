import 'package:cloud_firestore/cloud_firestore.dart';

class ServiceModel {
  String? liveServiceId;
  int? additionalCost;
  String? admistrativeArea;
  String? category;
  String? city;
  String? cost;
  String? liveStatus;
  String? locality;
  GeoPoint? location;
  String? postalCode;
  String? serviceStatus;
  String? street;
  String? subAdmistrativeArea;
  String? serviceName; // New field
  String? userId;
  String? imageUrl;
  String? description;
  String? warranty; // Updated type
  String? serviceId; // Updated type

  ServiceModel({
    this.liveServiceId,
    this.additionalCost,
    this.admistrativeArea,
    this.category,
    this.city,
    this.cost,
    this.liveStatus,
    this.locality,
    this.location,
    this.postalCode,
    this.serviceStatus,
    this.street,
    this.subAdmistrativeArea,
    this.serviceName,
    this.userId,
    this.imageUrl,
    this.description,
    this.warranty,
    this.serviceId,
  });

  ServiceModel.fromJson(Map<String, dynamic> json) {
    liveServiceId=json['liveServiceId'];
    additionalCost = json['additionalCost'];
    admistrativeArea = json['admistrativeArea'];
    category = json['category'];
    city = json['city'];
    cost = json['cost'];
    liveStatus = json['liveStatus'];
    locality = json['locality'];
    location = json['location'] != null ? GeoPoint(json['location']['latitude'], json['location']['longitude']) : null;
    postalCode = json['postalCode'];
    serviceStatus = json['serviceStatus'];
    street = json['street'];
    subAdmistrativeArea = json['subAdmistrativeArea'];
    serviceName = json['serviceName']; // New field
    userId = json['userId'];
    imageUrl = json['imageUrl'];
    description = json['description'];
    warranty = json['warranty'];
    serviceId = json['serviced'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['additionalCost'] = this.additionalCost;
    data['admistrativeArea'] = this.admistrativeArea;
    data['category'] = this.category;
    data['city'] = this.city;
    data['cost'] = this.cost;
    data['liveStatus'] = this.liveStatus;
    data['locality'] = this.locality;
    if (this.location != null) {data['location'] = {'latitude': this.location!.latitude, 'longitude': this.location!.longitude};}
    data['postalCode'] = this.postalCode;
    data['serviceStatus'] = this.serviceStatus;
    data['street'] = this.street;
    data['subAdmistrativeArea'] = this.subAdmistrativeArea;
    data['serviceName'] = this.serviceName; // New field
    data['userId'] = this.userId;
    data['imageUrl'] = this.imageUrl;
    data['description'] = this.description;
    data['warranty'] = this.warranty;
    data['serviceId'] = this.serviceId;
    data['liveServiceId']=this.liveServiceId;
    return data;
  }
}
