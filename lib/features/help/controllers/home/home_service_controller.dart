import 'package:get/get.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../../../personalization/controller/user_controller.dart';
import 'category_controller.dart';

class HomeServiceController extends GetxController {
  final userController = Get.put(UserController()); // Assuming UserController is registered correctly
  final categoryController = Get.put(CategoryController()); // Assuming CategoryController is registered correctly

  RxList<dynamic> liveServices = <dynamic>[].obs;
  RxList<dynamic> allServices = <dynamic>[].obs;
  RxBool isLoading = true.obs;

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
        servicesWithDistance.add({
          'data': data,
          'distance': distance,
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
