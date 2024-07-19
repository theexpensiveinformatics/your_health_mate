import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

import '../../../../../common/headings/screen_heading.dart';
import '../../../../../common/styles/spacing_style.dart';
import '../../../../../common/widgets/headings/screen_heading.dart';
import '../../../../../utils/constants/sizes.dart';
import '../../../../../utils/validators/validation.dart';
import '../../../controllers/service/professional_create_service_controller.dart';

class PageServiceDetails extends StatelessWidget {
  const PageServiceDetails({super.key});

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
              'Step 6',
              style: Theme.of(context).textTheme.titleMedium,
            ),

            /// -- heading
            const SizedBox(height: 20),
            YHMScreenHeading(
              textSize: 22,
              title: 'What will be approximate cost of service?',
            ),




            /// -- Enter Details
            const SizedBox(height: 20),
            Form(
                key: professionalCreateServiceController.manualLocationForm,
                child:
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [

                    ///-- subheading
                    const SizedBox(height: 10),
                    Text(
                      '1) A 10% platform fee will be deducted from the total amount as platform charges.\n\n2) Please ensure that your payment is made through Home-Helps.\n\n3) Attempting to bypass Home-Helps is illegal and may result in legal consequences. \n\n4)Moreover, you can add any other applicable costs afterwards.',
                      style: Theme.of(context).textTheme.bodySmall,
                    ),

                    /// -- Enter Details
                    const SizedBox(height: 20),
                    /// Cost
                    TextFormField(
                        controller: professionalCreateServiceController.initialCost,
                        validator: (value) =>
                            YHMValidator.validateEmptyText('Estimated Charges (in Indian Rupees)', value),
                        decoration:  InputDecoration(
                            labelText: "Estimated Charges (in Indian Rupees)",
                            hintText: '550',
                            hintStyle: Theme.of(context).textTheme.bodySmall,
                            prefixIcon: Icon(Icons.currency_rupee,)),
                        expands: false),
                    const SizedBox(height: YHMSizes.spaceBtwInputFields),

                    ///-- subheading
                    const SizedBox(height: 20),
                    Text(
                      'Any instruction to user? \nEx: Need one electric plug and bucket from your side',
                      style: Theme.of(context).textTheme.bodySmall,
                    ),
                    const SizedBox(height: 20),
                    /// Description
                    TextFormField(
                        controller: professionalCreateServiceController.description,
                        validator: (value) =>
                            YHMValidator.validateEmptyText('Any Instruction to User', value),
                        decoration:  InputDecoration(
                            labelText: "Any Instruction to User",
                            hintText: 'We need one table from your side.',
                            hintStyle: Theme.of(context).textTheme.bodySmall,
                            prefixIcon: Icon(Iconsax.note_21)),
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
