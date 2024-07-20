import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:your_health_mate/features/help/controllers/service/professional_all_services_controller.dart';
import 'package:your_health_mate/utils/popups/loaders.dart';
import 'package:your_health_mate/features/personalization/controller/user_controller.dart';

class ProfessionalServiceManagementController extends GetxController {
  final userController = Get.find<UserController>();
  var services = [].obs;
  var isLoading = true.obs;
  var isOffline = true.obs; // Determine if the current status is offline
  final profesionalAllServiceController = Get.find<ProfessionalAllServicesController>();
  var selectedStatus = 'accepted'.toLowerCase().obs; // Default filter

  @override
  void onInit() {
    super.onInit();
    fetchServices();
  }

  void fetchServices() {
    isLoading.value = true;
    final serviceProviderId = userController.user.value.id;
    FirebaseFirestore.instance
        .collection('bookService')
        .where('liveServiceId', isEqualTo: profesionalAllServiceController.selectedLiveServiceId.value)
        .snapshots()
        .listen((querySnapshot) async {
      final fetchedServices = querySnapshot.docs.map((doc) => doc.data()).toList();
      services.value = await Future.wait(fetchedServices.map((service) async {
        final serviceId = service['userEmail'];
        return service;
      }).toList());

      // Check if all services are offline
      isOffline.value = fetchedServices.every((service) => service['liveServiceStatus'].toString().toLowerCase() == 'offline');
      isLoading.value = false;
    }, onError: (e) {
      print('Error fetching services: $e');
      YHMLoaders.errorSnackBar(title: 'Oh Snap!', message: e.toString());
      isLoading.value = false;
    });
  }

  void updateFilter(String status) {
    selectedStatus.value = status;
    fetchFilteredServices(status);
  }

  void fetchFilteredServices(String status) {
    isLoading.value = true;
    final serviceProviderId = userController.user.value.id;
    FirebaseFirestore.instance
        .collection('bookService')
        .where('liveServiceId', isEqualTo: profesionalAllServiceController.selectedLiveServiceId.value)
        .where('bookingServiceStatus', isEqualTo: status)
        .snapshots()
        .listen((querySnapshot) async {
      final fetchedServices = querySnapshot.docs.map((doc) => doc.data()).toList();
      services.value = await Future.wait(fetchedServices.map((service) async {
        final serviceId = service['userEmail'];
        return service;
      }).toList());

      // Check if all services are offline
      isOffline.value = fetchedServices.every((service) => service['liveServiceStatus'].toString().toLowerCase() == 'offline');
      isLoading.value = false;
    }, onError: (e) {
      print('Error fetching services: $e');
      YHMLoaders.errorSnackBar(title: 'Oh Snap!', message: e.toString());
      isLoading.value = false;
    });
  }

  void updateServiceStatus(String docId, String status) async {
    try {
      await FirebaseFirestore.instance
          .collection('bookService')
          .doc(docId)
          .update({'bookingServiceStatus': status});
      YHMLoaders.successSnackBar(title: 'Success', message: 'Service status updated to $status.');
      fetchServices();
    } catch (e) {
      YHMLoaders.errorSnackBar(title: 'Error', message: e.toString());
    }
  }

  void updateServiceTimeAndStatus(String docId, String status, String time) async {
    try {
      await FirebaseFirestore.instance
          .collection('bookService')
          .doc(docId)
          .update({
        'bookingServiceStatus': status,
        'bookingTime': time,
      });

      YHMLoaders.successSnackBar(title: 'Success', message: 'Service status updated to $status and time set to $time.');
      fetchServices();
    } catch (e) {
      YHMLoaders.errorSnackBar(title: 'Error', message: e.toString());
    }
  }
}
