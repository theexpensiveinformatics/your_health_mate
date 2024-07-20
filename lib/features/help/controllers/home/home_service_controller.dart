import 'dart:convert';
import 'package:get/get.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:http/http.dart' as http;

import '../../../personalization/controller/user_controller.dart';
import 'category_controller.dart';

class HomeServiceController extends GetxController {
  final userController = Get.put(UserController()); // Assuming UserController is registered correctly
  final categoryController = Get.put(CategoryController()); // Assuming CategoryController is registered correctly

  RxList<dynamic> liveServices = <dynamic>[].obs;
  RxList<dynamic> allServices = <dynamic>[].obs;
  RxBool isLoading = true.obs;
  final String apiKey = 'AIzaSyCGkKWEylc61Pz7Dj-vesTbpp7jq4zbj8I'; // Replace with your Google API Key

  @override
  void onInit() {
    super.onInit();
    fetchLiveServices();
    ever(categoryController.selectedCategory, (_) {
      filterServices();
    });
  }

  Future<void> fetchLiveServices() async {
    try {
      isLoading.value = true;
      Position position = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
      LatLng userLocation = LatLng(position.latitude, position.longitude);

      FirebaseFirestore firestore = FirebaseFirestore.instance;
      QuerySnapshot querySnapshot = await firestore.collection('LiveServices').get();
      List<Map<String, dynamic>> servicesWithDistance = [];

      for (var doc in querySnapshot.docs) {
        Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
        double distance = Geolocator.distanceBetween(
          userLocation.latitude,
          userLocation.longitude,
          data['mapLat'],
          data['mapLng'],
        );
        int trafficTime = await getTrafficTime(userLocation, LatLng(data['mapLat'], data['mapLng']));
        servicesWithDistance.add({
          'data': data,
          'distance': distance,
          'trafficTime': trafficTime,
        });
      }

      servicesWithDistance.sort((a, b) => a['distance'].compareTo(b['distance']));
      allServices.assignAll(servicesWithDistance);
      filterServices();
    } catch (e) {
      print('Error fetching services: $e');
    } finally {
      isLoading.value = false;
    }
  }

  Future<int> getTrafficTime(LatLng origin, LatLng destination) async {
    final String url = 'https://maps.googleapis.com/maps/api/distancematrix/json?'
        'origins=${origin.latitude},${origin.longitude}&'
        'destinations=${destination.latitude},${destination.longitude}&'
        'departure_time=now&'
        'key=$apiKey';

    final response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      if (data['rows'][0]['elements'][0]['status'] == 'OK') {
        int durationInSeconds = data['rows'][0]['elements'][0]['duration_in_traffic']['value'];
        return durationInSeconds;
      } else {
        print('Error fetching traffic time: ${data['rows'][0]['elements'][0]['status']}');
        return 0;
      }
    } else {
      print('Error fetching traffic data: ${response.statusCode}');
      return 0;
    }
  }

  void filterServices() {
    String selectedCategory = categoryController.selectedCategory.value;
    if (selectedCategory == 'All') {
      liveServices.assignAll(allServices);
    } else {
      liveServices.assignAll(allServices.where((service) {
        return service['data']['liveServiceCategory'] == selectedCategory;
      }).toList());
    }
  }

  Future<void> refreshServices() async {
    await fetchLiveServices();
  }
}
