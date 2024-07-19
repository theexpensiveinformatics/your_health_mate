import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import '../../../../data/repository/location/location_repository.dart';
import '../../../../utils/constants/image_strings.dart';
import '../../../../utils/helper/network_manager.dart';
import '../../../../utils/popups/full_screen_loader.dart';
import '../../../../utils/popups/loaders.dart';
import '../../../personalization/controller/user_controller.dart';
import '../../models/Service/service_booking_model.dart';
import '../home/home_service_controller.dart';

class ServiceBookingController extends GetxController {
  /// -- variables
  final fireStoreInstance = FirebaseFirestore.instance;
  final isMapLoading = true.obs;
  late GoogleMapController mapController;
  LatLng? desLocation;
  final mapLat = 0.0.obs;
  final mapLng = 0.0.obs;
  final markLocation = ''.obs;
  final userArea = TextEditingController();
  final userHouseNum = TextEditingController();
  final userIntrucation = TextEditingController();
  final dateController = TextEditingController();
  final timeController = TextEditingController();
  GlobalKey<FormState> manualLocationFrom = GlobalKey<FormState>();
  final userController = UserController.instance;
  final homeServiceController = Get.find<HomeServiceController>();
  final selectedDate = DateTime.now().obs;
  final selectedTime = TimeOfDay.now().obs;

  @override
  void onInit() {
    setCurrentLocation();
    super.onInit();
  }

  Future<void> bookService(String serviceProviderID, String serviceProviderEmail, String liveServiceID) async {
    try {
      /// -- Loading Start
      YHMFullScreenLoader.openLoadingDialog(
          'We are processing your information...', YHMImages.docerAnimation);

      /// -- check internet connectivity
      final isConnected = await NetworkManager.instance.isConnected();
      if (!isConnected) {
        YHMFullScreenLoader.stopLoading();
        return;
      }

      /// -- form validation
      if (!manualLocationFrom.currentState!.validate()) {
        YHMFullScreenLoader.stopLoading();
        return;
      }

      /// -- uniqueBookingID generator
      final bookingServiceId = "${liveServiceID}${userController.user.value.id}${DateTime.now()}";

      /// -- get liveServiceStatus if(status!= Available then return to homeScreen)
      final liveServiceDoc = await FirebaseFirestore.instance.collection('LiveServices').doc(liveServiceID).get();
      if (!liveServiceDoc.exists) {
        YHMFullScreenLoader.stopLoading();
        homeServiceController.fetchLiveServices();
        Get.back();
        Get.back();
        return YHMLoaders.errorSnackBar(title: 'Error', message: 'Live service not found.');
      }

      final liveServiceStatus = liveServiceDoc['liveServiceStatus'];
      if (liveServiceStatus.toString().toLowerCase() != 'available') {
        YHMFullScreenLoader.stopLoading();
        homeServiceController.fetchLiveServices();
        Get.back();
        Get.back();
        return YHMLoaders.errorSnackBar(title: 'Service Provider not available right now', message: 'Try after sometime');
      }

      /// -- creating model
      final newBookingService = ServiceBookModel(
        bookingServiceId: bookingServiceId,
        bookingServiceStatus: 'requested',
        bookingServiceTime: Timestamp.now(),
        liveServiceId: liveServiceID,
        mapLat: mapLat.value,
        mapLng: mapLng.value,
        markerLocation: markLocation.value,
        serviceProviderEmail: serviceProviderEmail,
        serviceProviderId: serviceProviderID,
        userArea: userArea.text,
        userEmail: userController.user.value.email,
        userHouseNum: userHouseNum.text,
        userId: userController.user.value.id,
        userInstruction: userIntrucation.text,
        bookingDate: Timestamp.fromDate(selectedDate.value),
        bookingTime: TimeOfDay(
          hour: selectedTime.value.hour,
          minute: selectedTime.value.minute,
        ).format(Get.context!), // Make sure the format is appropriate
      );

      final firestore = FirebaseFirestore.instance;
      await firestore.collection('bookService').doc(bookingServiceId).set(newBookingService.toMap());

      /// Fetch FCM Token

      /// Send Notification

      YHMFullScreenLoader.stopLoading();
      homeServiceController.fetchLiveServices();

      // Navigate back to home screen
      Get.back();
      Get.back();

      YHMLoaders.successSnackBar(
          title: 'Success!', message: 'Service created successfully.');

    } catch (e) {
      YHMFullScreenLoader.stopLoading();
      YHMLoaders.errorSnackBar(title: 'Oh Snap!', message: e.toString());
      print(e.toString());
    }
  }

  void setCurrentLocation() async {
    final locationRepo = LocationRepository.instance;
    final position = await locationRepo.getCurrentLocation();
    desLocation = LatLng(position.latitude, position.longitude);
    await getAddressFromLatLng(); // Fetch the address for the current location
    isMapLoading.value = false;
  }

  Future<void> getAddressFromLatLng() async {
    try {
      List<Placemark> placemarks = await placemarkFromCoordinates(
          desLocation!.latitude, desLocation!.longitude);
      if (placemarks.isNotEmpty) {
        Placemark placemark = placemarks.first;
        String address =
            "${placemark.street != 'Unnamed Road' && placemark.street.toString().isNotEmpty ? '${placemark.street}, ' : ''}"
            "${placemark.subLocality != null && placemark.subLocality.toString().isNotEmpty ? '${placemark.subLocality}, ' : ''}"
            "${placemark.locality != null && placemark.locality.toString().isNotEmpty ? '${placemark.locality}, ' : ''}"
            "${placemark.subAdministrativeArea != null && placemark.subAdministrativeArea.toString().isNotEmpty ? '${placemark.subAdministrativeArea} ' : ''}";

        markLocation.value = address.trim().replaceAll(RegExp(r',\s*$'), '');
        markLocation.value = address;
        mapLat.value = desLocation!.latitude;
        mapLng.value = desLocation!.longitude;
      }
    } catch (e) {
      print(e);
    }
  }

  void onMapCreated(GoogleMapController controller) {
    mapController = controller;
    controller.setMapStyle(AutofillHints.location);
  }

  void locateUser() async {
    final locationRepo = LocationRepository.instance;
    final position = await locationRepo.getCurrentLocation();
    desLocation = LatLng(position.latitude, position.longitude);
    await mapController.animateCamera(
      CameraUpdate.newCameraPosition(
        CameraPosition(target: desLocation!, zoom: 20.0),
      ),
    );
    await getAddressFromLatLng();
  }
}
