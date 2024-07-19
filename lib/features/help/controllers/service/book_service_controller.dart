import 'package:flutter/material.dart';
import 'package:get/get.dart%20%20';

import '../../../../data/repository/services/service_repository.dart';
import '../../../../data/repository/user/user_repository.dart';
import '../../../../navigation_menu.dart';
import '../../../../utils/constants/image_strings.dart';
import '../../../../utils/popups/full_screen_loader.dart';
import '../../../../utils/popups/loaders.dart';
import '../../../personalization/controller/user_controller.dart';
import '../../models/Service/book_service_model.dart';

class BookServiceController extends GetxController {
  static BookServiceController get instance => Get.find();

  final serviceRepo = Get.put(ServiceRepository());
  final address = TextEditingController();
  final date = DateTime.now();
  final bookServiceFormKey = GlobalKey<FormState>();
  final userName = UserController.instance.user.value.fullName;
  final userPhoneNumber = UserController.instance.user.value.phoneNumber;
  final userEmail = UserController.instance.user.value.id;
  final RxString liveServiceId = RxString('0');
  final RxString warranty = RxString('0');
  final RxString category = RxString('0');
  final RxString serviceName = RxString('0');
  final RxString cost = RxString('0');
  final RxString serviceId = RxString('0');
  final RxString professionalId = RxString('0');

  Future<void> bookService() async {
    try {
      YHMFullScreenLoader.openLoadingDialog(
          'Booking Service...', YHMImages.docerAnimation);


      //form validation
      if (!bookServiceFormKey.currentState!.validate()) { YHMFullScreenLoader.stopLoading(); return;}

      //upload data to firestore at collection of service
      final newBookService = BookServiceModel(
        warranty: warranty.value,
        address: address.text,
        liveServiceId: liveServiceId.value,
        userEmail: userEmail,
        userPhone: userPhoneNumber,
        cost: cost.value,
        additionalCost: '0',
        category: category.value,
        professionalId: professionalId.value,
        serviceId: serviceId.value,
        serviceName:serviceName.value ,
        postalCode: UserController.instance.user.value.postalCode,
        userName: UserController.instance.user.value.fullName,
        bookingStatus: 'Pending',
        bookingTime: DateTime.now().toString(),
      );



      //upload data to firestore at collection of service
      print(liveServiceId.value);
      await ServiceRepository.instance.bookServices(newBookService, liveServiceId.value);

      // add userController signle field -> bookingStatus ,bookingId , booking
      Map<String,dynamic>updatedUser= {
        'bookingStatus': 'pending',
        'bookingServiceName': serviceName.value,
        'bookingServiceCost': cost.value,
        'bookingServiceCategory': category.value,
        'bookingServiceProfessionalId': professionalId.value,
        'bookingServiceWarranty': warranty.value,
        'bookingServiceAddress': address.text,
        'bookingServiceAdditionalCost': '0',
        'bookingTime': DateTime.now().toString(),

      };

      await UserRepository.instance.updateSingleField(updatedUser);

      YHMLoaders.successSnackBar(title: 'Service Booked', message: 'Your service has been booked successfully');
      YHMFullScreenLoader.stopLoading();
      // back to home
      Get.offAll(YHMNavigationMenu());

    } catch (e) {
      YHMFullScreenLoader.stopLoading();
      YHMLoaders.errorSnackBar(title: 'Oh no!', message: 'Something went wrong. Please try again.');
      print('===================================$e');
    }
  }
}
