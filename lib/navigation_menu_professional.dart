import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:get/get.dart';
import 'package:your_health_mate/utils/constants/colors.dart';
import 'package:your_health_mate/utils/constants/sizes.dart';

import 'package:your_health_mate/utils/helper/helper_functions.dart';

import 'features/help/screens/professional_all_services/professional_all_services.dart';
import 'features/personalization/screens/setting/setting.dart';

class YHMNavigationMenuProfessional extends StatelessWidget {
  const YHMNavigationMenuProfessional({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(ProfessionalNavigationController());
    final darkMode = YHMHelperFunctions.isDarkMode(context);

    // Define the selected label color based on the dark mode
    final selectedLabelColor = darkMode ? Colors.white : YHMColors.primary;

    return Scaffold(
      bottomNavigationBar: Obx(
            () => Theme(
          data: Theme.of(context).copyWith(
            // Customize navigation bar theme here
            navigationBarTheme: NavigationBarThemeData(
              labelTextStyle: MaterialStateProperty.all<TextStyle>(
                TextStyle(
                  fontWeight: FontWeight.bold,
                  color: selectedLabelColor, // Set your selected label color here
                ),
              ),
              // You might want to customize other properties as well
            ),
          ),
          child: NavigationBar(
            height: YHMSizes.bottomNavigationBarHeight,
            elevation: 0,
            selectedIndex: controller.selectedIndex.value,
            onDestinationSelected: (index) => controller.selectedIndex.value = index,
            backgroundColor: darkMode ? YHMColors.black : Colors.white,
            labelBehavior: NavigationDestinationLabelBehavior.onlyShowSelected,
            indicatorShape: const RoundedRectangleBorder(borderRadius: BorderRadius.only(topLeft: Radius.circular(10), topRight: Radius.circular(10), bottomLeft: Radius.circular(10), bottomRight: Radius.circular(10))),
            indicatorColor: darkMode ? YHMColors.white.withOpacity(0.1) : YHMColors.black.withOpacity(0.0),
            destinations: const [
              NavigationDestination(icon: Icon(FeatherIcons.activity), label: 'Home', selectedIcon: Icon(FeatherIcons.home, color: YHMColors.primary)),
              NavigationDestination(icon: Icon(FeatherIcons.bell), label: 'Second', selectedIcon: Icon(FeatherIcons.shoppingBag, color: YHMColors.primary)),
              NavigationDestination(icon: Icon(FeatherIcons.monitor), label: 'Third', selectedIcon: Icon(FeatherIcons.mapPin, color: YHMColors.primary)),
              NavigationDestination(icon: Icon(FeatherIcons.user), label: 'Profile', selectedIcon: Icon(FeatherIcons.user, color: YHMColors.primary)),
            ],
          ),
        ),
      ),
      body: Obx(() => controller.screens[controller.selectedIndex.value]),
    );
  }
}
// Here we can use stateful widget but using Get State management we are doing this
class ProfessionalNavigationController extends GetxController{

  // Here it is only integer variable wrapped with the Rx which is getx type of int
  // It's value is 0.obs which is observer varible which will be observed by widget
  final Rx<int> selectedIndex = 0.obs;

  final screens =[
    YHMProfessionalAllServices(),
    Container(color: Colors.blue,),
    Container(color: Colors.yellow,),
    YHMSettingScreen(),
  ];

}
