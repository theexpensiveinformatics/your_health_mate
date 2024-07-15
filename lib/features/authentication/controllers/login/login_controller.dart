import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import '../../../../data/repository/authentication/authentication_repository.dart';
import '../../../../data/repository/user/user_repository.dart';
import '../../../../utils/constants/image_strings.dart';
import '../../../../utils/helper/network_manager.dart';
import '../../../../utils/popups/full_screen_loader.dart';
import '../../../../utils/popups/loaders.dart';
import '../../../personalization/controller/user_controller.dart';
import '../../models/user_model.dart';

class LoginController extends GetxController{


  /// Variables
  final localStorage = GetStorage();
  final rememberMe = false.obs;
  final hidePassword = false.obs;
  final email =TextEditingController();
  final password =TextEditingController();
  GlobalKey<FormState> loginFormKey = GlobalKey<FormState>();
  final userController = Get.put(UserController());

  @override
  void onInit() {

    // var storedEmail = localStorage.read('REMEMBER_ME_EMAIL');
    // var storedPassword = localStorage.read('REMEMBER_ME_PASSWORD');
    //
    // // print('Stored Email========================: $storedEmail');
    // if(storedEmail.toString().isNotEmpty || storedPassword.toString().isNotEmpty)
    //   {
    //     // email.text=storedEmail;
    //     // password.text=storedPassword;
    //   }
    // super.onInit();
  }

  /// -- LOGIN
  Future<void> emailAndPasswordSignIn() async {
    try {

      //start loading
      YHMFullScreenLoader.openLoadingDialog(
          'Logging you in...', YHMImages.docerAnimation);


      //check internet connectivity
      final isConnected = await NetworkManager.instance.isConnected();
      if (!isConnected){YHMFullScreenLoader.stopLoading(); return;}


      //form validation
      if (!loginFormKey.currentState!.validate()) { YHMFullScreenLoader.stopLoading(); return;}


      //save data and remember me is selected
      if(!rememberMe.value){
       // localStorage.write('REMEMBER_ME_EMAIL',email.text.trim());
       // localStorage.write('REMEMBER_ME_PASSWORD', password.text.trim());
      }


      //login user in the firebase auth & save user data in firebase
      final userCredential = await AuthenticationRepository.instance.loginWithEmailAndPassword(email.text.trim(), password.text.trim());


      /// New added - for update data
      await UserRepository.instance.updateLastLoginTime(userCredential.user!.uid);

      // Stop Loading
      YHMFullScreenLoader.stopLoading();

      //Redirect
      AuthenticationRepository.instance.ScreenRedirect();


    } catch (e) {
      //show some generic error to the user
      YHMFullScreenLoader.stopLoading();
      YHMLoaders.errorSnackBar(title: 'Oh Snap!', message: e.toString());
    }
  }

  Future<void> googleSignIn() async{
    try{
      //start loading
      YHMFullScreenLoader.openLoadingDialog(
          'Logging you in...', YHMImages.docerAnimation);

      //check internet connectivity
      final isConnected = await NetworkManager.instance.isConnected();
      if (!isConnected){YHMFullScreenLoader.stopLoading(); return;}

      // Google Authentication
      final userCredentials = await AuthenticationRepository.instance.signInWithGoogle();

      //Save User Record
      await userController.saveUserRecord(userCredentials);

      //Remove Loader
      YHMFullScreenLoader.stopLoading();

      //Redirect
      AuthenticationRepository.instance.ScreenRedirect();
    }catch(e){
      YHMFullScreenLoader.stopLoading();
      YHMLoaders.errorSnackBar(title: 'Oh Snap!', message: e.toString());
    }
  }
}