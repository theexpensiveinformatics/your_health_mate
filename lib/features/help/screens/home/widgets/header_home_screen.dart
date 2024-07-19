import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart%20%20';
import 'package:get/get_core/src/get_main.dart';

import 'package:iconsax/iconsax.dart';

import '../../../../../common/shimmer/YHMShimmerEffect.dart';
import '../../../../../utils/constants/colors.dart';
import '../../../../../utils/constants/sizes.dart';
import '../../../../personalization/controller/user_controller.dart';

class header_home_screen extends StatelessWidget {
  const header_home_screen({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(UserController());
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Obx(()=>
    controller.profileLoading == true ?
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            YHMShimmerEffect(width: 50, height: 15),
            SizedBox(
              height: 5,
            ),
            YHMShimmerEffect(width: 150, height: 15)
          ],
        )

           : Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('${controller.user.value.fullName},',
            style: TextStyle(
              color: Colors.grey,
              fontSize: 18,
            )),

        /// shop Icon
        Text(
          '${controller.user.value.locality}',
          style: TextStyle(
              color: Colors.black,
              fontSize: 18,

              fontWeight: FontWeight.bold),
        ),

      ],
    )


        ),
        InkWell(
          onTap: (){},
          child: Container(
              decoration: BoxDecoration(
                  border: Border.all(color: YHMColors.grey),
                  borderRadius: BorderRadius.circular(12)
              ),
              padding: EdgeInsets.all(13),
              child: Icon(Iconsax.shopping_cart,size: YHMSizes.iconMd-5,)),
        )
      ],
    );
  }
}
