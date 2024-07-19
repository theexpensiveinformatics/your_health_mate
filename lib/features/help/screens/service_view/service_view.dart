import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:get/get.dart%20%20';
import 'package:your_health_mate/features/help/screens/service_view/widgets/service_faq_layout.dart';
import 'package:your_health_mate/features/help/screens/service_view/widgets/service_how_we_work.dart';
import 'package:your_health_mate/features/help/screens/service_view/widgets/service_image.dart';
import 'package:your_health_mate/features/help/screens/service_view/widgets/service_item_layout.dart';
import 'package:your_health_mate/features/help/screens/service_view/widgets/service_name_rating_category.dart';
import 'package:your_health_mate/features/help/screens/service_view/widgets/service_shimmer.dart';
import 'package:your_health_mate/features/help/screens/service_view/widgets/service_warranty_km_verified.dart';
import 'package:your_health_mate/features/help/screens/service_view/widgets/top_row.dart';

import '../../../../common/shimmer/YHMShimmerEffect.dart';
import '../../../../common/styles/spacing_style.dart';
import '../../../../common/widgets/Dividers/divider_line.dart';
import '../../../../common/widgets/headings/screen_sub_heading.dart';
import '../../../../utils/constants/colors.dart';
import '../../../../utils/constants/sizes.dart';
import '../../../../utils/helper/helper_functions.dart';
import '../../../personalization/screens/setting/widgets/circular_image.dart';
import '../../controllers/service/service_view_controller.dart';
import '../service_book/service_book.dart';


class YHMServiceView extends StatelessWidget {
  const YHMServiceView({
    super.key,
    required this.liveServiceID,
    required this.liveServiceDescription,
    required this.liveServiceCategory,
    required this.liveServiceInitialCost,
    required this.liveServiceStatus,
    required this.mArea,
    required this.mPostalCode,
    required this.mState,
    required this.mapAdministrativeArea,
    required this.mapCountry,
    required this.mapLat,
    required this.mapLng,
    required this.mapLocality,
    required this.mapPostalCode,
    required this.mapStreet,
    required this.serviceID,
    required this.serviceProviderEmail,
    required this.serviceProviderID,
    required this.serviceProviderName,
    required this.serviceProviderNumber,
    required this.estimatedCost,
    required this.kms,
    required this.rating,
    required this.liveServiceImg, required this.mCity,
  });


  final String mCity;
  final String liveServiceDescription;
  final String liveServiceCategory;
  final String liveServiceInitialCost;
  final String mArea;
  final String mPostalCode;
  final String mapAdministrativeArea;
  final String mState;
  final String mapCountry;
  final String mapLat;
  final String mapLng;
  final String mapLocality;
  final String mapPostalCode;
  final String mapStreet;
  final String serviceID;
  final String serviceProviderEmail;
  final String serviceProviderID;
  final String serviceProviderName;
  final String serviceProviderNumber;
  final String liveServiceID;
  final String liveServiceStatus;
  final String estimatedCost;
  final String kms;
  final String rating;
  final String liveServiceImg;

