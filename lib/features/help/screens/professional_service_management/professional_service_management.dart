import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:intl/intl.dart';
import 'package:your_health_mate/common/shimmer/YHMShimmerEffect.dart';
import 'package:your_health_mate/common/styles/spacing_style.dart';
import 'package:your_health_mate/features/help/screens/setting/widgets/circular_image.dart';
import 'package:your_health_mate/utils/newTheme/new_text_theme.dart';
import 'package:your_health_mate/utils/constants/colors.dart';
import 'package:your_health_mate/utils/constants/sizes.dart';
import '../../controllers/service/professional_service_management_controller.dart';
import '../service_view/widgets/top_row.dart';

class YHMProfessionalServiceManagement extends StatelessWidget {
  const YHMProfessionalServiceManagement({
    super.key,
    required this.serviceRequest,
    required this.mCity,
    required this.liveServiceDescription,
    required this.liveServiceCategory,
    required this.liveServiceInitialCost,
    required this.mArea,
    required this.mPostalCode,
    required this.mapAdministrativeArea,
    required this.mState,
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
    required this.liveServiceID,
    required this.liveServiceStatus,
    required this.estimatedCost,
    required this.kms,
    required this.rating,
    required this.liveServiceImg,
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
    final professionalServiceManagementController = Get.put(ProfessionalServiceManagementController());

    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: YHMSpacingStyle.paddingWithAppBarHeight,
          child: Column(
            children: [
              YHMServiceViewTopBar(),
              const SizedBox(height: YHMSizes.spaceBtwSections),
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  YHMCircularImage(
                    image: liveServiceImg,
                    isNetworkImage: true,
                    height: 60,
                    width: 60,
                    padding: 0,
                  ),
                  const SizedBox(width: 20),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        liveServiceCategory,
                        style: Theme.of(context)
                            .textTheme
                            .headlineMedium!
                            .copyWith(fontSize: 20),
                      ),
                      const SizedBox(height: YHMSizes.spaceBtwItems / 3),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Icon(Icons.star, size: YHMSizes.iconSm),
                          Text(
                            ' ${rating == '0' ? rating : 'New'} ',
                            style: Theme.of(context).textTheme.bodyMedium,
                          ),
                          Text(
                            '• ${mCity},${mState} ',
                            style: Theme.of(context).textTheme.bodyMedium,
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
              /// -- tab bar
              const SizedBox(height: YHMSizes.defaultSpace),
              Container(
                padding: EdgeInsets.all(5),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(14),
                  border: Border.all(
                      color: YHMColors.dark.withOpacity(0.5), width: 0.5),
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: GestureDetector(
                        onTap: () {
                          professionalServiceManagementController.selectedStatus.value='accepted';
                          professionalServiceManagementController.updateFilter('Accepted');
                        },
                        child: Obx(()=>
                          Container(
                            alignment: Alignment.center,
                            height: 50,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(14),
                              color: professionalServiceManagementController.selectedStatus.value == 'Accepted'
                                  ? YHMColors.primary.withOpacity(0.1)
                                  : YHMColors.primary.withOpacity(0.0),
                            ),
                            child: Text(
                              'Accepted',
                              style: NewTextTheme.medium!.copyWith(
                                  fontSize: 12,
                                  color: professionalServiceManagementController.selectedStatus.value == 'Accepted'
                                      ? YHMColors.primary
                                      : YHMColors.dark),
                            ),
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      child: GestureDetector(
                        onTap: () {
                          professionalServiceManagementController.updateFilter('Pending');
                        },
                        child: Obx(()=>
                          Container(
                            alignment: Alignment.center,
                            height: 50,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(14),
                              color: professionalServiceManagementController.selectedStatus.value.toLowerCase() == 'Pending'.toLowerCase()
                                  ? YHMColors.primary.withOpacity(0.1)
                                  : YHMColors.primary.withOpacity(0.0),
                            ),
                            child: Text(
                              'Pending',
                              style: NewTextTheme.medium!.copyWith(
                                  fontSize: 12,
                                  color: professionalServiceManagementController.selectedStatus.value.toLowerCase() == 'Pending'.toLowerCase()
                                      ? YHMColors.primary
                                      : YHMColors.dark),
                            ),
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      child: GestureDetector(
                        onTap: () {
                          professionalServiceManagementController.updateFilter('Rejected');
                        },
                        child: Obx(()=>
                          Container(
                            alignment: Alignment.center,
                            height: 50,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(14),
                              color: professionalServiceManagementController.selectedStatus.value.toLowerCase() == 'Rejected'.toLowerCase()
                                  ? YHMColors.primary.withOpacity(0.1)
                                  : YHMColors.primary.withOpacity(0.0),
                            ),
                            child: Text(
                              'Rejected',
                              style: NewTextTheme.medium!.copyWith(
                                  fontSize: 12,
                                  color: professionalServiceManagementController.selectedStatus.value == 'Rejected'
                                      ? YHMColors.primary
                                      : YHMColors.dark),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              Obx(
                    () => professionalServiceManagementController.isLoading.value
                    ? YHMShimmerEffect(width: 100, height: 30)
                    : ListView.builder(
                  shrinkWrap: true,
                  padding: EdgeInsets.zero,
                  physics: NeverScrollableScrollPhysics(),
                  itemCount: professionalServiceManagementController.services.length,
                  itemBuilder: (context, index) {
                    final data = professionalServiceManagementController.services[index];
                    final bookingServiceId = data['bookingServiceId'];
                    final bookingDate = (data['bookingDate'] as Timestamp).toDate();
                    final formattedDate = DateFormat.yMMMd().format(bookingDate);

                    return Container(
                      margin: const EdgeInsets.only(bottom: 10),
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(14),
                        border: Border.all(
                            color: YHMColors.dark.withOpacity(0.5), width: 0.5),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Icon(Iconsax.user),
                              const SizedBox(width: 5),
                              Text(data['userEmail'], style: NewTextTheme.bold),
                            ],
                          ),
                          const SizedBox(height: 5),
                          Row(
                            children: [
                              Icon(Iconsax.timer_1),
                              const SizedBox(width: 5),
                              Text('$formattedDate ${data['bookingTime']}'),
                            ],
                          ),
                          const SizedBox(height: 5),
                          Row(
                            children: [
                              Icon(Iconsax.note_2),
                              const SizedBox(width: 5),
                              Text(data['userInstruction']),
                            ],
                          ),
                          const SizedBox(height: 5),
                          Row(
                            children: [
                              Icon(Iconsax.routing),
                              const SizedBox(width: 5),
                              Text('${data['userHouseNum']}, ${data['userArea']}'),
                            ],
                          ),
                          const SizedBox(height: 5),
                          Row(
                            children: [
                              Flexible(
                                child: Container(
                                  height: 50,
                                  width: double.infinity,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(14),
                                    color: YHMColors.orange.withOpacity(0.1),
                                  ),
                                  child: IconButton(
                                    icon: Icon(Icons.close, color: YHMColors.orange),
                                    onPressed: () {
                                      professionalServiceManagementController.updateServiceStatus(data['bookingServiceId'], 'Rejected');
                                    },
                                  ),
                                ),
                              ),
                              const SizedBox(width: 10),
                              Flexible(
                                child: Container(
                                  height: 50,
                                  width: double.infinity,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(14),
                                    color: YHMColors.green.withOpacity(0.1),
                                  ),
                                  child: IconButton(
                                    icon: Icon(Iconsax.timer_1, color: YHMColors.green),
                                    onPressed: () {
                                      professionalServiceManagementController.updateServiceTimeAndStatus(data['bookingServiceId'], 'Accepted', data['bookingDate']);
                                    },
                                  ),
                                ),
                              ),
                              const SizedBox(width: 10),
                              Flexible(
                                child: Container(
                                  height: 50,
                                  width: double.infinity,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(14),
                                    color: YHMColors.primary.withOpacity(0.1),
                                  ),
                                  child: IconButton(
                                    icon: Icon(Icons.done, color: YHMColors.primary),
                                    onPressed: () {
                                      professionalServiceManagementController.updateServiceStatus(data['bookingServiceId'], 'Accepted');
                                    },
                                  ),
                                ),
                              ),
                            ],
                          )
                        ],
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
