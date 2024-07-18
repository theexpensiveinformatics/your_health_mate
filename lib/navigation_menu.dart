import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:get/get.dart'; // Ensure you have imported Get package
import 'package:your_health_mate/features/health/screens/home/home.dart';
import 'package:your_health_mate/utils/constants/colors.dart';
import 'package:your_health_mate/utils/constants/sizes.dart';
import 'package:your_health_mate/utils/helper/helper_functions.dart';

class YHMNavigationMenu extends StatelessWidget {
  const YHMNavigationMenu({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(NavigationController()); // Register NavigationController for state management

    final darkMode = YHMHelperFunctions.isDarkMode(context);
    double width = 185;
    double height = 92;

    // Define the selected label color based on the dark mode
    final selectedLabelColor = darkMode ? Colors.white : YHMColors.primary;

    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.miniCenterDocked,
      floatingActionButton: Container(
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.2),
              offset: Offset(15, 30),
              blurRadius: 25,

            )
          ]
        ),
        margin: EdgeInsets.only(bottom: 30),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(30),
          child: Container(
            width: width,
            height: height,
            decoration: BoxDecoration(
              
            ),
            child: Container(
              color: Colors.white,
              child: Stack(
                children: [
                  Obx(()=>
                     Positioned(
                      left: controller.selectedIndex.value == 0 ? 0 : width/2, // Adjust positions based on selectedIndex
                      right: controller.selectedIndex.value == 0 ? width/2 : 0,
                      bottom: 0,
                      top: 0,
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(30),
                          color: YHMColors.dark,
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    top: 0,
                    bottom: 0,
                    right: 0,
                    left: 0,
                    child: Obx(
                          () => Theme(
                        data: Theme.of(context).copyWith(
                          navigationBarTheme: NavigationBarThemeData(
                            labelTextStyle: MaterialStateProperty.all<TextStyle>(
                              TextStyle(
                                fontWeight: FontWeight.bold,
                                color: selectedLabelColor,
                              ),
                            ),
                            indicatorShape: const RoundedRectangleBorder(
                              borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(10),
                                topRight: Radius.circular(10),
                                bottomLeft: Radius.circular(10),
                                bottomRight: Radius.circular(10),
                              ),
                              side: BorderSide(
                                width: 40.0,
                              ),
                            ),
                            indicatorColor: Colors.transparent,
                          ),
                        ),
                        child: Container(
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              begin: Alignment.topCenter,
                              end: Alignment.bottomCenter,
                              colors: [
                                Colors.transparent,
                                Colors.transparent,
                              ],
                            ),
                          ),
                          child: NavigationBar(
                            height: YHMSizes.bottomNavigationBarHeight,
                            surfaceTintColor: darkMode ? Colors.black26 : Colors.white,
                            selectedIndex: controller.selectedIndex.value,
                            onDestinationSelected: (index) => controller.selectedIndex.value = index,
                            backgroundColor: Colors.transparent,
                            labelBehavior: NavigationDestinationLabelBehavior.alwaysHide,
                            destinations: const [
                              NavigationDestination(
                                icon: Icon(FeatherIcons.home),
                                label: 'Home',
                                selectedIcon: Icon(FeatherIcons.home, color: YHMColors.white),
                              ),
                              NavigationDestination(
                                icon: Icon(FeatherIcons.user),
                                label: 'Profile',
                                selectedIcon: Icon(FeatherIcons.user, color: YHMColors.white),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
      body: Obx(() => controller.screens[controller.selectedIndex.value]), // Observe selectedIndex to switch between screens
    );
  }
}

class NavigationController extends GetxController {
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
  ];
}
