import 'package:flutter/material.dart';
import 'package:flutter_gemini/flutter_gemini.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/get_instance.dart';
import 'package:get_storage/get_storage.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:workmanager/workmanager.dart';
import 'package:your_health_mate/utils/constants/api_constants.dart';
import 'app.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'data/repository/authentication/authentication_repository.dart';
import 'data/repository/location/location_repository.dart';
import 'data/service/remainder/notfication_service.dart';
import 'features/remainder/controllers/reminder_controller.dart';
import 'firebase_options.dart';
import 'package:timezone/data/latest.dart' as tz;


/// -- Entry Point of Flutter App
Future<void> main() async {

  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  await Hive.openBox('reminders');

  tz.initializeTimeZones(); // Initialize timezones
  const AndroidInitializationSettings initializationSettingsAndroid =
  AndroidInitializationSettings('@mipmap/ic_launcher');
  final InitializationSettings initializationSettings =
  InitializationSettings(android: initializationSettingsAndroid);

  await flutterLocalNotificationsPlugin.initialize(initializationSettings);

  Workmanager().initialize(callbackDispatcher, isInDebugMode: true);

  // Register the ReminderController
  Get.put(ReminderController());

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
void callbackDispatcher() {
  Workmanager().executeTask((task, inputData) {
    // Schedule notification here
    scheduleNotification(
      inputData!['title'],
      inputData['description'],
      inputData['date'],
      inputData['time'],
      inputData['times'],
    );
    return Future.value(true);
  });
}
