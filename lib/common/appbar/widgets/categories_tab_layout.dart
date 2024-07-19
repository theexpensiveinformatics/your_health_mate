import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:your_health_mate/features/personalization/screens/setting/widgets/circular_image.dart';

import '../../../features/help/controllers/home/category_controller.dart';
import '../../../utils/constants/colors.dart';
import '../../shimmer/YHMShimmerEffect.dart';

class YHMCategoryTabLayout extends StatelessWidget {
  const YHMCategoryTabLayout({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final categoryController = Get.find<CategoryController>();


    return Obx(() {
      if (categoryController.isLoading.value)
        return YHMShimmerEffect(width: 200, height: 50);
      if (categoryController.featuredCategories.isEmpty) {
        return Center(
            child: Text(
              'No Categories Found !!',
              style: TextStyle(fontSize: 50),
            ));
      }

      return Obx(
            () => TabBar(
          onTap: (index) {
            categoryController.updateIndex(index);
          },
          overlayColor: MaterialStateProperty.all(Colors.transparent),
          physics: BouncingScrollPhysics(),
          dividerHeight: 0,
          isScrollable: true,
          indicatorColor: YHMColors.dark,
          indicatorSize: TabBarIndicatorSize.label,
          automaticIndicatorColorAdjustment: true,
          unselectedLabelColor: YHMColors.darkGrey,
          labelColor: YHMColors.dark,
          tabAlignment: TabAlignment.start,
          indicator: UnderlineTabIndicator(
            borderSide: BorderSide(
              color: YHMColors.dark,
              width: 2.0,
            ),
          ),
          tabs: categoryController.featuredCategories
              .asMap()
              .entries
              .map((entry) {
            final index = entry.key;
            final element = entry.value;
            return Tab(
              height: 62,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  YHMCircularImage(image: element.icon,height: 33,width: 33,radius: 100,isNetworkImage: true,
                  overlayColor: index == categoryController.selectedIndex.value
                      ? YHMColors.dark
                      : YHMColors.darkGrey,
                  backgroundColor: Colors.transparent,
                  padding: 0,),
                  Text(
                    element.category,
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                      height: 2.2,
                    ),
                  ),
                ],
              ),
            );
          }).toList(),
        ),
      );
    });
  }
}
