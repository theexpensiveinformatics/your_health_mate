import 'package:flutter/material.dart';

import '../../../../../common/widgets/Dividers/divider_line.dart';
import '../../../../../utils/constants/colors.dart';
import '../../../../../utils/constants/sizes.dart';
import '../../../../../utils/helper/helper_functions.dart';


class SettingMenuTile extends StatelessWidget {
  const SettingMenuTile({
    super.key,
    required this.icon,
    required this.title,
    this.trailing,
    this.onTap,
  });

  final IconData icon;
  final String title;
  final Widget? trailing;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      child: Column(
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Icon(
                      icon,
                      color: YHMHelperFunctions.isDarkMode(context) ? YHMColors.light : YHMColors.dark,
                      size: 26,
                    ),
                    SizedBox(width: YHMSizes.spaceBtwItems),
                    Expanded(
                      child: Text(
                        title,
                        style: Theme.of(context).textTheme.titleSmall,
                        overflow: TextOverflow.ellipsis,
                        maxLines: 1,
                      ),
                    ),
                    SizedBox(width: YHMSizes.spaceBtwItems,)
                  ],
                ),
              ),
              Container(child: trailing),
            ],
          ),
          DividerLine(height: YHMSizes.spaceBtwSections/1.13)
        ],
      ),
    );
  }
}
