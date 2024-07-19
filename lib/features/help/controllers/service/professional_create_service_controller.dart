import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geocoding/geocoding.dart';
import '../../../../data/repository/categories/category_repository.dart';
import '../../../../data/repository/location/location_repository.dart';
import '../../../../data/repository/services/service_repository.dart';
import '../../../../utils/constants/image_strings.dart';
import '../../../../utils/helper/network_manager.dart';
import '../../../../utils/popups/full_screen_loader.dart';
import '../../../../utils/popups/loaders.dart';
import '../../../personalization/controller/user_controller.dart';
import '../../models/Service/new_creating_service_model.dart';
import '../../models/Service/service_creating_model.dart';
import '../../models/category/categories_model_tabs.dart';

class ProfessionalCreateServiceController extends GetxController {
  static ProfessionalCreateServiceController get instance =>
      Get.find<ProfessionalCreateServiceController>();

  /// -- variables
  var currentStep = 0.obs;
  final isLoading = false.obs;
  final isIconLoading = false.obs;
  final pageController = PageController();
  final markLocation = TextEditingController();
  final userController = UserController.instance;

  ///-- New variables for detailed location information
  final mapStreet = ''.obs;
  final mapLat = 0.0.obs;
  final mapLng = 0.0.obs;
  final mapLocality = ''.obs;
  final mapAdministrativeArea = ''.obs;
  final mapPostalCode = ''.obs;
  final mapCountry = ''.obs;
  String buttonValue = 'Next';

  /// -- categories
  RxList<CategoryModelTabs> allCategories = <CategoryModelTabs>[].obs;
  RxList<CategoryModelTabs> featuredCategories = <CategoryModelTabs>[].obs;
  final RxString categoryName = RxString('0');
  final RxString categoryId = RxString('0');
  final _categoryRepository = CategoryRepository.instance;
  var categoryIndex = 0.obs;

  /// -- services
  final _serviceRepository = Get.put(ServiceRepository());
  final RxString serviceName = RxString('0');
  var serviceIndex = 0.obs;
  RxList<ServiceCreatingModel> allServices = <ServiceCreatingModel>[].obs;
  RxList<ServiceCreatingModel> servicesForSelectedCategory =
      <ServiceCreatingModel>[].obs;

  /// -- warranty
  RxList<String> selectedServiceWarranty = <String>[].obs;
  final RxString warrantyName = RxString('0');
  var warrantyIndex = 0.obs;
  final RxString serviceId = RxString('0');

  /// -- cost
  final initialCost = TextEditingController();
  final description = TextEditingController();

  /// -- for manually taking information
  final mArea = TextEditingController();
  final mCity = TextEditingController();
  final mState = TextEditingController();
  final mPincode = TextEditingController();
  GlobalKey<FormState> manualLocationForm =
  GlobalKey<FormState>(); //

  /// -- for map
  late GoogleMapController mapController;
  LatLng? desLocation;
  final isMapLoading = true.obs;

  @override
  void onInit() {
    categoryIndex.value = -1;
    serviceIndex.value = -1;
    warrantyIndex.value = -1;
    fetchCategories();
    setCurrentLocation();
    servicesForSelectedCategory();
    super.onInit();
  }


  void setCurrentLocation() async {
    final locationRepo = LocationRepository.instance;
    final position = await locationRepo.getCurrentLocation();
    desLocation = LatLng(position.latitude, position.longitude);
    await getAddressFromLatLng(); // Fetch the address for the current location
    isMapLoading.value = false;
  }

  void onMapCreated(GoogleMapController controller) {
    mapController = controller;
    controller.setMapStyle(AutofillHints.location);
  }

  void updateServiceIndex(int index) {
    serviceIndex.value = index;
  }

  void updateIndex(int index) {
    categoryIndex.value = index;
  }

