import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import 'package:iconsax/iconsax.dart';
import '../../../../../common/headings/screen_heading.dart';
import '../../../../../common/shimmer/YHMShimmerEffect.dart';
import '../../../../../common/styles/spacing_style.dart';
import '../../../../../common/widgets/headings/screen_heading.dart';
import '../../../../../utils/constants/colors.dart';
import '../../../../../utils/helper/helper_functions.dart';
import '../../../controllers/service/professional_create_service_controller.dart';

class PageAddress extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final professionalCreateServiceController = ProfessionalCreateServiceController.instance;
    return SingleChildScrollView(
      child: Padding(
        padding: YHMSpacingStyle.paddingWithAppBarHeight,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 20),

            /// -- step
            Text(
              'Step 4',
              style: Theme.of(context).textTheme.titleMedium,
            ),

            /// -- heading
            const SizedBox(height: 20),
            YHMScreenHeading(
              textSize: 22,
              title: 'Where\'s your service center or home located?',
            ),

            ///-- subheading
            const SizedBox(height: 10),
            Text(
              'According to your location, we will show your service to the nearest customer.',
              style: Theme.of(context).textTheme.bodySmall,
            ),

            /// -- map for selecting location
            const SizedBox(height: 20),
            Obx(() => Container(
              child: professionalCreateServiceController.isMapLoading.value
                  ? Center(child: YHMShimmerEffect(height: 400, width: double.infinity,))
                  : Stack(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(16),
                    child: Container(
                      height: YHMHelperFunctions.screenHeight()/2,
                      child: GoogleMap(
                        onMapCreated: professionalCreateServiceController.onMapCreated,
                        initialCameraPosition: CameraPosition(
                          target: professionalCreateServiceController.desLocation!,
                          zoom: 20.0,
                        ),
                        onCameraMove: (position) {
                          professionalCreateServiceController.desLocation = position.target;
                        },
                        onCameraIdle: () {
                          professionalCreateServiceController.getAddressFromLatLng();
                        },
                      ),
                    ),
                  ),

                  /// -- blue marker
                  Positioned(
                    top: 0,
                    bottom: 0,
                    right: 0,
                    left: 0,
                    child: Icon(
                      Icons.location_pin,
                      size: 50,
                      color: YHMColors.primary,
                    ),
                  ),

                  /// input address
                  Positioned(
                    right: 30,
                    left: 30,
                    top: 25,
                    child: Container(
                      alignment: Alignment.center,
                      height: 60,
                      width: 300,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(100),
                        boxShadow: [
                          BoxShadow(
                              offset: Offset(0, 15),
                              blurStyle: BlurStyle.normal,
                              blurRadius: 25,
                              color: YHMColors.dark.withOpacity(0.3))
                        ],
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(100),
                        child: Padding(
                          padding: const EdgeInsets.only(left: 10),
                          child: TextFormField(
                            enabled: false,
                            controller: professionalCreateServiceController.markLocation,
                            decoration: InputDecoration(
                              border: OutlineInputBorder(borderSide: BorderSide.none),
                              enabledBorder: OutlineInputBorder(borderSide: BorderSide.none),
                              focusedBorder: OutlineInputBorder(borderSide: BorderSide.none),
                              prefixIcon: Icon(Iconsax.location),
                            ),
                            style: Theme.of(context).textTheme.bodyLarge,
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
      ),
    );
  }
}
