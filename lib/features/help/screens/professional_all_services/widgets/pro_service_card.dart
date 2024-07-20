import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart%20%20';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:iconsax/iconsax.dart';
import 'package:your_health_mate/features/help/screens/professional_service_management/professional_service_management.dart';
import '../../../../../common/shimmer/YHMShimmerEffect.dart';
import '../../../../../utils/constants/colors.dart';
import '../../../../../utils/constants/sizes.dart';
import '../../../../../utils/helper/helper_functions.dart';
import '../../../controllers/service/professional_all_services_controller.dart';

class ProServiceCard extends StatelessWidget {
  final professionalAllServicesController = Get.put(ProfessionalAllServicesController());
   ProServiceCard({
    super.key, required this.mCity, required this.liveServiceDescription, required this.liveServiceCategory, required this.liveServiceInitialCost, required this.mArea, required this.mPostalCode, required this.mapAdministrativeArea, required this.mState, required this.mapCountry, required this.mapLat, required this.mapLng, required this.mapLocality, required this.mapPostalCode, required this.mapStreet, required this.serviceID, required this.serviceProviderEmail, required this.serviceProviderID, required this.serviceProviderName, required this.serviceProviderNumber, required this.liveServiceID, required this.liveServiceStatus, required this.estimatedCost, required this.kms, required this.rating, required this.liveServiceImg, required this.serviceRequest,
  });
  final String serviceRequest;
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
    return Padding(
      padding: const EdgeInsets.only(bottom: YHMSizes.md),
      child: InkWell(
        onTap: (){
          professionalAllServicesController.selectedLiveServiceId.value=liveServiceID;
          Get.to(YHMProfessionalServiceManagement(serviceRequest: serviceRequest, mCity: mCity, liveServiceDescription: liveServiceDescription, liveServiceCategory: liveServiceCategory, liveServiceInitialCost: liveServiceInitialCost, mArea: mArea, mPostalCode: mPostalCode, mapAdministrativeArea: mapAdministrativeArea, mState: mState, mapCountry: mapCountry, mapLat: mapLat, mapLng: mapLng, mapLocality: mapLocality, mapPostalCode: mapPostalCode, mapStreet: mapStreet, serviceID: serviceID, serviceProviderEmail: serviceProviderEmail, serviceProviderID: serviceProviderID, serviceProviderName: serviceProviderName, serviceProviderNumber: serviceProviderNumber, liveServiceID: liveServiceID, liveServiceStatus: liveServiceStatus, estimatedCost: estimatedCost, kms: kms, rating: rating, liveServiceImg: liveServiceImg));
        },
        child: Container(
          padding: EdgeInsets.all(YHMSizes.sm),
          width: double.infinity,
          decoration: BoxDecoration(
            color: YHMHelperFunctions.isDarkMode(context)
                ? YHMColors.black
                : YHMColors.white,
            boxShadow: [
              BoxShadow(
                color: YHMHelperFunctions.isDarkMode(context)
                    ? Colors.black26
                    : YHMColors.grey.withOpacity(0.5),
                spreadRadius: 1,
                blurRadius: 10,
                offset: const Offset(5, 15), // changes position of shadow
              ),
            ],
            borderRadius: BorderRadius.circular(12),
            border: Border.all(
                color: YHMHelperFunctions.isDarkMode(context)
                    ? YHMColors.grey.withOpacity(0.1)
                    : YHMColors.grey.withOpacity(0.5)),
          ),
          child: Row(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: Container(
                  height: 120,
                  width: 90,
                  color: YHMColors.primary.withOpacity(0.05),
                  child: CachedNetworkImage(
                    imageUrl: liveServiceImg,
                    fit: BoxFit.cover,
                    placeholder: (context, url) => const Center(
                      child: YHMShimmerEffect(
                          width: 195,
                          height: 195,),
                    ),
                    errorWidget: (context, url, error) => const Icon(Icons.error),
                  ),
                ),
              ),
              const SizedBox(
                width: YHMSizes.spaceBtwItems,
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
    
                  const SizedBox(
                    height: YHMSizes.spaceBtwItems / 2,
                  ),
                  Container(
                    width: YHMHelperFunctions.screenWidth() / 2.5,
                    child: Expanded(
                      child: Text(
                        liveServiceCategory,
                        style: Theme.of(context).textTheme.titleMedium,
                        overflow: TextOverflow.ellipsis,
                        maxLines: 1,
                      ),
                    ),
                  ),
    
                  Row(
                    children: [
                      Icon(
                        Iconsax.routing,
                        size: YHMSizes.iconSm,
                      ),
                      const SizedBox(
                        width: YHMSizes.spaceBtwItems / 2,
                      ),
                      Container(
                          width: YHMHelperFunctions.screenWidth() / 3,
                          child: Text(
                            '$mCity, $mState',
                            overflow: TextOverflow.ellipsis,
                            maxLines: 1,
                          )),
                    ],
                  ),
                  const SizedBox(
                    height: YHMSizes.spaceBtwItems / 5,
                  ),
                  Row(
                    children: [
                      Container(
                        width: YHMSizes.iconSm,
                        height: YHMSizes.iconSm,
                        decoration: BoxDecoration(
                          color: Colors.greenAccent.withOpacity(0.4),
                          borderRadius: BorderRadius.circular(100),
                        ),
                        child: Icon(
                          Icons.circle,
                          color: Colors.greenAccent,
                          size: YHMSizes.iconXs,
                        ),
                      ),
                      const SizedBox(
                        width: YHMSizes.spaceBtwItems / 2,
                      ),
                      Container(
                          width: YHMHelperFunctions.screenWidth() / 3,
                          child: Text(
                            '$serviceRequest Requests',
                            overflow: TextOverflow.ellipsis,
                            maxLines: 1,
                          )),
                    ],
                  ),
                  const SizedBox(
                    height: YHMSizes.spaceBtwItems / 4,
                  ),
                  Container(
                    width: YHMHelperFunctions.screenWidth() / 2.5,
                    child: Text(
                      'Estimated Cost ${liveServiceInitialCost}',
                      style: TextStyle(
                          color: YHMColors.primary,
                          fontWeight: FontWeight.w500,
                          fontSize: 14,
                          overflow: TextOverflow.ellipsis),
                    ),
                  ),
    
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
