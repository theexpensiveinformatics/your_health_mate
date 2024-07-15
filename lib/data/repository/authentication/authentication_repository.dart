import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:get/get.dart%20%20';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:get_storage/get_storage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:your_health_mate/features/health/screens/home/home.dart';
import 'package:your_health_mate/navigation_menu.dart';

import '../../../features/authentication/screens/login/login.dart';
import '../../../features/authentication/screens/onboarding/onboarding.dart';
import '../../../features/authentication/screens/signup/verify_email.dart';
import '../../../utils/exceptions/firebase_auth_exceptions.dart';
import '../../../utils/exceptions/firebase_exceptions.dart';
import '../../../utils/exceptions/format_exceptions.dart';
import '../../../utils/exceptions/platform_exceptions.dart';

class AuthenticationRepository extends GetxController {
  static AuthenticationRepository get instance => Get.find();

  /// -- Variables
  final deviceStorage = GetStorage();
  final _auth = FirebaseAuth.instance;

  /// Get Authenticated User Data
  User? get authUser => _auth.currentUser;



  /// -- called form main.dart on app Launch
  @override
  void onReady() {
    // Remove the native splash Screen
    FlutterNativeSplash.remove();
    // Redirect to appropriate screen
    ScreenRedirect();
  }

  /// -- Function to show relevant screen
  void ScreenRedirect() async {
    final user = _auth.currentUser;
    if (user != null) {
      if (user.emailVerified) {

        Get.offAll(() =>  const YHMNavigationMenu(),transition: Transition.cupertino);
      } else {
        Get.offAll(() => VerifyEmailScreen(
          email: _auth.currentUser?.email,
        ),transition: Transition.cupertino);
      }
    } else {
      //Local Storage
      deviceStorage.writeIfNull('IsFirstTime', true);
      //Check if it's first time launching app
      deviceStorage.read('IsFirstTime') != true
          ? Get.offAll(() => LoginScreen(),transition: Transition.cupertino) // if not first time -> Login Screen
          : Get.offAll(
              () => OnBoardingScreen(),transition: Transition.cupertino); // if first time -> OnBoarding Screen
    }
  }

  /* --------------------- Email & Password Sign-In ---------------*/

  ///[EmailAuthentication] -SignIn
  Future<UserCredential> loginWithEmailAndPassword(
      String email, String password) async {
    try {
      return await _auth.signInWithEmailAndPassword(
          email: email, password: password);
    } on YHMFirebaseAuthException catch (e) {
      throw YHMFirebaseAuthException(e.code).message;
    } on FirebaseException catch (e) {
      throw YHMFirebaseException(e.code).message;
    } on FormatException catch (_) {
      throw const YHMFormateException();
    } on PlatformException catch (e) {
      throw YHMPlatformException(e.code).message;
    } catch (e) {
      throw 'Something went wrong. Please try again';
    }
  }

  ///[EmailAuthentication] -REGISTER
  Future<UserCredential> registerWithEmailAndPassword(
      String email, String password) async {
    try {
      return await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
    } on YHMFirebaseAuthException catch (e) {
      throw YHMFirebaseAuthException(e.code).message;
    } on FirebaseException catch (e) {
      throw YHMFirebaseException(e.code).message;
    } on FormatException catch (_) {
      throw const YHMFormateException();
    } on PlatformException catch (e) {
      throw YHMPlatformException(e.code).message;
    } catch (e) {
      throw 'Something went wrong. Please try again';
    }
  }

  ///[EmailVerification] - MAIL VERIFICATION
  Future<void> sendEmailVerification() async {
    try {
      await _auth.currentUser?.sendEmailVerification();
    } on YHMFirebaseAuthException catch (e) {
      throw YHMFirebaseAuthException(e.code).message;
    } on FirebaseException catch (e) {
      throw YHMFirebaseException(e.code).message;
    } on FormatException catch (_) {
      throw const YHMFormateException();
    } on PlatformException catch (e) {
      throw YHMPlatformException(e.code).message;
    } catch (e) {
      throw 'Something went wrong. Please try again';
    }
  }

  ///[EmailVerification] -ReAuthentication User

