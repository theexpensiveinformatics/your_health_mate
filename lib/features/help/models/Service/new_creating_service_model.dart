class NewServiceCreateModel {
  String serviceProviderName;
  String serviceProviderEmail;
  String serviceProviderNumber;
  String serviceProviderID;

  String serviceID;
  String liveServiceCategory;
  String liveServiceInitialCost;
  String liveServiceStatus;
  String liveServiceDescription;
  String liveServiceImg;
  String liveServiceID;

  double mapLat;
  double mapLng;
  String mapStreet;
  String mapLocality;
  String mapAdministrativeArea;
  String mapPostalCode;
  String mapCountry;
  String mArea;
  String mCity;
  String mState;
  String mPostalCode;

  double rating;
  String profilePicture;

  NewServiceCreateModel({
    required this.serviceProviderName,
    required this.serviceProviderEmail,
    required this.serviceProviderNumber,
    required this.serviceProviderID,
    required this.serviceID,
    required this.liveServiceCategory,
    required this.liveServiceInitialCost,
    this.liveServiceStatus = 'available',
    required this.liveServiceDescription,
    required this.liveServiceImg,
    required this.liveServiceID,
    required this.mapLat,
    required this.mapLng,
    required this.mapStreet,
    required this.mapLocality,
    required this.mapAdministrativeArea,
    required this.mapPostalCode,
    required this.mapCountry,
    required this.mArea,
    required this.mCity,
    required this.mState,
    required this.mPostalCode,
    this.rating = 0.0,
    required this.profilePicture,
  });

  factory NewServiceCreateModel.fromJson(Map<String, dynamic> json) {
    return NewServiceCreateModel(
      serviceProviderName: json['serviceProviderName'],
      serviceProviderEmail: json['serviceProviderEmail'],
      serviceProviderNumber: json['serviceProviderNumber'],
      serviceProviderID: json['serviceProviderID'],
      serviceID: json['serviceID'],
      liveServiceCategory: json['liveServiceCategory'],
      liveServiceInitialCost: json['liveServiceInitialCost'],
      liveServiceStatus: json['liveServiceStatus'],
      liveServiceDescription: json['liveServiceDescription'],
      liveServiceImg: json['liveServiceImg'],
      liveServiceID: json['liveServiceID'],
      mapLat: json['mapLat'],
      mapLng: json['mapLng'],
      mapStreet: json['mapStreet'],
      mapLocality: json['mapLocality'],
      mapAdministrativeArea: json['mapAdministrativeArea'],
      mapPostalCode: json['mapPostalCode'],
      mapCountry: json['mapCountry'],
      mArea: json['mArea'],
      mCity: json['mCity'],
      mState: json['mState'],
      mPostalCode: json['mPostalCode'],
      rating: json['rating'],
      profilePicture: json['profilePicture'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'serviceProviderName': serviceProviderName,
      'serviceProviderEmail': serviceProviderEmail,
      'serviceProviderNumber': serviceProviderNumber,
      'serviceProviderID': serviceProviderID,
      'serviceID': serviceID,
      'liveServiceCategory': liveServiceCategory,
      'liveServiceInitialCost': liveServiceInitialCost,
      'liveServiceStatus': liveServiceStatus,
      'liveServiceDescription': liveServiceDescription,
      'liveServiceImg': liveServiceImg,
      'liveServiceID': liveServiceID,
      'mapLat': mapLat,
      'mapLng': mapLng,
      'mapStreet': mapStreet,
      'mapLocality': mapLocality,
      'mapAdministrativeArea': mapAdministrativeArea,
      'mapPostalCode': mapPostalCode,
      'mapCountry': mapCountry,
      'mArea': mArea,
      'mCity': mCity,
      'mState': mState,
      'mPostalCode': mPostalCode,
      'rating': rating,
      'profilePicture': profilePicture,
    };
  }
}
