import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import '../../../../../common/headings/screen_heading.dart';
import '../../../../../common/styles/spacing_style.dart';
import '../../../../../common/widgets/headings/screen_heading.dart';
import '../../../../../utils/constants/sizes.dart';
import '../../../../../utils/constants/text_strings.dart';
import '../../../../../utils/validators/validation.dart';
import '../../../controllers/service/professional_create_service_controller.dart';

class PageManualAddress extends StatelessWidget{
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
              'Step 5',
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
              'Type Manually for better accuracy',
              style: Theme.of(context).textTheme.bodySmall,
            ),

            /// -- Enter Details
            const SizedBox(height: 20),
            Form(
            key: professionalCreateServiceController.manualLocationForm,
                child:
            Column(
              children: [
                /// Area
                TextFormField(
                    controller: professionalCreateServiceController.mArea,
                    validator: (value) =>
                        YHMValidator.validateEmptyText('House or Shop Num / Area', value),
                    decoration:  InputDecoration(
                        labelText: "House / Shop Num & Area",
                        hintText: '25, Tilak Nagar, Mahavir Circle',
                        hintStyle: Theme.of(context).textTheme.bodySmall,
                        prefixIcon: Icon(Iconsax.home_2)),
                    expands: false),
                const SizedBox(height: YHMSizes.spaceBtwInputFields),

                /// City
                TextFormField(
                    controller: professionalCreateServiceController.mCity,
                    validator: (value) =>
                        YHMValidator.validateEmptyText('City', value),
                    decoration:  InputDecoration(
                        labelText: "City",
                        hintText: 'Vadodara',
                        hintStyle: Theme.of(context).textTheme.bodySmall,
                        prefixIcon: Icon(Iconsax.location)),
                    expands: false),
                const SizedBox(height: YHMSizes.spaceBtwInputFields),

                /// Pincode
                TextFormField(
                    controller: professionalCreateServiceController.mPincode,
                    validator: (value) =>
                        YHMValidator.validateEmptyText('Pincode', value),
                    decoration:  InputDecoration(
                        labelText: "Pincode",
                        hintText: '391760',
                        hintStyle: Theme.of(context).textTheme.bodySmall,
                        prefixIcon: Icon(Iconsax.code)),
                    expands: false),
                const SizedBox(height: YHMSizes.spaceBtwInputFields),

                /// State
                TextFormField(
                    controller: professionalCreateServiceController.mState,
                    validator: (value) =>
                        YHMValidator.validateEmptyText('State', value),
                    decoration:  InputDecoration(
                        labelText: "State",
                        hintText: 'Gujarat',
                        hintStyle: Theme.of(context).textTheme.bodySmall,
                        prefixIcon: Icon(Iconsax.routing)),
                    expands: false),
                const SizedBox(height: YHMSizes.spaceBtwInputFields),


              ],
            ))



          ],
        ),
      ),
    );
  }

}