  @override
  Widget build(BuildContext context) {
    final serviceViewController = Get.put(ServiceViewController());

    // Fetch the data
    serviceViewController.fetchNeedItems(liveServiceCategory,serviceProviderEmail);

    return Scaffold(
      body:
      Obx(() {
        if (serviceViewController.isLoading.value) {
          return Center(child: YHMServiceShimmmer());
        } else {
          return Stack(
            children: [
              Positioned(
                child: SingleChildScrollView(
                  child: Padding(
                    padding: YHMSpacingStyle.paddingWithAppBarHeight,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        /// -- Top Row
                        YHMServiceViewTopBar(),
                        const SizedBox(height: YHMSizes.spaceBtwItems),

                        /// -- Image
                        YHMServiceViewServiceImage(liveServiceImg: liveServiceImg),
                        const SizedBox(height: YHMSizes.spaceBtwSections),

                        /// -- Service Name & rating & category
                        YHMServiceViewNameRatingCategory(
                          liveServiceName: liveServiceCategory,
                          rating: rating,
                          liveServiceCategory: liveServiceCategory,
                        ),


                        /// -- Box to show warranty and YHM verified
                        YHMServiceWarrantyKmVerified(
                          liveServiceWarraunty: 'No Warranty',
                          kms: kms,
                        ),
                        // const SizedBox(height: YHMSizes.spaceBtwSections),


                        ///-- service provider information
                        DividerLine(height: 60),

                        Row(
                          children: [
                            YHMCircularImage(image: serviceViewController.profilePicture.value,isNetworkImage: true,width: 60,height: 60,radius: 1000,),
                            const SizedBox(width: 10,),
                            Container(
                              width: YHMHelperFunctions.screenWidth() / 2,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(serviceProviderName,style: Theme.of(context).textTheme.titleMedium,),
                                  Text('${mArea},${mCity},${mapAdministrativeArea} - ${mPostalCode}',style: Theme.of(context).textTheme.bodyMedium,),
                                ],
                              ),
                            )
                          ],
                        ),

                        /// -- What we need from you
                        Obx(() {
                          if (serviceViewController.isLoading.value) {
                            return Center(child: CircularProgressIndicator());
                          } else if (serviceViewController.needItems.isEmpty) {
                            return Container(height: 0,width: 0,);
                          } else {
                            return Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                DividerLine(height: 60),
                                ScreenSubHeading(title: 'What not to do?',size: 20,),
                                Column(
                                  children: serviceViewController.needItems
                                      .map((item) => YHMServiceItemLayout(
                                    img: item.img,
                                    text: item.text,
                                  ))
                                      .toList(),
                                ),
                              ],
                            );
                          }
                        }),




                        /// -- Maintenance Tips
                        Obx(() {
                          if (serviceViewController.isLoading.value) {
                            return Center(child: Column(children: [YHMShimmerEffect(width: 180, height: 20,radius: 5,),const SizedBox(height: 10,),YHMShimmerEffect(width: 180, height: 20,radius: 5,),const SizedBox(height: 10,),YHMShimmerEffect(width: 180, height: 20,radius: 5,),const SizedBox(height: 10,),YHMShimmerEffect(width: 180, height: 20,radius: 5,),const SizedBox(height: 10,),],));
                          } else if (serviceViewController.maintenanceTipsItems.isEmpty) {
                            return Container(height: 0,width: 0,);
                          } else {
                            return Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                DividerLine(height: 60),
                                ScreenSubHeading(title: 'Care Tips',size: 20),
                                Column(
                                  children: serviceViewController.maintenanceTipsItems
                                      .map((item) => YHMServiceItemLayout(
                                    img: item.img,
                                    text: item.text,
                                  ))
                                      .toList(),
                                ),
                              ],
                            );
                          }
                        }),



                        /// --faq
                        Obx(() {
                          if (serviceViewController.isLoading.value) {
                            return Center(child: Column(children: [YHMShimmerEffect(width: 180, height: 20,radius: 5,),const SizedBox(height: 10,),YHMShimmerEffect(width: 180, height: 20,radius: 5,),const SizedBox(height: 10,),YHMShimmerEffect(width: 180, height: 20,radius: 5,),const SizedBox(height: 10,),YHMShimmerEffect(width: 180, height: 20,radius: 5,),const SizedBox(height: 10,),],));
                          } else if (serviceViewController.faqItems.isEmpty) {
                            return Container(height: 0,width: 0,);
                          } else {
                            return Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                DividerLine(height: 60),
                                ScreenSubHeading(title: 'FAQs',size: 20),
                                Column(
                                  children: serviceViewController.faqItems
                                      .map((item) => YHMServiceFAQLayout(
                                    question: item.question,
                                    answer: item.answer,
                                  ))
                                      .toList(),
                                ),
                              ],
                            );
                          }
                        }),



                        DividerLine(height: 60),
                        /// -- How we work
                        YHMServiceHowWeWork(),
                        const SizedBox(height: 200,)

                      ],
                    ),
                  ),
                ),
              ),
              Positioned(
                bottom: 0,
                child: Container(
                  decoration: BoxDecoration(
                    border: Border(
                      top: BorderSide(
                        color: YHMHelperFunctions.isDarkMode(context)
                            ? YHMColors.grey.withOpacity(0.1)
                            : YHMColors.grey.withOpacity(0.2),
                      ),
                    ),
                  ),
                  child: Container(
                    decoration: BoxDecoration(
                      boxShadow: [
                        BoxShadow(
                          color: YHMColors.dark.withOpacity(0.08),
                          spreadRadius: 1,
                          blurRadius: 10,
                          offset: const Offset(0, -8),
                        ),
                      ],
                    ),
                    child: ClipRRect(
                      child: BackdropFilter(
                        filter: ImageFilter.blur(sigmaX: 20, sigmaY: 20),
                        child: Container(
                          decoration: BoxDecoration(
                            color: YHMHelperFunctions.isDarkMode(context)
                                ? Colors.black26
                                : Colors.white.withOpacity(0.7),
                          ),
                          height: 85,
                          width: YHMHelperFunctions.screenWidth(),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    '₹ $liveServiceInitialCost',
                                    style: Theme.of(context).textTheme.headlineSmall,
                                  ),
                                  Text('Appointment Fees'),
                                ],
                              ),
                              const SizedBox(height: YHMSizes.spaceBtwItems),
                              ElevatedButton(
                                onPressed: () {
                                  // Implement booking functionality here
                                  Get.to(YHMServiceBookLocation(mCity: mCity, liveServiceDescription: liveServiceDescription, liveServiceCategory: liveServiceCategory, liveServiceInitialCost: liveServiceInitialCost, mArea: mArea, mPostalCode: mPostalCode, mapAdministrativeArea: mapAdministrativeArea, mState: mState, mapCountry: mapCountry, mapLat: mapLat, mapLng: mapLng, mapLocality: mapLocality, mapPostalCode: mapPostalCode, mapStreet: mapStreet, serviceID: serviceID, serviceProviderEmail: serviceProviderEmail, serviceProviderID: serviceProviderID, serviceProviderName: serviceProviderName, serviceProviderNumber: serviceProviderNumber, liveServiceID: liveServiceID,  liveServiceStatus: liveServiceStatus,  estimatedCost: estimatedCost, kms: kms, rating: rating, liveServiceImg: liveServiceImg));
                                },
                                child: Text('   Book Now   '),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ) ;
        }
      }),
    );
  }
}

