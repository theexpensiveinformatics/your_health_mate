import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart%20%20';

import '../../../../data/repository/location/location_repository.dart';
import '../../../../data/repository/services/service_repository.dart';
import '../../../../navigation_menu.dart';
import '../../../../utils/constants/image_strings.dart';
import '../../../../utils/helper/network_manager.dart';
import '../../../../utils/popups/full_screen_loader.dart';
import '../../../../utils/popups/loaders.dart';
import '../../../personalization/controller/user_controller.dart';
import '../../models/Service/service_model.dart';

class CreateServiceController extends GetxController{
  static CreateServiceController get instance => Get.find();

  /// -- Variables
  final termsAndConditions = true.obs;
  final RxString titleCategory = RxString('categories');
  final RxString category = RxString('0');
  final RxString serviceId = RxString('0');
  final RxString warranty = RxString('0');
  final charges = TextEditingController();
  final description = TextEditingController();
  final serviceFormKey = GlobalKey<FormState>();
  final userController = UserController.instance;



  /// -- Start Services
  Future<void> startService()async{
    try{
      YHMFullScreenLoader.openLoadingDialog(
          'We are processing your information...', YHMImages.docerAnimation);

      //check internet connectivity
      final isConnected = await NetworkManager.instance.isConnected();
      if (!isConnected){YHMFullScreenLoader.stopLoading(); return;}

      //form validation
      if (!serviceFormKey.currentState!.validate()) { YHMFullScreenLoader.stopLoading(); return;}


      //privacy policy check
      if(!termsAndConditions.value){
        YHMLoaders.warningSnackBar(title: 'Accept Privacy Policy'
            ,message:'In order to create account, you must have to read and accept the Privacy Policy & Terms of Uses.' );
      }



      final locationDetails = await LocationRepository.instance.getCurrentLocation();

      // Create a GeoPoint using the latitude and longitude
      final GeoPoint geoPoint = GeoPoint(locationDetails.latitude, locationDetails.longitude);



      final serviceRepository = Get.put(ServiceRepository());
      //get service name

      //get imageUrl
      String? imageUrl = await ServiceRepository.instance.getImageUrl(category.value);

      final newService = ServiceModel(
        imageUrl: imageUrl,

        userId: userController.user.value.email,
        category: category.value,
        serviceId: serviceId.value,
        subAdmistrativeArea: userController.user.value.subAdmistrativeArea,
        admistrativeArea: userController.user.value.admistrativeArea,
        street: userController.user.value.street,
        additionalCost: 0,
        cost: charges.text ,
        description: description.text,
        serviceStatus: 'available',
        liveStatus: 'active',
        city: userController.user.value.city,
        postalCode: userController.user.value.postalCodeAuto,
        locality: userController.user.value.locality,
        location:geoPoint,
        warranty: warranty.value

      );


      await serviceRepository.createServices(newService,category.value,serviceId.value,warranty.value);

      // Stop Loading
      YHMFullScreenLoader.stopLoading();
      //show success message
      YHMLoaders.successSnackBar(title: 'Congratulations',message: "Service Visible to the users.");

      
      Get.offAll(YHMNavigationMenu());


    } catch (e)
    {
      YHMFullScreenLoader.stopLoading();
      YHMLoaders.errorSnackBar(title: 'Oh no!', message: 'Something went wrong. Please try again.');
      print(e);
    }
  }

}