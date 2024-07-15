import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';

import '../../../data/repository/user/user_repository.dart';
import '../../../utils/popups/loaders.dart';
import '../../authentication/models/user_model.dart';


class UserController extends GetxController {
  static UserController get instance => Get.find();

  final imageUploading = false.obs;
  final profileLoading = false.obs;
  Rx<UserModel>user=UserModel.empty().obs;
  final userRepository = Get.put(UserRepository());

  @override
  void onInit() {
    super.onInit();
    fetchUserRecord();
  }

  /// -- Fetch role


  /// --Fetch User Record
  Future<void>fetchUserRecord()async{
    try {
      profileLoading.value = true;
      final user = await userRepository.fetchUserDetails();
      this.user(user);
    } catch (e){
      user(UserModel.empty());
    }finally{
      profileLoading.value = false;
    }
  }

  ///Save user Record from only Registration provider
  Future<void> saveUserRecord(UserCredential? userCredential) async {
    try{

    await fetchUserRecord();
    if(user.value.id.isEmpty)
      {
        if (userCredential != null) {
          //Convert name to first and last name
          final nameParts = UserModel.nameParts(
              userCredential.user!.displayName ?? ' ');
          final username = UserModel.generateUsername(
              userCredential.user!.displayName ?? ' ');

          // Get user role from the database
          final role = await userRepository.getUserRole(userCredential.user!.uid);

          // Map data
          final user = UserModel(
            lastLoginTime: DateTime.now(),
            id: userCredential.user!.uid,
            firstName: nameParts[0],
            lastName: nameParts.length > 1 ? nameParts.sublist(1).join(' ') : '',
            username: username,
            email: userCredential.user!.email ?? '',
            phoneNumber: userCredential.user!.phoneNumber ?? '',
            profilePicture: userCredential.user!.photoURL ?? '',
            role: role,

          );

          await userRepository.saveUserRecord(user);
        }
      }
      if (userCredential != null) {
        //Convert name to first and last name
        final nameParts = UserModel.nameParts(
            userCredential.user!.displayName ?? ' ');
        final username = UserModel.generateUsername(
            userCredential.user!.displayName ?? ' ');

        // Get user role from the database
        final role = await userRepository.getUserRole(userCredential.user!.uid);

        // Map data
        final user = UserModel(
          lastLoginTime: DateTime.now(),
          id: userCredential.user!.uid,
          firstName: nameParts[0],
          lastName: nameParts.length > 1 ? nameParts.sublist(1).join(' ') : '',
          username: username,
          email: userCredential.user!.email ?? '',
          phoneNumber: userCredential.user!.phoneNumber ?? '',
          profilePicture: userCredential.user!.photoURL ?? '',
          role: role,

        );

        await userRepository.saveUserRecord(user);
      }
    } catch (e) {
      YHMLoaders.warningSnackBar(title: 'Data not saved',
          message: 'Something went wrong while saving Information. You can re-save your data in your profile');
    }
  }

  //update user details
  Future<void> updateUserDetails(UserModel updatedUser) async {
    try {
      await userRepository.updateUserDetails(updatedUser);
    } catch (e) {
      YHMLoaders.warningSnackBar(title: 'Data not saved',
          message: 'Something went wrong while saving Information. You can re-save your data in your profile');
    }
  }

  /// upload user profile picture
  uploadUserProfilePicture() async {
    try {
      final image = await ImagePicker().pickImage(
          source: ImageSource.gallery,maxWidth: 512,maxHeight: 512);
      if (image != null) {
        imageUploading.value= true;

        String email = user.value.email;
        DateTime now = DateTime.now();
        String monthInString = DateFormat('MMMM').format(now); // This will give the month in string format
        String formattedTime = '${now.second}_${now.minute}_${now.hour}_${now.day}_${monthInString}_${now.year}';

        //upload image
        final imageUrl = await userRepository.uploadImage(
            'Users/Profile/ProfilePic/$email/$formattedTime', image);
        //update user image record
        Map<String, dynamic> json = {'ProfilePicture': imageUrl};
        await userRepository.updateSingleField(json);
        user.value.profilePicture = imageUrl;
        user.refresh();
        YHMLoaders.successSnackBar(title: 'Image Uploaded Successfully',
            message: 'Your profile picture has been updated successfully.');
      }
    } catch (e) {
      YHMLoaders.errorSnackBar(title: 'Oh Snap!', message: 'Something went wrong : $e');
    }finally{
      imageUploading.value= false;
    }
  }

  Future<void> uploadAdharCard(XFile selectedFile) async {
    try {

      String email = user.value.email;
      DateTime now = DateTime.now();
      String monthInString = DateFormat('MMMM').format(now); // This will give the month in string format
      String formattedTime = '${now.second}_${now.minute}_${now.hour}_${now.day}_${monthInString}_${now.year}';

      // Update Adhar Card
      final adharUrl = await userRepository.uploadFile('Users/Profile/AdharCard/$email/$formattedTime', selectedFile!);


      // Update user adhar Card url
      Map<String, dynamic> json = {'adharCard': adharUrl};
      await userRepository.updateSingleField(json);

      // Update user profile picture with adharUrl and refresh user
      user.value.profilePicture = adharUrl;
      user.refresh();
    } catch (e) {
      print('Failed to upload Adhar Card: $e');
    }
  }

  Future<void> uploadRealTimePicture(XFile selectedFile) async {
    try {

      String email = user.value.email;
      DateTime now = DateTime.now();
      String monthInString = DateFormat('MMMM').format(now); // This will give the month in string format
      String formattedTime = '${now.second}_${now.minute}_${now.hour}_${now.day}_${monthInString}_${now.year}';


      // Update realtime Picture
      final realTimePictureUrl = await userRepository.uploadFile('Users/Profile/RealTimePicture/$email/$formattedTime', selectedFile!);

      // Update user realtime Picture url
      Map<String, dynamic> json = {'realTimePicture': realTimePictureUrl};
      await userRepository.updateSingleField(json);

      // Update user profile picture with adharUrl and refresh user
      user.value.profilePicture = realTimePictureUrl;
      user.refresh();
    } catch (e) {
      print('Failed to upload Real Time Picture : $e');
    }
  }





}