import 'package:flutter/material.dart';
import 'package:flutter_gemini/flutter_gemini.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/get_instance.dart';
import 'package:get_storage/get_storage.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:your_health_mate/utils/constants/api_constants.dart';
import 'app.dart';
import 'data/repository/authentication/authentication_repository.dart';
import 'data/repository/location/location_repository.dart';
import 'firebase_options.dart';


/// -- Entry Point of Flutter App
Future<void> main() async {

  /// -- Widget Binding
  final WidgetsBinding widgetsBinding =
  WidgetsFlutterBinding.ensureInitialized();

  /// -- GetX Local Storage
  await GetStorage.init();

  /// -- Await Splash until other item load
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);

  Gemini.init(
    apiKey: GEMINI_API_KEY,
  );

  /// -- Initialize Firebase & Auth Repository
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  ).then(
        (FirebaseApp value) {
      Get.put(AuthenticationRepository());
      Get.put(LocationRepository());
    },
  );

  runApp(const MyApp());
}
