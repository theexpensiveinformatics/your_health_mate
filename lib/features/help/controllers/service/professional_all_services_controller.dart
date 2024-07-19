import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import '../../../../utils/popups/loaders.dart';
import '../../../personalization/controller/user_controller.dart';

class ProfessionalAllServicesController extends GetxController {
  final userController = Get.find<UserController>();
  var services = [].obs;
  var isLoading = true.obs;
  var isOffline = true.obs; // Determine if the current status is offline

  @override
  void onInit() {
    super.onInit();
    fetchServices();
  }

  void fetchServices() {
    isLoading.value = true;
    final serviceProviderId = userController.user.value.id;
    FirebaseFirestore.instance
        .collection('LiveServices')
        .where('serviceProviderID', isEqualTo: serviceProviderId)
        .snapshots()
        .listen((querySnapshot) async {
      final fetchedServices = querySnapshot.docs.map((doc) => doc.data()).toList();
      services.value = await Future.wait(fetchedServices.map((service) async {
        final serviceId = service['liveServiceID'];
        final requestCount = await _getRequestCount(serviceId);
        service['requestCount'] = requestCount;
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

  Future<int> _getRequestCount(String liveServiceId) async {
    final querySnapshot = await FirebaseFirestore.instance
        .collection('bookService')
        .where('liveServiceId', isEqualTo: liveServiceId)
        .where('bookingServiceStatus', isEqualTo: 'requested')
        .get();

    return querySnapshot.docs.length;
  }

  void listenToServiceRequests() {
    FirebaseFirestore.instance
        .collection('bookService')
        .snapshots()
        .listen((querySnapshot) {
      for (var change in querySnapshot.docChanges) {
        if (change.type == DocumentChangeType.added ||
            change.type == DocumentChangeType.modified ||
            change.type == DocumentChangeType.removed) {
          updateServiceRequestCount(change.doc['liveServiceId']);
        }
      }
    });
  }

  void updateServiceRequestCount(String liveServiceId) async {
    final requestCount = await _getRequestCount(liveServiceId);
    final index = services.indexWhere((service) => service['liveServiceID'] == liveServiceId);
    if (index != -1) {
      services[index]['requestCount'] = requestCount;
      services.refresh();
    }
  }

  Future<void> updateAllServicesStatus(String newStatus) async {
    try {
      isLoading.value = true;
      final serviceProviderId = userController.user.value.id;
      final querySnapshot = await FirebaseFirestore.instance
          .collection('LiveServices')
          .where('serviceProviderID', isEqualTo: serviceProviderId)
          .get();

      final batch = FirebaseFirestore.instance.batch();

      for (var doc in querySnapshot.docs) {
        batch.update(doc.reference, {'liveServiceStatus': newStatus});
      }

      await batch.commit();

      // Update the local list and status
      services.forEach((service) {
        service['liveServiceStatus'] = newStatus;
      });
      services.refresh();
      isOffline.value = newStatus.toLowerCase() == 'offline';
    } catch (e) {
      print('Error updating service status: $e');
      YHMLoaders.errorSnackBar(title: 'Oh Snap!', message: e.toString());
    } finally {
      isLoading.value = false;
    }
  }
}
