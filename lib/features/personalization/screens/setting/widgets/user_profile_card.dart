import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:iconsax/iconsax.dart';

import '../../../../../common/shimmer/YHMShimmerEffect.dart';
import '../../../../../utils/constants/colors.dart';
import '../../../../../utils/constants/image_strings.dart';
import '../../../../../utils/constants/sizes.dart';
import '../../../../../utils/helper/helper_functions.dart';
import '../../../controller/user_controller.dart';
import 'circular_image.dart';

class UserProfileCard extends StatelessWidget {
  const UserProfileCard({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final controller = UserController.instance;
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            InkWell(
              onTap: () => controller.uploadUserProfilePicture(),
              child: Obx(() {
                final networkImage = controller.user.value.profilePicture;
                final image = networkImage.isNotEmpty ? networkImage : YHMImages.user;
                return  controller.imageUploading.value ? YHMShimmerEffect(width: 56, height: 56,radius: 1000,):YHMCircularImage(
                  image: image,
                  backgroundColor: YHMColors.grey,
                  padding: 0,
                  fit: BoxFit.fitHeight,
                  isNetworkImage: networkImage.isNotEmpty
                );
              }),
            ),
            const SizedBox(
              width: YHMSizes.spaceBtwItems,
            ),
            Container(
              width: YHMHelperFunctions.screenWidth() / 2.5,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Obx(
                    () => Text(
                      controller.user.value.fullName,
                      style: Theme.of(context).textTheme.labelSmall,
                      overflow: TextOverflow.ellipsis,
                      maxLines: 1,
                    ),
                  ),
                  Obx(
                    () => Text(
                      controller.user.value.email,
                      style: TextStyle(color: YHMColors.textSecondary),
                      overflow: TextOverflow.ellipsis,
                      maxLines: 1,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        IconButton(
            onPressed: () {},
            icon: Icon(Iconsax.arrow_right_3,
                size: 14,
                color: YHMHelperFunctions.isDarkMode(context)
                    ? YHMColors.light
                    : YHMColors.dark))
      ],
    );
  }
}