  Future<void> fetchCategories() async {
    try {
      isLoading.value = true;
      isIconLoading.value = true;
      final categories = await _categoryRepository.getAllCategories();
      allCategories.assignAll(categories);
      allCategories.sort((a, b) => a.id.compareTo(b.id));
      featuredCategories.assignAll(
          allCategories.where((category) => category.isFeatured).toList());
    } catch (e) {
      print(e.toString());
      YHMLoaders.errorSnackBar(
          title: 'Something went wrong', message: e.toString());
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> fetchServicesForCategory() async {
    try {
      isLoading.value = true;
      isIconLoading.value = true;
      final services =
      await _serviceRepository.getServicesForCategory(categoryName.value);
      servicesForSelectedCategory.assignAll(services);
    } catch (e) {
      print(e.toString());
    } finally {
      isLoading.value = false;
      isIconLoading.value = false;
    }
  }

  Future<void> getAddressFromLatLng() async {
    try {
      List<Placemark> placemarks = await placemarkFromCoordinates(
          desLocation!.latitude, desLocation!.longitude);
      if (placemarks.isNotEmpty) {
        Placemark placemark = placemarks.first;
        String address =
            "${placemark.street != 'Unnamed Road' && placemark.street.toString().isNotEmpty ? '${placemark.street}, ' : ''}"
            "${placemark.locality != null && placemark.locality.toString().isNotEmpty ? '${placemark.locality}, ' : ''}"
            "${placemark.administrativeArea != null && placemark.administrativeArea.toString().isNotEmpty ? '${placemark.administrativeArea}, ' : ''}"
            "${placemark.postalCode != null && placemark.postalCode.toString().isNotEmpty ? '${placemark.postalCode}, ' : ''}"
            "${placemark.country != null && placemark.country.toString().isNotEmpty ? placemark.country : ''}";

        markLocation.text = address.trim().replaceAll(RegExp(r',\s*$'), '');
        markLocation.text = address;

        // Set detailed location information
        mapStreet.value = placemark.street ?? '';
        mapLat.value = desLocation!.latitude;
        mapLng.value = desLocation!.longitude;
        mapLocality.value = placemark.locality ?? '';
        mapAdministrativeArea.value = placemark.administrativeArea ?? '';
        mapPostalCode.value = placemark.postalCode ?? '';
        mapCountry.value = placemark.country ?? '';
      }
    } catch (e) {
      print(e);
    }
  }

  Future<void> addService() async {
    try {
      YHMFullScreenLoader.openLoadingDialog(
          'We are processing your information...', YHMImages.docerAnimation);

      // Check internet connectivity
      final isConnected = await NetworkManager.instance.isConnected();
      if (!isConnected) {
        YHMFullScreenLoader.stopLoading();
        return;
      }

      String? imageUrl = await ServiceRepository.instance.getImageUrl(
          categoryId.string);

      final liveServiceID = "${UserController.instance.user.value.email}${DateTime.now().microsecondsSinceEpoch}"; // Use the same ID for liveServiceID

      final service = NewServiceCreateModel(
        profilePicture: userController.user.value.profilePicture,
        serviceProviderName: userController.user.value.fullName,
        serviceProviderEmail: userController.user.value.email,
        serviceProviderNumber: userController.user.value.phoneNumber,
        serviceProviderID: userController.user.value.id,
        serviceID: serviceId.value,
        liveServiceCategory: categoryName.value,
        liveServiceInitialCost: initialCost.text,
        liveServiceDescription: description.text,
        liveServiceImg: imageUrl!,
        liveServiceID: liveServiceID,
        mapLat: mapLat.value,
        mapLng: mapLng.value,
        mapStreet: mapStreet.value,
        mapLocality: mapLocality.value,
        mapAdministrativeArea: mapAdministrativeArea.value,
        mapPostalCode: mapPostalCode.value,
        mapCountry: mapCountry.value,
        mArea: mArea.text,
        mCity: mCity.text,
        mState: mState.text,
        mPostalCode: mPincode.text,
      );

      final firestore = FirebaseFirestore.instance;
      await firestore
          .collection('LiveServices')
          .doc(liveServiceID)
          .set(service.toJson());

      YHMFullScreenLoader.stopLoading();
      YHMLoaders.successSnackBar(
          title: 'Success!', message: 'Service created successfully.');

      // get screen to home
      Get.offAllNamed('/YHMProfessionalServiceCreate');

    } catch (e) {
      YHMFullScreenLoader.stopLoading();
      YHMLoaders.errorSnackBar(
          title: 'Oh no!',
          message: 'Something went wrong. Please try again later.');
      print('=====================$e');
    }
  }

  void nextStep() {
    if (currentStep.value == 0) {
      if (categoryName.value != '0') {
        currentStep.value++;
        fetchServicesForCategory();
        pageController.jumpToPage(currentStep.value);
      } else {
        YHMLoaders.errorSnackBar(
            title: 'Please select a category',
            message: 'Please select a category to proceed');
      }
    } else if (currentStep.value == 1) {
      if (markLocation.text.isNotEmpty &&
          mapLat.value != 0.0 &&
          mapLng.value != 0.0 &&
          mapPostalCode.isNotEmpty &&
          mapCountry.isNotEmpty) {
        currentStep.value++;
        pageController.jumpToPage(currentStep.value);
        buttonValue = 'Ready to Help';
        mPincode.text = mapPostalCode.value;
      } else {
        YHMLoaders.errorSnackBar(
            title: 'Select right location',
            message: 'Please ensure selected location is right');
      }
    } else if (currentStep.value == 2) {
      if (manualLocationForm.currentState!.validate()) {
        currentStep.value++;
        pageController.jumpToPage(currentStep.value);
        buttonValue = 'Ready to Help';
        mPincode.text = mapPostalCode.value;
      } else {
        YHMLoaders.errorSnackBar(
            title: 'Please fill all details',
            message: 'It is necessary for location accuracy.');
      }
    } else if (currentStep.value == 3) {
      if (initialCost.text.isNotEmpty) {
        addService();
      } else {
        YHMLoaders.errorSnackBar(
          title: 'Please Enter Estimated Charges',
        );
      }
    }
  }

  void previousStep() {
    if (currentStep.value >= 0) {
      if (currentStep.value == 0) {
        Get.back();
      } else {
        currentStep.value--;
        pageController.jumpToPage(currentStep.value);
        if (currentStep.value == 1) {
          serviceName.value = '0';
          serviceId.value = '0';
          serviceIndex.value = -1;
        } else if (currentStep.value == 2) {
          warrantyName.value = '0';
          warrantyIndex.value = -1;
        }
      }
    }
  }
}

