import 'package:cloud_firestore/cloud_firestore.dart';

class ServiceBookModel {
  String liveServiceId;
  String bookingServiceId;
  String bookingServiceStatus;
  double mapLng;
  double mapLat;
  String serviceProviderId;
  String serviceProviderEmail;
  String userEmail;
  String userId;
  String markerLocation;
  String userHouseNum;
  String userArea;
  String userInstruction;
  Timestamp bookingServiceTime;
  Timestamp? reachTime;
  Timestamp? diagnoseStartedTime;
  Timestamp? diagnoseCompleteTime;
  Timestamp? serviceStartedTime;
  Timestamp? serviceCompleteTime;
  Timestamp bookingDate;
  String bookingTime;

  ServiceBookModel({
    required this.liveServiceId,
    required this.bookingServiceId,
    required this.bookingServiceStatus,
    required this.mapLng,
    required this.mapLat,
    required this.serviceProviderId,
    required this.serviceProviderEmail,
    required this.userEmail,
    required this.userId,
    required this.markerLocation,
    required this.userHouseNum,
    required this.userArea,
    required this.userInstruction,
    required this.bookingServiceTime,
    this.reachTime,
    this.diagnoseStartedTime,
    this.diagnoseCompleteTime,
    this.serviceStartedTime,
    this.serviceCompleteTime,
    required this.bookingDate,
    required this.bookingTime,
  });

  // Convert a BookingService object into a Firestore document
  Map<String, dynamic> toMap() {
    return {
      'liveServiceId': liveServiceId,
      'bookingServiceId': bookingServiceId,
      'bookingServiceStatus': bookingServiceStatus,
      'mapLng': mapLng,
      'mapLat': mapLat,
      'serviceProviderId': serviceProviderId,
      'serviceProviderEmail': serviceProviderEmail,
      'userEmail': userEmail,
      'userId': userId,
      'markerLocation': markerLocation,
      'userHouseNum': userHouseNum,
      'userArea': userArea,
      'userInstruction': userInstruction,
      'bookingServiceTime': bookingServiceTime,
      'reachTime': reachTime,
      'diagnoseStartedTime': diagnoseStartedTime,
      'diagnoseCompleteTime': diagnoseCompleteTime,
      'serviceStartedTime': serviceStartedTime,
      'serviceCompleteTime': serviceCompleteTime,
      'bookingDate': bookingDate,
      'bookingTime': bookingTime,
    };
  }

  // Create a BookingService object from a Firestore document
  factory ServiceBookModel.fromMap(Map<String, dynamic> map) {
    return ServiceBookModel(
      liveServiceId: map['liveServiceId'] ?? '',
      bookingServiceId: map['bookingServiceId'] ?? '',
      bookingServiceStatus: map['bookingServiceStatus'] ?? '',
      mapLng: map['mapLng']?.toDouble() ?? 0.0,
      mapLat: map['mapLat']?.toDouble() ?? 0.0,
      serviceProviderId: map['serviceProviderId'] ?? '',
      serviceProviderEmail: map['serviceProviderEmail'] ?? '',
      userEmail: map['userEmail'] ?? '',
      userId: map['userId'] ?? '',
      markerLocation: map['markerLocation'] ?? '',
      userHouseNum: map['userHouseNum'] ?? '',
      userArea: map['userArea'] ?? '',
      userInstruction: map['userInstruction'] ?? '',
      bookingServiceTime: map['bookingServiceTime'] ?? Timestamp.now(),
      reachTime: map['reachTime'],
      diagnoseStartedTime: map['diagnoseStartedTime'],
      diagnoseCompleteTime: map['diagnoseCompleteTime'],
      serviceStartedTime: map['serviceStartedTime'],
      serviceCompleteTime: map['serviceCompleteTime'],
      bookingDate: map['bookingDate'] ?? Timestamp.now(),
      bookingTime: map['bookingTime'] ?? '',
    );
  }

  // Create a BookingService object from a Firestore document snapshot
  factory ServiceBookModel.fromSnapshot(DocumentSnapshot snapshot) {
    return ServiceBookModel.fromMap(snapshot.data() as Map<String, dynamic>);
  }
}
