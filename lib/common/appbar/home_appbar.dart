import 'dart:ui';
import 'package:flutter/material.dart';
import '../../utils/constants/colors.dart';
import '../../utils/helper/helper_functions.dart';



class YHMHomeAppBar extends StatelessWidget implements PreferredSizeWidget {
  const YHMHomeAppBar({super.key, required this.widget});

  final Widget widget;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      toolbarHeight: 168,
        backgroundColor: YHMHelperFunctions.isDarkMode(context)
            ? Colors.black26.withOpacity(0.5)
            : YHMColors.white.withOpacity(0.78),
        shadowColor: YHMHelperFunctions.isDarkMode(context)? Colors.black :YHMColors.dark.withOpacity(0.2),
        elevation: 0,
        scrolledUnderElevation: 10,
        title: widget,
        flexibleSpace: ClipRRect(
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 30, sigmaY:30),
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

        bottom: PreferredSize(
            preferredSize: Size.fromHeight(100), child: Container()));
  }

  @override
  Size get preferredSize => Size.fromHeight(168);
}
