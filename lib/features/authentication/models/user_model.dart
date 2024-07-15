import 'package:cloud_firestore/cloud_firestore.dart';

import '../../../utils/formatters/formatter.dart';

class UserModel {
  final String id;
  String firstName;
  String lastName;
  final String username;
  final String email;
  String phoneNumber;
  String profilePicture;
  DateTime? lastLoginTime;
  String role;
  String? landmark;
  String? city;
  String? state;
  String? postalCode;
  String? address;
  String? adharCard;
  String? realTimePicture;
  String? street;
  String? locality;
  String? admistrativeArea;
  String? subAdmistrativeArea;
  String? postalCodeAuto;
  String? bookingServiceId;
  String? bookingStatus;
  String? bookingServiceName;
  String? bookingServiceCost;
  String? bookingServiceCategory;
  String? bookingServiceProfessionalId;
  String? bookingServiceWarranty;
  String? bookingServiceAddress;
  String? bookingServiceAdditionalCost;
  String? bookingTime;
  String? fcmToken; // New field for FCM token

  /// Constructor for UserModel.
  UserModel({
    String? landmark,
    this.bookingTime,
    this.bookingServiceId,
    this.bookingStatus,
    this.bookingServiceName,
    this.bookingServiceCost,
    this.bookingServiceCategory,
    this.bookingServiceProfessionalId,
    this.bookingServiceWarranty,
    this.bookingServiceAddress,
    this.bookingServiceAdditionalCost,
    this.city,
    this.state,
    this.postalCode,
    this.address,
    this.adharCard,
    this.realTimePicture,
    this.street,
    this.locality,
    this.admistrativeArea,
    this.subAdmistrativeArea,
    this.postalCodeAuto,
    required this.role,
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.username,
    required this.email,
    required this.phoneNumber,
    required this.profilePicture,
    required this.lastLoginTime,
    this.fcmToken, // Initialize FCM token
  });

  /// Helper function to get full name
  String get fullName => '$firstName $lastName';

  /// Helper function to format number
  String get formattedPhoneNo => YHMFormatter.formatPhoneNumber(phoneNumber);

  /// Static function to split full name into first and last name
  static List<String> nameParts(fullName) => fullName.split(" ");

  static String generateUsername(fullName) {
    List<String> nameParts = fullName.split(" ");
    String firstName = nameParts[0].toLowerCase();
    String lastName = nameParts.length > 1 ? nameParts[1].toLowerCase() : "";
    String camelCaseUsername = "$firstName$lastName";
    String usernameWithPrefix = "cwt_$camelCaseUsername"; // Add "cwt_" prefix
    return usernameWithPrefix;
  }

  /// Static function to create an empty user model.
  static UserModel empty() => UserModel(
    bookingServiceAdditionalCost: '',
    bookingServiceAddress: '',
    bookingServiceCategory: '',
    bookingServiceCost: '',
    bookingServiceId: '',
    bookingTime: '',
    bookingServiceName: '',
    bookingServiceProfessionalId: '',
    bookingServiceWarranty: '',
    bookingStatus: '',
    id: '',
    firstName: '',
    lastName: '',
    username: '',
    email: '',
    phoneNumber: '',
    profilePicture: '',
    lastLoginTime: null,
    role: '',
    landmark: '',
    city: '',
    state: '',
    postalCode: '',
    address: '',
    adharCard: '',
    realTimePicture: '',
    street: '',
    locality: '',
    admistrativeArea: '',
    subAdmistrativeArea: '',
    postalCodeAuto: '',
    fcmToken: '', // Initialize FCM token as empty
  );

  /// Convert model to JSON structure for storing data in Firebase
  Map<String, dynamic> toJson() {
    return {
      'FirstName': firstName,
      'LastName': lastName,
      'Username': username,
      'Email': email,
      'PhoneNumber': phoneNumber,
      'ProfilePicture': profilePicture,
      'LastLoginTime': lastLoginTime,
      'role': role,
      'landmark': landmark,
      'city': city,
      'state': state,
      'postalCode': postalCode,
      'address': address,
      'adharCard': adharCard,
      'realTimePicture': realTimePicture,
      'street': street,
      'locality': locality,
      'admistrativeArea': admistrativeArea,
      'subAdmistrativeArea': subAdmistrativeArea,
      'postalCodeAuto': postalCodeAuto,
      'bookingServiceId': bookingServiceId,
      'bookingStatus': bookingStatus,
      'bookingServiceName': bookingServiceName,
      'bookingServiceCost': bookingServiceCost,
      'bookingServiceCategory': bookingServiceCategory,
      'bookingServiceProfessionalId': bookingServiceProfessionalId,
      'bookingServiceWarranty': bookingServiceWarranty,
      'bookingServiceAddress': bookingServiceAddress,
      'bookingServiceAdditionalCost': bookingServiceAdditionalCost,
      'bookingTime': bookingTime,
      'fcmToken': fcmToken, // Include FCM token in JSON
    };
  }

  factory UserModel.fromSnapshot(DocumentSnapshot<Map<String, dynamic>> document) {
    if (document.data() != null) {
      final data = document.data()!;
      return UserModel(
        id: document.id,
        firstName: data['FirstName'] ?? '',
        lastName: data['LastName'] ?? '',
        username: data['Username'] ?? '',
        email: data['Email'] ?? '',
        phoneNumber: data['PhoneNumber'] ?? '',
        profilePicture: data['ProfilePicture'] ?? '',
        lastLoginTime: data['LastLoginTime']?.toDate(),
        role: data['role'] ?? '',
        landmark: data['landmark'],
        city: data['city'],
        state: data['state'],
        postalCode: data['postalCode'],
        address: data['address'],
        adharCard: data['adharCard'],
        realTimePicture: data['realTimePicture'],
        street: data['street'],
        locality: data['locality'],
        admistrativeArea: data['admistrativeArea'],
        subAdmistrativeArea: data['subAdmistrativeArea'],
        postalCodeAuto: data['postalCodeAuto'],
        bookingServiceId: data['bookingServiceId'],
        bookingStatus: data['bookingStatus'],
        bookingServiceName: data['bookingServiceName'],
        bookingServiceCost: data['bookingServiceCost'],
        bookingServiceCategory: data['bookingServiceCategory'],
        bookingServiceProfessionalId: data['bookingServiceProfessionalId'],
        bookingServiceWarranty: data['bookingServiceWarranty'],
        bookingServiceAddress: data['bookingServiceAddress'],
        bookingServiceAdditionalCost: data['bookingServiceAdditionalCost'],
        bookingTime: data['bookingTime'],
        fcmToken: data['fcmToken'], // Include FCM token from Firestore
      );
    } else {
      return UserModel.empty();
    }
  }
}
