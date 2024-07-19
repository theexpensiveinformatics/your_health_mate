import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:get/get.dart%20%20';
import 'package:iconsax/iconsax.dart';
import '../../utils/constants/colors.dart';
import '../../utils/devices/device_utility.dart';
import '../../utils/helper/helper_functions.dart';
import '../headings/screen_heading.dart';
import '../widgets/headings/screen_heading.dart';

class YHMBlurAppBar extends StatelessWidget implements PreferredSizeWidget {
  const YHMBlurAppBar({super.key, required this.title, this.leadingIcon, required this.showBackArrow, this.leadingOnPressed, this.actions,this.leadPadding=12, this.elevation=0});
 final double elevation;
  final String title;
  final bool showBackArrow;
  final IconData? leadingIcon;
  final VoidCallback? leadingOnPressed;
  final List<Widget>? actions;
  final double leadPadding;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      shadowColor: YHMHelperFunctions.isDarkMode(context)? Colors.black :YHMColors.dark.withOpacity(0.2),
      elevation: elevation,
        scrolledUnderElevation: 10,
        leading: showBackArrow
            ? IconButton(
            onPressed: () => Get.back(), icon: Icon(Iconsax.arrow_left, ))
            : leadingIcon != null ?  IconButton(onPressed: leadingOnPressed, icon: Icon(leadingIcon)) :  Icon(Iconsax.arrow_33 ),
        backgroundColor: YHMHelperFunctions.isDarkMode(context)
            ? Colors.black26.withOpacity(0.5)
            : YHMColors.white.withOpacity(0.1),
        title: Padding(
            padding: EdgeInsets.only(left: leadPadding),
            child: YHMScreenHeading(title: title)),
        flexibleSpace: ClipRRect(
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
            child: Container(
              decoration: BoxDecoration(
                border: Border(
                  bottom: BorderSide(
                    color: YHMHelperFunctions.isDarkMode(context)
                        ? Colors.black12
                        : YHMColors.grey.withOpacity(0.5),
                  ),
                ),
                color: YHMHelperFunctions.isDarkMode(context)
                    ? YHMColors.black.withOpacity(0.5)
                    : Colors.white30,
              ),
            ),
          ),
        ),
        leadingWidth: 0,
        actions: actions,
        bottom: PreferredSize(
            preferredSize: Size.fromHeight(100), child: Container()));
  }

  @override
  // TODO: implement preferredSize
  // pass the height of the app bar
  Size get preferredSize => Size.fromHeight(YHMDeviceUtils.getAppBarHeight()+8);
}
