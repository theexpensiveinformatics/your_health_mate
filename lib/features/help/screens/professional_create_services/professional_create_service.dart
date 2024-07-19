import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:your_health_mate/features/help/screens/professional_create_services/widgets/page_address.dart';
import 'package:your_health_mate/features/help/screens/professional_create_services/widgets/page_category.dart';
import 'package:your_health_mate/features/help/screens/professional_create_services/widgets/page_manual_address.dart';
import 'package:your_health_mate/features/help/screens/professional_create_services/widgets/page_service.dart';
import 'package:your_health_mate/features/help/screens/professional_create_services/widgets/page_service_details.dart';
import 'package:your_health_mate/features/help/screens/professional_create_services/widgets/page_warranty.dart';

import '../../../../utils/constants/colors.dart';
import '../../../../utils/helper/helper_functions.dart';
import '../../controllers/service/professional_create_service_controller.dart';



class YHMProfessionalServiceCreate extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final professionalCreateServiceController =
    Get.put(ProfessionalCreateServiceController());

    return Scaffold(
      body: Stack(
        children: [
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            bottom: 100, // Adjust this to avoid overflow at the bottom
            child: PageView(
              scrollDirection: Axis.horizontal,
              physics: NeverScrollableScrollPhysics(),
              controller: professionalCreateServiceController.pageController,
                children: [

                  PageCategory(),
                  PageAddress(),
                  PageManualAddress(),
                  PageServiceDetails()
                ],
                ),
          ),
          Positioned(
            bottom: 0,
            left: 0,
            child: Container(
              height: 100,
              width: YHMHelperFunctions.screenWidth(),

              child: Column(
                children: [

                  /// -- custom page indicator
                  Container(
                    height: 4,
                    width: YHMHelperFunctions.screenWidth(),
                    child: Obx(
                          ()=>Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(color: professionalCreateServiceController.currentStep >= 0 ?YHMColors.primary:YHMColors.grey,width: YHMHelperFunctions.screenWidth()/6-3,),
                          Container(color: professionalCreateServiceController.currentStep >= 1 ?YHMColors.primary:YHMColors.grey,width: YHMHelperFunctions.screenWidth()/6-3,),
                          Container(color: professionalCreateServiceController.currentStep >= 2 ?YHMColors.primary:YHMColors.grey,width: YHMHelperFunctions.screenWidth()/6-3,),
                          Container(color: professionalCreateServiceController.currentStep >= 3 ?YHMColors.primary:YHMColors.grey,width: YHMHelperFunctions.screenWidth()/6-3,),
                          Container(color: professionalCreateServiceController.currentStep >= 4 ?YHMColors.primary:YHMColors.grey,width: YHMHelperFunctions.screenWidth()/6-3,),
                          Container(color: professionalCreateServiceController.currentStep >= 5 ?YHMColors.primary:YHMColors.grey,width: YHMHelperFunctions.screenWidth()/6-3,),

                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 25),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        InkWell(
                          onTap: () {
                            professionalCreateServiceController.previousStep();
                          },
                          child: Text(
                            'Back',
                            style: Theme.of(context)
                                .textTheme
                                .titleLarge
                                ?.copyWith(
                              decoration: TextDecoration.underline,
                              decorationThickness: 0.6,
                            ),
                          ),
                        ),
                        SizedBox(
                          child: ElevatedButton(
                            onPressed: () {
                              professionalCreateServiceController.nextStep();
                            },
                            child: Obx(()=>
                               Padding(
                                 padding: const EdgeInsets.only(left: 20,right: 20),
                                 child: Text(
                                  '${professionalCreateServiceController.currentStep==5 ? "Ready to Help":"Next"}',
                                  style: Theme.of(context)
                                      .textTheme
                                      .titleLarge!
                                      .copyWith(
                                    color: Colors.white,
                                    letterSpacing: 0.7,
                                  ),
                                                               ),
                               ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