  ///[EmailAuthentication] - FORGET PASSWORD
  Future<void> sendPasswordResetEmail(String email) async {
    try {
      await _auth.sendPasswordResetEmail(email: email);
    } on YHMFirebaseAuthException catch (e) {
      throw YHMFirebaseAuthException(e.code).message;
    } on FirebaseException catch (e) {
      throw YHMFirebaseException(e.code).message;
    } on FormatException catch (_) {
      throw const YHMFormateException();
    } on PlatformException catch (e) {
      throw YHMPlatformException(e.code).message;
    } catch (e) {
      throw 'Something went wrong. Please try again';
    }
  }

  /* --------------------- Federated identity & Social sign-in ---------------*/

  ///[GoogleAuthentication] - GOOGLE

  Future<UserCredential> signInWithGoogle() async {
    try {
      //Triger the Google Sign In
      final GoogleSignInAccount? userAccount = await GoogleSignIn().signIn();
      //obtain the auth details from request
      final GoogleSignInAuthentication? googleSignInAuth =
      await userAccount?.authentication;
      //Create a new credential
      final credentials = GoogleAuthProvider.credential(
        accessToken: googleSignInAuth?.accessToken,
        idToken: googleSignInAuth?.idToken,
      );
      //Once signed in, return the UserCredential
      return await _auth.signInWithCredential(credentials);
    } on YHMFirebaseAuthException catch (e) {
      throw YHMFirebaseAuthException(e.code).message;
    } on FirebaseException catch (e) {
      throw YHMFirebaseException(e.code).message;
    } on FormatException catch (_) {
      throw const YHMFormateException();
    } on PlatformException catch (e) {
      throw YHMPlatformException(e.code).message;
    } catch (e) {
      throw 'Something went wrong. Please try again';
    }
  }

  ///[FacebookAuthentication] - FACEBOOK

  /* --------------------- ./end Federated identity & social sign-in ---------------*/

  ///[LogOutUser] - valid for any authentication.
  Future<void> logout() async {
    try {
      await FirebaseAuth.instance.signOut();
      Get.offAll(() => const LoginScreen());
    } on YHMFirebaseAuthException catch (e) {
      throw YHMFirebaseAuthException(e.code).message;
    } on FirebaseException catch (e) {
      throw YHMFirebaseException(e.code).message;
    } on FormatException catch (_) {
      throw const YHMFormateException();
    } on PlatformException catch (e) {
      throw YHMPlatformException(e.code).message;
    } catch (e) {
      throw 'Something went wrong. Please try again';
    }
  }

  ///[DeleteUser] - Remove user Auth and FireStore Account.
  Future<void> signOut() async {
    try {
      await _auth.signOut();
      Get.offAll(const  LoginScreen());
    } catch (e) {
      // Handle sign out errors
      print("Error signing out: $e");
    }
  }

  ///Phone Number Validation
  Future<void> verifyPhoneNumber(String phoneNumber, Function verificationCompleted, Function verificationFailed, Function codeSent, Function codeAutoRetrievalTimeout) async {
    await FirebaseAuth.instance.verifyPhoneNumber(
      phoneNumber: phoneNumber,
      verificationCompleted: (PhoneAuthCredential credential) async {
        verificationCompleted(credential);
      },
      verificationFailed: (FirebaseAuthException e) {
        verificationFailed(e.message);
      },
      codeSent: (String verificationId, int? resendToken) {
        codeSent(verificationId, resendToken);
      },
      codeAutoRetrievalTimeout: (String verificationId) {
        codeAutoRetrievalTimeout(verificationId);
      },
    );
  }

  Future<void> handleOTPVerification() async {
    String phoneNumber = ""; // replace with the phone number to verify
    String otp = ""; // replace with the OTP entered by the user

    await AuthenticationRepository.instance.verifyPhoneNumber(
      phoneNumber,
          (PhoneAuthCredential credential) async {
        // OTP verification successful
        print("Success");
      },
          (String errorMessage) {
        // OTP verification failed
        print("OTP verification failed: $errorMessage");
      },
          (String verificationId, int? resendToken) {
        // OTP sent
        FirebaseAuth.instance.signInWithCredential(PhoneAuthProvider.credential(verificationId: verificationId, smsCode: otp));
      },
          (String verificationId) {
        // Auto retrieval timeout
        print("Auto retrieval timeout");
      },
    );
  }
}