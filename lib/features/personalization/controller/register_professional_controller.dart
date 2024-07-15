import 'dart:io';

import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart' as path;
import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart%20%20';
import 'package:your_health_mate/features/personalization/controller/user_controller.dart';

import '../../../data/repository/location/location_repository.dart';
import '../../../data/repository/user/user_repository.dart';
import '../../../navigation_menu.dart';
import '../../../utils/constants/image_strings.dart';
import '../../../utils/helper/network_manager.dart';
import '../../../utils/popups/full_screen_loader.dart';
import '../../../utils/popups/loaders.dart';

class RegisterProfessionalController extends GetxController{
  static RegisterProfessionalController get instance =>Get.find();

  /// - Variables

  final userController =UserController.instance;
  final userRepository = Get.put(UserRepository());

  XFile? selectedFile;
  String? selectedFileName;
  final selectedFileIndicator = false.obs;
  XFile? capturedPhoto;
  String? capturedPhotoName;
  final capturedPhotoIndicator = false.obs;
  final firstName = TextEditingController();
  final lastName = TextEditingController();
  final email =TextEditingController();
  final phoneNumber = TextEditingController();
  final address = TextEditingController();
  final landmark = TextEditingController();
  final city = TextEditingController();
  final state = TextEditingController();
  final postalCode = TextEditingController();
  final termsAndConditions = true.obs;

  @override
  void onInit() {
    super.onInit();
    initilizeDetails();
  }



  /// Initialize Email
  Future<void>initilizeDetails()async{
    email.text = userController.user.value.email;
    firstName.text = userController.user.value.firstName;
    lastName.text = userController.user.value.lastName;
    phoneNumber.text = userController.user.value.phoneNumber;
    city.text= userController.user.value.subAdmistrativeArea!;
    state.text= userController.user.value.admistrativeArea!;
    postalCode.text= userController.user.value.postalCodeAuto!;
  }

  /// Form key
  GlobalKey<FormState> registerProfessionalFormKey =
  GlobalKey<FormState>();


  /// - Photo Picker
  Future<void> capturePhoto() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.camera);
    if (pickedFile != null) {
      capturedPhoto = XFile(pickedFile.path);
      capturedPhotoName = path.basename(pickedFile.path); // Store the file name
      capturedPhotoIndicator.value = true;
    } else {
      capturedPhotoIndicator.value = false;
    }
  }

  /// - Pick File
  Future<void> pickFile() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['pdf'],
    );

    if (result != null) {
      selectedFileIndicator.value = true;
      selectedFile = XFile(result.files.single.path!);
      selectedFileName = result.files.single.name; // Store the file name
    } else {
      selectedFileIndicator.value= false;
    }
  }

  /// - validate file
  String? validateFile() {
    if (selectedFile == null) {
      return 'Document is required';
    }
    return null;
  }

  /// - validate camera picture
  String? validateCapturedPhoto() {
    if (capturedPhoto == null) {
      return 'Captured photo is required';
    }
    return null;
  }

  ///- REGISTER AS A PROFESSIONAL
  Future<void> registerProfessional() async{
    try{

      YHMFullScreenLoader.openLoadingDialog('Uploading Data', YHMImages.docerAnimation);

      //check internet connectivity
      final isConnected = await NetworkManager.instance.isConnected();
      if (!isConnected){YHMFullScreenLoader.stopLoading(); return;}

      //form validation
      if (!registerProfessionalFormKey.currentState!.validate()) { YHMFullScreenLoader.stopLoading(); return;}

      // Adhar Card Id Verification
      if (validateFile() != null) {
        YHMLoaders.errorSnackBar(title: 'Adhar Id Required',message: 'Please select PDF of Adhar ID.');
        YHMFullScreenLoader.stopLoading(); return;
      }

      // Captured Photo Verification
      if (validateCapturedPhoto() != null) {
        YHMLoaders.errorSnackBar(title: 'Capture Photo',message: 'Please select take real time image from your camera.');
        YHMFullScreenLoader.stopLoading(); return;
      }


      //privacy policy check
      if(!termsAndConditions.value){
        YHMLoaders.warningSnackBar(title: 'Accept Privacy Policy'
            ,message:'In order to create account, you must have to read and accept the Privacy Policy & Terms of Uses.' );
      }

      //get location details
      final locationDetails = await LocationRepository.instance.getLocationDetails();

      //upload files to firestore
      userController.uploadAdharCard(selectedFile!);
      userController.uploadRealTimePicture(capturedPhoto!);

      Map<String,dynamic>updatedUser= {
        'FirstName':firstName.text.trim(),
        'LastName':lastName.text.trim(),
        'Email':email.text.trim(),
        'PhoneNumber':phoneNumber.text.trim(),
        'address':address.text.trim(),
        'street':address.text.trim(),
        'landmark':landmark.text.trim(),
        'city':city.text.trim(),
        'state':state.text.trim(),
        'postalCode':postalCode.text.trim(),
        'role':'applied_for_professional',
        'street': locationDetails['street'],
        'state': locationDetails['state'],
        'locality': locationDetails['city'],
        'postalCodeAuto': locationDetails['postalCode'],
        'admistrativeArea': locationDetails['state'],
        'LastLoginTime': DateTime.now(),
      };

      await userRepository.updateSingleField(updatedUser);

      YHMFullScreenLoader.stopLoading();


      //show success message
      YHMLoaders.successSnackBar(title: 'Applied Successfully',message: "Your request has been submitted! We will review your request and get back to you soon.");
      Get.offAll(() =>  const YHMNavigationMenu(),transition: Transition.cupertino);
    }catch (e){
      YHMFullScreenLoader.stopLoading();
      YHMLoaders.errorSnackBar(title: 'Oh Snap!', message: e.toString());
      Get.offAll(() =>  const YHMNavigationMenu(),transition: Transition.cupertino);
    }
  }





}