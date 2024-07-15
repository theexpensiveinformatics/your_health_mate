import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import '../../../../data/repository/authentication/authentication_repository.dart';
import '../../../../data/repository/location/location_repository.dart';
import '../../../../data/repository/user/user_repository.dart';
import '../../../../utils/constants/image_strings.dart';
import '../../../../utils/helper/network_manager.dart';
import '../../../../utils/popups/full_screen_loader.dart';
import '../../../../utils/popups/loaders.dart';
import '../../models/user_model.dart';
import '../../screens/signup/verify_email.dart';

class SignupController extends GetxController {
  static SignupController get instance => Get.find();

  /// -- Variables
  final privacyPolicy = true.obs;
  final hidePassword = true.obs; // Observable for hiding // showing password
  final email = TextEditingController();
  final lastName = TextEditingController();
  final username = TextEditingController();
  final firstName = TextEditingController();
  final password = TextEditingController();
  final phoneNumber = TextEditingController();

  GlobalKey<FormState> signupFormKey = GlobalKey<FormState>(); // form key for validation

  /// -- SIGNUP
  Future<void> signup() async {
    try {
      // Start loading
      YHMFullScreenLoader.openLoadingDialog('We are processing your information...', YHMImages.docerAnimation);

      // Check internet connectivity
      final isConnected = await NetworkManager.instance.isConnected();
      if (!isConnected) {
        YHMFullScreenLoader.stopLoading();
        return;
      }

      // Form validation
      if (!signupFormKey.currentState!.validate()) {
        YHMFullScreenLoader.stopLoading();
        return;
      }

      // Privacy policy check
      if (!privacyPolicy.value) {
        YHMLoaders.warningSnackBar(
          title: 'Accept Privacy Policy',
          message: 'In order to create account, you must have to read and accept the Privacy Policy & Terms of Uses.',
        );
        YHMFullScreenLoader.stopLoading();
        return;
      }

      // Register user in Firebase Auth & save user data in Firestore
      final userCredential = await AuthenticationRepository.instance.registerWithEmailAndPassword(email.text.trim(), password.text.trim());

      // Get location details
      final locationDetails = await LocationRepository.instance.getLocationDetails();

      // Get FCM token
      String? fcmToken = await FirebaseMessaging.instance.getToken();

      // Save authenticated user data in Firestore
      final newUser = UserModel(
        lastLoginTime: DateTime.now(),
        id: userCredential.user!.uid,
        firstName: firstName.text.trim(),
        lastName: lastName.text.trim(),
        email: email.text.trim(),
        phoneNumber: phoneNumber.text.trim(),
        profilePicture: '',
        username: username.text.trim(),
        role: 'user',
        street: locationDetails['street'],
        state: locationDetails['state'],
        locality: locationDetails['city'],
        postalCodeAuto: locationDetails['postalCode'],
        admistrativeArea: locationDetails['state'],
        subAdmistrativeArea: locationDetails['district'],
        address: locationDetails['address'],
        fcmToken: fcmToken, // Include FCM token
      );

      final userRepository = Get.put(UserRepository());
      await userRepository.saveUserRecord(newUser);

      // Stop Loading
      YHMFullScreenLoader.stopLoading();

      // Show success message
      YHMLoaders.successSnackBar(title: 'Congratulations', message: "Your account has been created! Verify email to continue.");

      // Move to verify email screen
      Get.to(() => VerifyEmailScreen(email: email.text.trim()));
    } catch (e) {
      // Show some generic error to the user
      YHMFullScreenLoader.stopLoading();
      YHMLoaders.errorSnackBar(title: 'Oh Snap!', message: e.toString());
      print(e.toString());
    }
  }
}
