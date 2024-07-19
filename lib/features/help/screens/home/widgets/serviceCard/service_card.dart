import 'dart:ui';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/get_navigation.dart';

import 'package:iconsax/iconsax.dart';

import '../../../../../../common/shimmer/YHMShimmerEffect.dart';
import '../../../../../../utils/constants/colors.dart';
import '../../../../../../utils/helper/helper_functions.dart';
import '../../../service_view/service_view.dart';
import 'components/cell_layout.dart';


class YHMServiceCard extends StatelessWidget {
  const YHMServiceCard({
    Key? key,
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
    required this.liveServiceImg, required this.profilePicture, required this.mCity,
  }) : super(key: key);

  final String profilePicture;
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
  final String mCity;

  @override
  Widget build(BuildContext context) {
    final ValueNotifier<bool> isPressed = ValueNotifier(false);

    return GestureDetector(
      onTap: (){Get.to(YHMServiceView(liveServiceID: liveServiceID, liveServiceDescription: liveServiceDescription, liveServiceCategory: liveServiceCategory, liveServiceInitialCost: liveServiceInitialCost,  liveServiceStatus: liveServiceStatus, mArea: mArea, mPostalCode: mPostalCode, mState: mState, mapAdministrativeArea: mapAdministrativeArea, mapCountry: mapCountry, mapLat: mapLat, mapLng: mapLng, mapLocality: mapLocality, mapPostalCode: mapPostalCode, mapStreet: mapStreet, serviceID: serviceID, serviceProviderEmail: serviceProviderEmail, serviceProviderID: serviceProviderID, serviceProviderName: serviceProviderName, serviceProviderNumber: serviceProviderNumber, estimatedCost: estimatedCost, kms: kms, rating: rating, liveServiceImg: liveServiceImg, mCity: mCity,));},
      onTapDown: (_) => isPressed.value = true,
      onTapUp: (_) => isPressed.value = false,
      onTapCancel: () => isPressed.value = false,
      child: ValueListenableBuilder<bool>(
        valueListenable: isPressed,
        builder: (context, pressed, child) {
          return AnimatedScale(
            scale: pressed ? 0.95 : 1.0,
            duration: Duration(milliseconds: 100),
            child: Container(
              width: YHMHelperFunctions.screenWidth() / 1.15,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(color: YHMColors.grey.withOpacity(0.5), width: 0.5),
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(12),
                      child: Stack(
                        children: [
                          Positioned(
                            child: Container(
                              width: YHMHelperFunctions.screenWidth() / 1.15,
                              height: YHMHelperFunctions.screenWidth() / 1.15 - 18,
                              child: CachedNetworkImage(
                                imageUrl: liveServiceImg,
                                fit: BoxFit.cover,
                                placeholder: (context, url) => Center(
                                  child: YHMShimmerEffect(
                                    width: YHMHelperFunctions.screenWidth() / 1.15,
                                    height: YHMHelperFunctions.screenWidth() / 1.15,
                                  ),
                                ),
                                errorWidget: (context, url, error) => const Icon(Icons.error),
                              ),
                            ),
                          ),
                          Positioned(
                            right: 12,
                            top: 12,
                            child: Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(16),
                                boxShadow: [
                                  BoxShadow(
                                    color: YHMColors.dark.withOpacity(0.2),
                                    blurRadius: 15,
                                    blurStyle: BlurStyle.outer,
                                    spreadRadius: -2,
                                  ),
                                ],
                              ),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(16),
                                child: BackdropFilter(
                                  filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
                                  child: Container(
                                    width: 40,
                                    height: 40,
                                    decoration: BoxDecoration(
                                      border: Border.all(color: YHMColors.white, width: 0.8),
                                      gradient: LinearGradient(
                                        begin: Alignment.topCenter,
                                        end: Alignment.bottomCenter,
                                        colors: [
                                          YHMColors.white.withOpacity(0.5),
                                          YHMColors.gradientStart.withOpacity(0.5),
                                        ],
                                      ),
                                      borderRadius: BorderRadius.circular(16),
                                    ),
                                    child: Icon(Iconsax.heart, size: 20),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          Positioned(
                            bottom: 12,
                            left: 12,
                            child: Row(
                              children: [
                                YHMCellLayout(
                                  text: 'Verified',
                                  icon: Iconsax.shield_tick,
                                  iconColor: YHMColors.primary,
                                  firstColor: YHMColors.white.withOpacity(1),
                                  secondColor: YHMColors.gradientBlue.withOpacity(1),
                                ),
                                SizedBox(width: 10),
                                YHMCellLayout(
                                  text: liveServiceStatus,
                                  icon: Iconsax.clock,
                                  iconColor: YHMColors.green,
                                  firstColor: YHMColors.white.withOpacity(1),
                                  secondColor: YHMColors.gradientGreen.withOpacity(1),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(height: 10),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            serviceProviderName,
                            style: Theme.of(context).textTheme.titleLarge,
                          ),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text(
                                '₹ $estimatedCost',
                                style: Theme.of(context).textTheme.bodyLarge!.copyWith(fontWeight: FontWeight.w500),
                              ),
                              SizedBox(width: 5),
                              Text(
                                '$kms kms away',
                                style: Theme.of(context).textTheme.bodySmall!.copyWith(fontWeight: FontWeight.w400),
                              ),
                            ],
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          Icon(Icons.star, size: 18),
                          SizedBox(width: 3),
                          Text(
                            rating,
                            style: Theme.of(context).textTheme.labelMedium!.copyWith(color: YHMColors.dark),
                          ),
                        ],
                      ),
                    ],
                  ),
                  SizedBox(height: 40),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
