import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';

import '../../../../../common/shimmer/YHMShimmerEffect.dart';
import '../../../../../utils/constants/colors.dart';
import '../../../../../utils/constants/text_strings.dart';

import '../../../../../utils/helper/helper_functions.dart';
import '../../../controller/user_controller.dart';
import '../../professional_registration/professional_registration.dart';

class RegisterAsProSection extends StatelessWidget {
  const RegisterAsProSection({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final controller = UserController.instance;
    return Obx(()=>
    
    controller.profileLoading.value  ? YHMShimmerEffect(width: YHMHelperFunctions.screenWidth(), height: 80,radius: 15,):
      Container(
        child: controller.user.value.role == 'user' ?
        InkWell(
          onTap: (){Get.to(()=>ProfessionalRegistration(),transition:Transition.fadeIn);},
          child: Material(
            color: YHMHelperFunctions.isDarkMode(context) ? YHMColors.black : YHMColors.white,
            borderRadius: BorderRadius.circular(15),
            elevation: 5,
            shadowColor: YHMHelperFunctions.isDarkMode(context)
                ? YHMColors.black
                : YHMColors.shadow,
            child: Container(
              padding: EdgeInsets.only(
                  left: 22, top: 21, bottom: 17, right: 20),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    flex: 1,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(YHMTexts.becomePro,
                            style: Theme.of(context)
                                .textTheme
                                .titleLarge),
                        SizedBox(height: 6),
                        Text(YHMTexts.becomeProLine,
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis),
                      ],
                    ),
                  ),

                ],
              ),
            ),
          ),
        ) :
            controller.user.value.role == 'applied_for_professional' ?
        Material(
          color: YHMHelperFunctions.isDarkMode(context)? YHMColors.dark : YHMColors.white,
          borderRadius: BorderRadius.circular(15),
          elevation: 5,
          shadowColor: YHMHelperFunctions.isDarkMode(context)
              ? YHMColors.black
              : YHMColors.shadow,
          child: Container(
            padding: EdgeInsets.only(
                left: 22, top: 21, bottom: 17, right: 20),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  flex: 1,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Your Application Under Review',
                          style: Theme.of(context)
                              .textTheme
                              .titleLarge),
                      SizedBox(height: 6),
                      Text('We are reviewing your application. You will be notified once your application is approved.',
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis),
                    ],
                  ),
                ),

              ],
            ),
          ),
        ) : controller.user.value.role =='rejected' ?
            Material(
              color: YHMHelperFunctions.isDarkMode(context)? YHMColors.dark : YHMColors.white,
              borderRadius: BorderRadius.circular(15),
              elevation: 5,
              shadowColor: YHMHelperFunctions.isDarkMode(context)
                  ? YHMColors.black
                  : YHMColors.shadow,
              child: Container(
                padding: EdgeInsets.only(
                    left: 22, top: 21, bottom: 17, right: 20),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      flex: 1,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Oops Something Went Wrong! ',
                              style: Theme.of(context)
                                  .textTheme
                                  .titleLarge),
                          SizedBox(height: 6),
                          Text('Due to some issue, you are not able to register as a professional. Please try again.',
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis),
                        ],
                      ),
                    ),

                  ],
                ),
              ),
            ) : controller.user.value.role =='professional' ? Material(
              color: YHMHelperFunctions.isDarkMode(context)? YHMColors.dark : YHMColors.white,
              borderRadius: BorderRadius.circular(15),
              elevation: 5,
              shadowColor: YHMHelperFunctions.isDarkMode(context)
                  ? YHMColors.black
                  : YHMColors.shadow,
              child: Container(
                padding: EdgeInsets.only(
                    left: 22, top: 21, bottom: 17, right: 20),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      flex: 1,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Congratulations! ',
                              style: Theme.of(context)
                                  .textTheme
                                  .titleLarge),
                          SizedBox(height: 6),
                          Text('You are now a professional. You can now start providing your services.',
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis),
                        ],
                      ),
                    ),

                  ],
                ),
              ),
            )
                : Material(
              color: YHMHelperFunctions.isDarkMode(context)? YHMColors.dark : YHMColors.white,
              borderRadius: BorderRadius.circular(15),
              elevation: 5,
              shadowColor: YHMHelperFunctions.isDarkMode(context)
                  ? YHMColors.black
                  : YHMColors.shadow,
              child: Container(
                padding: EdgeInsets.only(
                    left: 22, top: 21, bottom: 17, right: 20),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      flex: 1,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Contact Support Team! ',
                              style: Theme.of(context)
                                  .textTheme
                                  .titleLarge),
                          SizedBox(height: 6),
                          Text('Due to some reason we are not able to get your details. Please contact our support team.',
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis),
                        ],
                      ),
                    ),

                  ],
                ),
              ),
            )
      )
    );
  }
}