import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart%20%20';




class LocationRepository extends GetxController{
  static LocationRepository get instance => Get.find();


  /// Variables

  /// get Current Location
  Future<Position> getCurrentLocation() async {
    return await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.high,
    );
  }



  /// Get Location Details Current Location
  Future<Map<String, String?>> _getLocationDetails(Position position) async {
    List<Placemark> placemarks =
    await placemarkFromCoordinates(position.latitude, position.longitude);
    Placemark placemark = placemarks.first;

    return {
      'city': placemark.locality,
      'state': placemark.administrativeArea,
      'district': placemark.subAdministrativeArea,
      'postalCode': placemark.postalCode,
    };
  }

  Future<Map<String, String?>> getLocationDetails() async {
    Position position = await getCurrentLocation();
    return await _getLocationDetails(position);
  }



  /// create method for getting location cordinate

}