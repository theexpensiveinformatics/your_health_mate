import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart%20%20';
import '../../../../common/widgets/success_screen/success_screen.dart';
import '../../../../data/repository/authentication/authentication_repository.dart';
import '../../../../utils/constants/image_strings.dart';
import '../../../../utils/constants/text_strings.dart';
import '../../../../utils/popups/loaders.dart';

class VerifyEmailController extends GetxController {
  static VerifyEmailController get instance => Get.find();

  /// Send Email Whenever verify screen appears & set timer for auto redirect
  @override
  void onInit() {
    sendEmailVerification();
    setTimerForAutoRedirect();
    super.onInit();
  }

  /// send email verification link
  sendEmailVerification() async {
    try {
      await AuthenticationRepository.instance.sendEmailVerification();
      YHMLoaders.successSnackBar(
          title: 'Email sent',
          message: 'Please check your inbox & verify your email.');
    } catch (e) {
      YHMLoaders.errorSnackBar(title: 'On Snap', message: e.toString());
    }
  }

  /// Timer to automatically redirect on email verification
  setTimerForAutoRedirect() {
    Timer.periodic(const Duration(seconds: 1), (timer) async {
      await FirebaseAuth.instance.currentUser?.reload();
      final user = FirebaseAuth.instance.currentUser;
      if (user?.emailVerified ?? false) {
        timer.cancel();
        Get.off(
          () => SuccessScreen(
              image: YHMImages.emailVerfication,
              title: YHMTexts.yourAccountCreatedTitle,
              subtitle: YHMTexts.yourAccountCreatedSubTitle,
              onPressed: () =>
                  AuthenticationRepository.instance.ScreenRedirect()),
        );
      }
    });
  }

  /// Manually check if email verified
  checkEmailVerificationStatus() async {
    final currentUser = FirebaseAuth.instance.currentUser;
    if (currentUser != null && currentUser.emailVerified) {
      Get.off(SuccessScreen(
          image: YHMImages.emailVerfication,
          title: YHMTexts.yourAccountCreatedTitle,
          subtitle: YHMTexts.yourAccountCreatedSubTitle,
          onPressed: () =>
              AuthenticationRepository.instance.ScreenRedirect()));
    }
  }
}
