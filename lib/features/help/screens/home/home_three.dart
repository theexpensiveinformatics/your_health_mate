import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:your_health_mate/features/help/screens/home/widgets/serviceCard/service_card.dart';

import '../../../../common/appbar/home_appbar.dart';
import '../../../../common/appbar/widgets/categories_tab_layout.dart';
import '../../../../common/appbar/widgets/search_bar.dart';
import '../../../../common/shimmer/YHMShimmerEffect.dart';
import '../../../../navigation_menu_professional.dart';
import '../../../../utils/constants/colors.dart';
import '../../../../utils/helper/helper_functions.dart';
import '../../controllers/home/home_service_controller.dart';
import 'home_map_screen.dart';

class YHMServiceHomeScreen extends StatelessWidget {
  final HomeServiceController homeServiceController = Get.put(HomeServiceController());

  @override
  Widget build(BuildContext context) {
    return  Obx(() {
        return DefaultTabController(
          length: homeServiceController.categoryController.featuredCategories.length,
          child: Scaffold(
            floatingActionButton: Padding(
              padding: const EdgeInsets.only(bottom: 70),
              child: GestureDetector(
                onTap: (){
                  final List<Map<String, dynamic>> services = List<Map<String, dynamic>>.from(homeServiceController.liveServices);
                  Get.to(() => YHMHomeMapScreen(servicesWithDistance: services));
                },
                child: Container(
                  width: 105,
                  height: 50,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    boxShadow: [BoxShadow(
                        blurRadius: 15,
                        spreadRadius: -8,
                        offset: Offset(8,8),
                        color: YHMColors.darkerGrey
                    )],
                    color: YHMColors.dark,
                    borderRadius: BorderRadius.circular(100),
                  ),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text('Map',style: Theme.of(context).textTheme.titleLarge!.copyWith(color: Colors.white),),
                      const SizedBox(width: 6,),
                      Icon(Iconsax.map,color: Colors.white,),


                    ],
                  ),
                ),
              ),
            ),
            extendBodyBehindAppBar: true,
            appBar: YHMHomeAppBar(
              widget: Column(
                children: [
                  const SizedBox(height: 20),
                  const YHMSearchBar(),
                  const SizedBox(height: 20),
                  const YHMCategoryTabLayout(),
                ],
              ),
            ),


            body: Stack(
              children: [

                Positioned(
                  child: Obx(() {
                    /// -- Loading
                    if (homeServiceController.categoryController.isLoading.value || homeServiceController.isLoading.value) {
                      return Center(
                        child: SingleChildScrollView(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const SizedBox(height: 230),
                              YHMShimmerEffect(
                                  width: YHMHelperFunctions.screenWidth() / 1.15,
                                  height: YHMHelperFunctions.screenWidth() / 1.15),
                              const SizedBox(height: 10),
                              YHMShimmerEffect(width: 200, height: 20, radius: 5),
                              const SizedBox(height: 10),
                              YHMShimmerEffect(width: 150, height: 20, radius: 5),
                              const SizedBox(height: 40),
                              YHMShimmerEffect(
                                  width: YHMHelperFunctions.screenWidth() / 1.15,
                                  height: YHMHelperFunctions.screenWidth() / 1.15),
                              const SizedBox(height: 10),
                              YHMShimmerEffect(width: 200, height: 20, radius: 5),
                              const SizedBox(height: 10),
                              YHMShimmerEffect(width: 150, height: 20, radius: 5),
                              const SizedBox(height: 40),
                            ],
                          ),
                        ),
                      );
                    }

                    /// -- all sheet
                    return RefreshIndicator(
                      color: YHMColors.primary,
                      backgroundColor: Colors.white,
                      onRefresh: homeServiceController.refreshServices,
                      edgeOffset: 200,
                      child: SingleChildScrollView(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            const SizedBox(height: 240,),
                            Container(
                              width: double.infinity,
                            ),
                            Obx(() {
                              if (homeServiceController.userController.profileLoading.value) {
                                return const YHMShimmerEffect(width: 80, height: 15);
                              } else {
                                if (homeServiceController.userController.user.value.role == 'professional') {
                                  return InkWell(
                                    onTap: () {
                                      Get.to(YHMNavigationMenuProfessional());
                                    },
                                    child: Text(
                                      'Open Professional Dashboard',
                                      style: Theme.of(context)
                                          .textTheme
                                          .headlineSmall
                                          ?.copyWith(
                                        decoration: TextDecoration.combine([
                                          TextDecoration.underline,
                                        ]),
                                        decorationThickness:
                                        0.6,
                                      ),
                                    ),
                                  );
                                }
                                return Container();
                              }
                            }),

                            Obx(() {
                              if (homeServiceController.liveServices.isEmpty) {
                                return Center(child: Text('No services found.'));
                              }
                              return Column(
                                children: homeServiceController.liveServices.map((service) {
                                  Map<String, dynamic> data = service['data'];
                                  double distance = service['distance'] / 1000;
                                  return YHMServiceCard(
                                    mCity: data['mCity'],
                                    liveServiceID: data['liveServiceID'],
                                    liveServiceDescription: data['liveServiceDescription'],
                                    liveServiceCategory: data['liveServiceCategory'],
                                    liveServiceInitialCost: data['liveServiceInitialCost'],
                                    liveServiceStatus: data['liveServiceStatus'],
                                    mArea: data['mArea'],
                                    mPostalCode: data['mPostalCode'],
                                    mState: data['mState'],
                                    mapAdministrativeArea: data['mapAdministrativeArea'],
                                    mapCountry: data['mapCountry'],
                                    mapLat: data['mapLat'].toString(),
                                    mapLng: data['mapLng'].toString(),
                                    mapLocality: data['mapLocality'],
                                    mapPostalCode: data['mapPostalCode'],
                                    mapStreet: data['mapStreet'],
                                    serviceID: data['serviceID'].toString(),
                                    serviceProviderEmail: data['serviceProviderEmail'],
                                    serviceProviderID: data['serviceProviderID'],
                                    serviceProviderName: data['serviceProviderName'],
                                    serviceProviderNumber: data['serviceProviderNumber'],
                                    estimatedCost: data['liveServiceInitialCost'],
                                    kms: distance.toStringAsFixed(1),
                                    rating: data['rating'].toString(),
                                    liveServiceImg: data['liveServiceImg'],
                                    profilePicture: data['profilePicture'],
                                  );

                                }).toList(),
                              );
                            }),
                            Padding(
                              padding: const EdgeInsets.only(left: 20,right: 120),
                              child: Image.asset('assets/images/watermark.png',width: YHMHelperFunctions.screenWidth(),fit: BoxFit.fill,),
                            ),
                            SizedBox(height: 150,)
                          ],
                        ),
                      ),
                    );
                  }),
                ),
              ],
            ),
          ),
        );
      });
  }
}
