import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:your_health_mate/features/help/screens/professional_create_services/widgets/category_shimmer.dart';
import '../../../../../common/headings/screen_heading.dart';
import '../../../../../common/shimmer/YHMShimmerEffect.dart';
import '../../../../../common/styles/spacing_style.dart';
import '../../../../../common/widgets/headings/screen_heading.dart';
import '../../../../../utils/constants/colors.dart';
import '../../../../personalization/screens/setting/widgets/circular_image.dart';
import '../../../controllers/service/professional_create_service_controller.dart';

class PageCategory extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final professionalCreateServiceController =
        ProfessionalCreateServiceController.instance;
    return SingleChildScrollView(
      child: Padding(
        padding: YHMSpacingStyle.paddingWithAppBarHeight,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 20),
      
            /// -- step
            Text(
              'Step 1',
              style: Theme.of(context).textTheme.titleMedium,
            ),
      
            /// -- heading
            const SizedBox(height: 20),
            YHMScreenHeading(textSize: 22,
              title: 'Which of these \ncategory of your service?',
            ),
      
            /// -- list of category
            Obx(() {
              if (professionalCreateServiceController.isLoading.value) {
                return CategoryShimmerEffect();
              }
              if (professionalCreateServiceController
                  .featuredCategories.isEmpty) {
                return Center(
                  child: Text(
                    'No Categories Found !!',
                    style: TextStyle(fontSize: 16),
                  ),
                );
              }
              return ListView(
                padding: EdgeInsets.only(top: 25),
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                children: professionalCreateServiceController.featuredCategories
                    .asMap()
                    .entries
                    .map((entry) {
                  final index = entry.key;
                  final element = entry.value;
                  final isSelected = index ==
                      professionalCreateServiceController.categoryIndex.value;
                  return GestureDetector(
                    onTap: () {
                      professionalCreateServiceController.categoryName.value =
                          element.category;
                      professionalCreateServiceController.categoryId.value=element.id;
                      print(
                          '===============${professionalCreateServiceController.categoryIndex}');
                      professionalCreateServiceController.updateIndex(index);
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
                      child: Row(
                        children: [
                          YHMCircularImage(image: element.icon,height: 33,width: 33,radius: 100,isNetworkImage: true,
                            overlayColor: isSelected ? YHMColors.dark : YHMColors.darkGrey,
                            padding: 0,),
                          SizedBox(width: 20),
                          Text(
                            element.category,
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                            ),
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
