import 'package:flutter/material.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:your_health_mate/utils/constants/colors.dart';
import 'package:your_health_mate/utils/theme/theme.dart';
import 'bindings/general_bindings.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
        initialBinding: GeneralBindings(),
        debugShowCheckedModeBanner: false,
        theme: YHMAppTheme.lightTheme,

        /// show loader or circular indicator meanwhile Authentication Repository is deciding to show relevant screen.
        home: const Scaffold(
          backgroundColor: YHMColors.primary,
          body: Center(
            child: CircularProgressIndicator(
              color: Colors.white,
            ),
          ),
        ));
  }
}
