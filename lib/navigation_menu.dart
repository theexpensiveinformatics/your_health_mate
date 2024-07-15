import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:get/get.dart';
import 'package:your_health_mate/utils/constants/colors.dart';
import 'package:your_health_mate/utils/constants/sizes.dart';
import 'package:your_health_mate/utils/helper/helper_functions.dart';
import 'features/health/screens/home/home.dart';

class YHMNavigationMenu extends StatelessWidget {
  const YHMNavigationMenu({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(NavigationController());

    final darkMode = YHMHelperFunctions.isDarkMode(context);

    // Define the selected label color based on the dark mode
    final selectedLabelColor = darkMode ? Colors.white : YHMColors.primary;

    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.miniCenterDocked,
      floatingActionButton: ClipRRect(
        child: BackdropFilter(
          filter:
              ImageFilter.blur(sigmaX: 30, sigmaY: 30),
          child: Container(
            //border color
            decoration: BoxDecoration(
              //add border at only top side
              border: Border(
                top: BorderSide(
                  color: darkMode
                      ? YHMColors.grey.withOpacity(0.1)
                      : YHMColors.grey.withOpacity(0.5),
                ),
              ),
            ),
            child: Obx(
              () => Theme(
                data: Theme.of(context).copyWith(
                  // Customize navigation bar theme here
                  navigationBarTheme: NavigationBarThemeData(
                    labelTextStyle: MaterialStateProperty.all<TextStyle>(
                      TextStyle(
                        fontWeight: FontWeight.bold,
                        color:
                            selectedLabelColor, // Set your selected label color here
                      ),
                    ),
                    // You might want to customize other properties as well
                  ),
                ),
                child: Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                        Colors.white.withOpacity(0.8),
                        Colors.white.withOpacity(1.0),
                      ],
                    ),
                  ),
                  child: NavigationBar(
                    height: YHMSizes.bottomNavigationBarHeight,
                    // overlayColor: MaterialStateProperty.all(Colors.amberAccent), // rippple
                    surfaceTintColor: darkMode? Colors.black26 : Colors.white,
                    selectedIndex: controller.selectedIndex.value,
                    onDestinationSelected: (index) =>
                        controller.selectedIndex.value = index,
                    backgroundColor: Colors.transparent,
                    labelBehavior: NavigationDestinationLabelBehavior.onlyShowSelected,
                    indicatorShape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(10),
                            topRight: Radius.circular(10),
                            bottomLeft: Radius.circular(10),
                            bottomRight: Radius.circular(10))),
                    indicatorColor: darkMode
                        ? YHMColors.white.withOpacity(0.1)
                        : YHMColors.black.withOpacity(0.0),
                    destinations: const [
                      NavigationDestination(
                          icon: Icon(FeatherIcons.home),
                          label: 'Home',
                          selectedIcon:
                              Icon(FeatherIcons.home, color: YHMColors.primary)),
                      NavigationDestination(
                          icon: Icon(FeatherIcons.shoppingBag),
                          label: 'History',
                          selectedIcon:
                              Icon(FeatherIcons.shoppingBag, color: YHMColors.primary)),
                      NavigationDestination(
                          icon: Icon(FeatherIcons.activity),
                          label: 'Categories',
                          selectedIcon:
                              Icon(FeatherIcons.shoppingBag, color: YHMColors.primary)),

                      NavigationDestination(
                          icon: Icon(FeatherIcons.user),
                          label: 'Profile',
                          selectedIcon:
                              Icon(FeatherIcons.user, color: YHMColors.primary)),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
      body: Obx(() => controller.screens[controller.selectedIndex.value]),
    );
  }
}

// Here we can use stateful widget but using Get State management we are doing this
class NavigationController extends GetxController {
  // Here it is only integer variable wrapped with the Rx which is get x type of int
  // It's value is 0.obs which is observer variable which will be observed by widget
  final Rx<int> selectedIndex = 0.obs;


  final screens = [
    YHMHomeScreen(),
    Container(
      width: double.infinity,
      height: double.infinity,
      color: Colors.red,
    ),
    Container(
      width: double.infinity,
      height: double.infinity,
      color: Colors.blue,
    ),
    Container(
      width: double.infinity,
      height: double.infinity,
      color: Colors.orange,
    ),

  ];
}
