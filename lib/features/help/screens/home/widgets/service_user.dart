import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart%20%20';
import 'package:your_health_mate/features/help/screens/home/widgets/service_card.dart';

import '../../../../../common/shimmer/YHMShimmerEffect.dart';
import '../../../../../common/styles/spacing_style.dart';
import '../../../../../utils/constants/image_strings.dart';
import '../../../../../utils/constants/sizes.dart';
import '../../../../personalization/controller/user_controller.dart';
import '../../../../personalization/screens/professional_registration/professional_registration.dart';

class YHMServiceUser extends StatelessWidget {
  final controller = Get.put(UserController());

  YHMServiceUser({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: YHMSpacingStyle.paddingWithAppBarHeight,
        child: SingleChildScrollView(
          child: Column(
            children: [
              Text(
                'Service User',
                style: Theme.of(context).textTheme.headlineSmall,
              ),
              // fetch service from LiveServices collection
              Obx(
                () => controller.profileLoading == true
                    ? Column(
                        children: [
                          YHMShimmerEffect(width: double.infinity, height: 80),
                          const SizedBox(
                            height: YHMSizes.spaceBtwItems,
                          ),
                          YHMShimmerEffect(width: double.infinity, height: 80),
                          const SizedBox(
                            height: YHMSizes.spaceBtwItems,
                          ),
                          YHMShimmerEffect(width: double.infinity, height: 80),
                          const SizedBox(
                            height: YHMSizes.spaceBtwItems,
                          ),
                          YHMShimmerEffect(width: double.infinity, height: 80),
                          const SizedBox(
                            height: YHMSizes.spaceBtwItems,
                          ),
                        ],
                      )
                    : FutureBuilder(
                        future: _fetchUserServices(),
                        builder: (context, snapshot) {
                          if (snapshot.connectionState ==
                              ConnectionState.waiting) {
                            return Column(
                              children: [
                                YHMShimmerEffect(
                                    width: double.infinity, height: 80),
                                const SizedBox(
                                  height: YHMSizes.spaceBtwItems,
                                ),
                                YHMShimmerEffect(
                                    width: double.infinity, height: 80),
                                const SizedBox(
                                  height: YHMSizes.spaceBtwItems,
                                ),
                                YHMShimmerEffect(
                                    width: double.infinity, height: 80),
                                const SizedBox(
                                  height: YHMSizes.spaceBtwItems,
                                ),
                                YHMShimmerEffect(
                                    width: double.infinity, height: 80),
                                const SizedBox(
                                  height: YHMSizes.spaceBtwItems,
                                ),
                              ],
                            );
                          } else if (snapshot.hasError) {
                            return Text('Error: ${snapshot.error}');
                          } else {
                            List<Map<String, dynamic>> userServices =
                                snapshot.data as List<Map<String, dynamic>>;

                            return userServices.isNotEmpty
                                ? Column(
                                    children: [
                                      // Display user's services
                                      for (var service in userServices)
                                        ServiceCard(
                                          professionalId: service['userId'],
                                          serviceId: service['serviceId'],
                                          liveServiceId: service['liveServiceId'],
                                          imageUrl: service['imageUrl'],
                                          serviceName: service['serviceName'],
                                          warranty: service['warranty'],
                                          cost: service['cost'],
                                          category: service['category'],
                                        ),
                                    ],
                                  )
                                : Center(
                                  child: Column(
                                    children: [
                                      Image.asset(YHMImages.onBoardingImage1),
                                      Text(textAlign: TextAlign.center,
                                          'Oops! No services available in your area\nYou can Start providing a services in your area.',
                                        ),
                                      const SizedBox(height: YHMSizes.spaceBtwItems,),
                                      InkWell(
                                        onTap: (){
                                          Get.to(ProfessionalRegistration());
                                        },
                                        child: Text(
                                          'Apply for become Professional',
                                          style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                                            decoration: TextDecoration.combine([
                                              TextDecoration.underline,
                                            ]),
                                            decorationThickness: 0.6, // Adjust the thickness as needed
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                );
                          }
                        },
                      ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<List<Map<String, dynamic>>> _fetchUserServices() async {
    // TODO: Replace 'LiveServices' with your actual collection name
    QuerySnapshot querySnapshot = await FirebaseFirestore.instance
        .collection('LiveServices')
        .where('postalCode', isEqualTo: controller.user.value.postalCodeAuto)
        .get();

    return querySnapshot.docs
        .map((doc) => doc.data() as Map<String, dynamic>)
        .toList();
  }
}
