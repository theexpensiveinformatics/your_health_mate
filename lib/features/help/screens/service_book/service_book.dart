import 'dart:ui';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import 'package:iconsax/iconsax.dart';
import 'package:your_health_mate/features/help/screens/service_book/widgets/HHServiceBookManualLocation.dart';

import '../../../../common/appbar/blur_appbar.dart';
import '../../../../common/shimmer/YHMShimmerEffect.dart';
import '../../../../utils/constants/colors.dart';
import '../../../../utils/constants/sizes.dart';
import '../../../../utils/helper/helper_functions.dart';
import '../../controllers/service/service_booking_controller.dart';




class YHMServiceBookLocation extends StatelessWidget {
  const YHMServiceBookLocation({super.key, required this.mCity, required this.liveServiceDescription, required this.liveServiceCategory, required this.liveServiceInitialCost, required this.mArea, required this.mPostalCode, required this.mapAdministrativeArea, required this.mState, required this.mapCountry, required this.mapLat, required this.mapLng, required this.mapLocality, required this.mapPostalCode, required this.mapStreet, required this.serviceID, required this.serviceProviderEmail, required this.serviceProviderID, required this.serviceProviderName, required this.serviceProviderNumber, required this.liveServiceID,  required this.liveServiceStatus, required this.estimatedCost, required this.kms, required this.rating, required this.liveServiceImg});

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
    final serviceBookingController = Get.put(ServiceBookingController());

    return Scaffold(
      appBar: YHMBlurAppBar(elevation: 10,title: 'Enter Location', showBackArrow: true, leadPadding: 30, leadingIcon: Icons.abc),
      extendBodyBehindAppBar: true,
      body: Column(
        children: [
          /// -- map for selecting location
          Obx(() => Container(
            child: serviceBookingController.isMapLoading.value
                ? Center(child: Column(
                  children: [
                    const SizedBox(height: 150,),
                    Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: YHMShimmerEffect(height: 200, width: double.infinity,radius: 20,),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: YHMShimmerEffect(height: 200, width: double.infinity,radius: 20,),
                    ),
                  ],
                ))
                : Stack(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(16),
                  child: Container(
                    height: YHMHelperFunctions.screenHeight(),
                    child: GoogleMap(
                      myLocationEnabled: true,
                      onMapCreated: serviceBookingController.onMapCreated,
                      initialCameraPosition: CameraPosition(
                        target: serviceBookingController.desLocation!,
                        zoom: 19.0,
                      ),
                      onCameraMove: (position) {
                        serviceBookingController.desLocation = position.target;
                      },
                      onCameraIdle: () {
                        serviceBookingController.getAddressFromLatLng();
                      },
                    ),
                  ),
                ),

                /// -- blue marker
                Positioned(
                  top: 0,
                  bottom: 30,
                  right: 0,
                  left: 0,
                  child: Icon(
                    Icons.location_pin,
                    size: 50,
                    color: YHMColors.primary,
                  ),
                ),

                /// -- locate me
                Positioned(
                    left: 0,
                    right: 0,
                    bottom: 160,
                    child:
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        GestureDetector(
                          onTap: () {
                            serviceBookingController.locateUser();
                          },
                          child: Container(
                            padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: Colors.white,
                                boxShadow: [BoxShadow(
                                    color: YHMColors.dark.withOpacity(0.15),
                                    offset: Offset(0, 10),
                                    blurRadius: 10
                                )]
                            ),
                            child: Row(
                              children: [
                                Icon(Icons.my_location, color: YHMColors.primary,),
                                Text('  Locate Me', style: Theme.of(context).textTheme.titleLarge!.copyWith(color: YHMColors.primary),)
                              ],
                            ),
                          ),
                        ),
                      ],
                    )),


                /// bottom addre
                Positioned(
                  right: 0,
                  left: 0,
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
                          filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                          child: Container(
                            decoration: BoxDecoration(
                              color: YHMHelperFunctions.isDarkMode(context)
                                  ? Colors.black26
                                  : Colors.white.withOpacity(0.3),
                            ),

                            width: YHMHelperFunctions.screenWidth(),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.end,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const SizedBox(height: 20,),
                                Padding(
                                  padding: const EdgeInsets.symmetric(horizontal: 20),
                                  child: Row(
                                    children: [
                                      Icon(Iconsax.location5, color: YHMColors.primary, size: 30,),
                                      const SizedBox(width: 10,),
                                      Expanded(
                                        child: Text(
                                          '${serviceBookingController.markLocation}',
                                          style: Theme.of(context).textTheme.headlineSmall,
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),

                                const SizedBox(height: YHMSizes.spaceBtwItems),
                                Container(
                                  width: double.infinity,
                                  padding: EdgeInsets.symmetric(horizontal: 20),
                                  child: ElevatedButton(
                                    onPressed: () {
                                    Get.to(YHMServiceBookManualLocation(mCity: mCity, liveServiceDescription: liveServiceDescription, liveServiceCategory: liveServiceCategory, liveServiceInitialCost: liveServiceInitialCost, mArea: mArea, mPostalCode: mPostalCode, mapAdministrativeArea: mapAdministrativeArea, mState: mState, mapCountry: mapCountry, mapLat: mapLat, mapLng: mapLng, mapLocality: mapLocality, mapPostalCode: mapPostalCode, mapStreet: mapStreet, serviceID: serviceID, serviceProviderEmail: serviceProviderEmail, serviceProviderID: serviceProviderID, serviceProviderName: serviceProviderName, serviceProviderNumber: serviceProviderNumber, liveServiceID: liveServiceID, liveServiceStatus: liveServiceStatus,  estimatedCost: estimatedCost, kms: kms, rating: rating, liveServiceImg: liveServiceImg));
                                    },
                                    child: Text('   Confirm Location   '),
                                  ),
                                ),

                                const SizedBox(height: 20,),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),


              ],
            ),
          )),
        ],
      ),
    );
  }


}
