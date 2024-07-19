import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:iconsax/iconsax.dart';
import '../../../../../common/headings/screen_heading.dart';
import '../../../../../common/styles/spacing_style.dart';
import '../../../../../common/widgets/headings/screen_heading.dart';
import '../../../../../utils/constants/colors.dart';
import '../../../../personalization/screens/setting/widgets/circular_image.dart';
import '../../../controllers/service/professional_create_service_controller.dart';
import 'category_shimmer.dart';


class PageWarranty extends StatelessWidget {
  const PageWarranty({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final professionalCreateServiceController =  ProfessionalCreateServiceController.instance;
    
    return SingleChildScrollView(
      child: Padding(
        padding: YHMSpacingStyle.paddingWithAppBarHeight,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 20),

            /// -- step

            Text(
              'Step 3',
              style: Theme.of(context).textTheme.titleMedium,
            ),

            /// -- heading
            const SizedBox(height: 20),
            YHMScreenHeading(
              textSize: 22,
              title: 'Select a warranty period',
            ),



            /// -- list of warranty
            Obx(() {
              if (professionalCreateServiceController.isLoading.value) {
                return CategoryShimmerEffect();
              }
              if (professionalCreateServiceController
                  .servicesForSelectedCategory.isEmpty) {
                return Center(
                  child: Text(
                    'No Services Found !!',
                    style: TextStyle(fontSize: 16),
                  ),
                );
              }
              return ListView(
                padding: EdgeInsets.only(top: 25),
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                children: professionalCreateServiceController.selectedServiceWarranty
                    .asMap()
                    .entries
                    .map((entry) {
                  final index = entry.key;
                  final element = entry.value;
                  final isSelected = index ==
                      professionalCreateServiceController.warrantyIndex.value;
                  return GestureDetector(
                    onTap: () {
                      professionalCreateServiceController.warrantyName.value =
                          element;
                      professionalCreateServiceController.warrantyIndex(index);
                    },
                    child: Container(
                      margin: EdgeInsets.symmetric(vertical: 8, horizontal: 0),
                      padding: EdgeInsets.symmetric(vertical: 20, horizontal: 25),
                      decoration: BoxDecoration(
                        color: isSelected
                            ? YHMColors.dark.withOpacity(0.05)
                            : YHMColors.white,
                        border: Border.all(
                          color: isSelected ? YHMColors.dark : YHMColors.grey,
                          width: 1.0,
                        ),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Column(
                        children: [
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Icon(Iconsax.shield_tick),
                              SizedBox(width: 20),
                              Text(
                                element,
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  );
                }).toList(),
              );
            }),
          ],
        ),
      ),
    );
  }
}