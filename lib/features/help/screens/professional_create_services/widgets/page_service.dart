import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import '../../../../../common/headings/screen_heading.dart';
import '../../../../../common/styles/spacing_style.dart';
import '../../../../../utils/constants/colors.dart';
import '../../../../personalization/screens/setting/widgets/circular_image.dart';
import '../../../controllers/service/professional_create_service_controller.dart';
import 'category_shimmer.dart';


class PageService extends StatelessWidget{
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
              'Step 2',
              style: Theme.of(context).textTheme.titleMedium,
            ),
      
            /// -- heading
            const SizedBox(height: 20),
            YHMScreenHeading(textSize: 22,
              title: 'Choose a service',
            ),
            

      
            /// -- list of service
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
                children: professionalCreateServiceController.servicesForSelectedCategory
                    .asMap()
                    .entries
                    .map((entry) {
                  final index = entry.key;
                  final element = entry.value;
                  final isSelected = index ==
                      professionalCreateServiceController.serviceIndex.value;
                  return GestureDetector(
                    onTap: () {
                      professionalCreateServiceController.selectedServiceWarranty.value=element.warranties;
                      print(professionalCreateServiceController.selectedServiceWarranty);
                      professionalCreateServiceController.serviceName.value =
                          element.serviceName;
                      professionalCreateServiceController.serviceId.value=element.serviceId;
                      professionalCreateServiceController.serviceIndex(index);
                    },
                    child: Container(
                      margin: EdgeInsets.symmetric(vertical: 8, horizontal: 0),
                      padding: EdgeInsets.symmetric(vertical: 15, horizontal: 15),
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
                              YHMCircularImage(
                                backgroundColor: YHMColors.lightGrey,
                                radius: 8,
                                padding: 2,
                                image: element.serviceImage,
                                height: 50,
                                width: 50,
                                fit: BoxFit.cover,
                                isNetworkImage: true,
                              ),
                              SizedBox(width: 20),
                              Text(
                                element.serviceName,
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              /// print all warranty

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