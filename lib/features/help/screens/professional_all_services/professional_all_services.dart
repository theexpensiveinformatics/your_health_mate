import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:your_health_mate/features/help/screens/professional_all_services/widgets/pro_service_card.dart';
import 'package:your_health_mate/features/help/screens/professional_all_services/widgets/professional_all_service_shimmer.dart';

import '../../../../common/appbar/blur_appbar.dart';
import '../../../../common/styles/spacing_style.dart';
import '../../../../utils/constants/colors.dart';
import '../../controllers/service/professional_all_services_controller.dart';

import '../professional_create_services/professional_create_service.dart';

class YHMProfessionalAllServices extends StatelessWidget {
  YHMProfessionalAllServices({super.key});

  final professionalAllServicesController = Get.put(ProfessionalAllServicesController());

  @override
  Widget build(BuildContext context) {
    professionalAllServicesController.listenToServiceRequests();

    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: YHMBlurAppBar(
        title: 'Your Services',
        showBackArrow: false,
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 20),
            child: InkWell(
              onTap: () {
                Get.to(YHMProfessionalServiceCreate());
              },
              child: Container(
                width: 45,
                height: 45,
                child: Icon(Iconsax.add),
                decoration: BoxDecoration(
                  border: Border.all(
                    color: YHMColors.grey,
                    width: 1,
                  ),
                  borderRadius: BorderRadius.circular(100),
                ),
              ),
            ),
          )
        ],
      ),
      body: Obx(() {
        if (professionalAllServicesController.isLoading.value) {
          return YHMProfessionalAllServiceShimmer();
        } else if (professionalAllServicesController.services.isEmpty) {
          return Text('No services found.');
        } else {
          return SingleChildScrollView(
            child: Padding(
              padding: YHMSpacingStyle.paddingWithAppBarHeight,
              child: Column(
                children: [
                  const SizedBox(height: 80,),
                  Obx(() {
                    if (professionalAllServicesController.isOffline.value) {
                      return Container(
                        width: double.infinity,
                        child: Row(
                          children: [
                            Text('You are currently offline. ', style: TextStyle(color: YHMColors.dark),),
                            Expanded(
                              child: ElevatedButton(
                              
                                style: ElevatedButton.styleFrom(
                                  elevation: 15,
                                  shadowColor: YHMColors.dark.withOpacity(0.35)
                              
                                ),
                                onPressed: () {
                                  professionalAllServicesController.updateAllServicesStatus('Available');
                                },
                                child: Text('Go Online'),
                              ),
                            ),
                          ],
                        ),
                      );
                    } else {
                      return Container(
                        width: double.infinity,
                        child: OutlinedButton(
                          onPressed: () {
                            professionalAllServicesController.updateAllServicesStatus('Offline');
                          },
                          child: Text('Go Offline'),
                        ),
                      );
                    }
                  }),
                  const SizedBox(height: 30,),
                  ListView.builder(
                    shrinkWrap: true,
                    padding: EdgeInsets.zero,
                    physics: NeverScrollableScrollPhysics(),
                    itemCount: professionalAllServicesController.services.length,
                    itemBuilder: (context, index) {
                      final data = professionalAllServicesController.services[index];
                      return ProServiceCard(
                        serviceRequest: data['requestCount'].toString(),
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
                        kms: data['kms'].toString(),
                        rating: data['rating'].toString(),
                        liveServiceImg: data['liveServiceImg'],
                      );
                    },
                  ),
                ],
              ),
            ),
          );
        }
      }),
    );
  }
}
