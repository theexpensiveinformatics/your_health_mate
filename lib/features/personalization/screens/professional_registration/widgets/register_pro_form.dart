import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get.dart%20%20';
import 'package:iconsax/iconsax.dart';
import '../../../../../utils/constants/sizes.dart';
import '../../../../../utils/constants/text_strings.dart';
import '../../../../../utils/helper/helper_functions.dart';
import '../../../../../utils/validators/validation.dart';
import '../../../controller/register_professional_controller.dart';


class RegisterProForm extends StatelessWidget {
  RegisterProForm({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(RegisterProfessionalController());
    return Form(
      key: controller.registerProfessionalFormKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Enter Basic Details According to Official Government Document. Ex: Adhar Card, Birth Certificate',
            style: Theme.of(context).textTheme.bodySmall,
          ),
          const SizedBox(
            height: YHMSizes.spaceBtwInputFields,
          ),
          Row(
            children: [
              Expanded(
                child: TextFormField(
                  controller: controller.firstName,
                  validator: (value) {
                    return YHMValidator.validateEmptyText('First Name', value);
                  },
                  decoration: InputDecoration(
                      labelText: YHMTexts.firstName,
                      prefixIcon: Icon(Iconsax.user)),
                ),
              ),
              const SizedBox(
                width: YHMSizes.spaceBtwInputFields,
              ),
              Expanded(
                child: TextFormField(
                  controller: controller.lastName,
                  validator: (value) =>
                      YHMValidator.validateEmptyText('Last Name', value),
                  decoration: InputDecoration(
                      labelText: YHMTexts.lastName,
                      prefixIcon: Icon(Iconsax.user)),
                ),
              ),
            ],
          ),

          /// email and phone number
          const SizedBox(
            height: YHMSizes.spaceBtwInputFields,
          ),
          Text(
            'Kindly input your accurate email and mobile number for verification purposes by the administrator.',
            style: Theme.of(context).textTheme.bodySmall,
          ),
          const SizedBox(
            height: YHMSizes.spaceBtwItems,
          ),

              TextFormField(
                controller: controller.email,
                enabled: false,
                decoration: InputDecoration(
                  labelText: YHMTexts.email,
                  hintText: controller.email.text,
                  prefixIcon: Icon(Iconsax.direct_inbox),
                ),
              ),

          const SizedBox(
            height: YHMSizes.spaceBtwInputFields,
          ),

          TextFormField(
            controller: controller.phoneNumber,
            validator: (value) => YHMValidator.validatePhoneNumber(value),
            keyboardType: TextInputType.numberWithOptions(),
            decoration: InputDecoration(
                labelText: YHMTexts.phoneNo, prefixIcon: Icon(Iconsax.call)),
          ),
          const SizedBox(
            height: YHMSizes.spaceBtwInputFields,
          ),

          Text(
            'Enter Location Details of your Shop or House According to Official Government Document. Ex: Adhar Card, Driving Licence',
            style: Theme.of(context).textTheme.bodySmall,
          ),
          const SizedBox(
            height: YHMSizes.spaceBtwInputFields,
          ),
          TextFormField(
            controller: controller.address,
            validator: (value) =>
                YHMValidator.validateEmptyText('Address', value),
            decoration: InputDecoration(
                labelText: 'House or Shop Address',
                prefixIcon: Icon(Iconsax.routing)),
          ),

          const SizedBox(
            height: YHMSizes.spaceBtwInputFields,
          ),

          Row(
            children: [
              Expanded(
                child: TextFormField(
                  controller: controller.landmark,
                  validator: (value) =>
                      YHMValidator.validateEmptyText('Landmark', value),
                  decoration: InputDecoration(
                    labelText: 'Landmark',
                    prefixIcon: Icon(Iconsax.home_hashtag),
                  ),
                ),
              ),
              const SizedBox(
                width: YHMSizes.spaceBtwInputFields,
              ),
              Expanded(
                  child: TextFormField(
                controller: controller.city,
                validator: (value) =>
                    YHMValidator.validateEmptyText('City', value),
                decoration: InputDecoration(
                  labelText: 'City',
                  prefixIcon: Icon(Iconsax.building),
                ),
              ))
            ],
          ),

          const SizedBox(
            height: YHMSizes.spaceBtwInputFields,
          ),

          Row(
            children: [
              Expanded(
                child: TextFormField(
                  controller: controller.state,
                  validator: (value) =>
                      YHMValidator.validateEmptyText('State', value),
                  decoration: InputDecoration(
                    labelText: 'State',
                    prefixIcon: Icon(Iconsax.map_14),
                  ),
                ),
              ),
              const SizedBox(
                width: YHMSizes.spaceBtwItems,
              ),
              Expanded(
                  child: TextFormField(
                controller: controller.postalCode,
                validator: (value) =>
                    YHMValidator.validateEmptyText('Postal Code', value),
                decoration: InputDecoration(
                  labelText: 'Postal Code',
                  prefixIcon: Icon(Iconsax.gps),
                ),
              ))
            ],
          ),

          /// -- Upload Documents

          const SizedBox(
            height: YHMSizes.spaceBtwSections,
          ),

          Column(
            children: [
              Text(
                'Upload PDF of AdharCard that have front and back side both.',
                style: Theme.of(context).textTheme.bodySmall,
              ),
              const SizedBox(
                height: YHMSizes.spaceBtwItems,
              ),
              Container(
                width: YHMHelperFunctions.screenWidth(),
                child: OutlinedButton(
                    onPressed: () async {
                      await controller.pickFile();
                      controller.update();
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Icon(Iconsax.document),
                            const SizedBox(
                              width: YHMSizes.spaceBtwItems,
                            ),
                            Obx(()=> Container(width: YHMHelperFunctions.screenWidth()/2,child: Text(controller.selectedFileIndicator.value!= false ? controller.selectedFileName ?? 'Select PDF of AdharID' :'Select PDF of AdharID.' ,overflow: TextOverflow.ellipsis, ))),
                          ],
                        ),
                        Obx(()=>
                           Icon(Iconsax.tick_circle, size: controller.selectedFileIndicator.value!= false ? YHMSizes.iconMd : 0
                            ,),
                        )
                      ],
                    ),
                ),
              )
            ],
          ),

          /// -- Real time pic

          const SizedBox(
            height: YHMSizes.spaceBtwSections,
          ),

          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Capture your real-time picture for verification.',
                style: Theme.of(context).textTheme.bodySmall,
              ),
              const SizedBox(
                height: YHMSizes.spaceBtwItems,
              ),
              Container(
                width: YHMHelperFunctions.screenWidth(),
                child: OutlinedButton(
                  onPressed: () async {
                    await controller.capturePhoto();
                    controller.update();
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Icon(Iconsax.camera4),
                          const SizedBox(
                            width: YHMSizes.spaceBtwItems,
                          ),
                          Obx(() => Container(
                            width: YHMHelperFunctions.screenWidth() / 2,
                            child: Text(
                              controller.capturedPhotoIndicator.value != false
                                  ? controller.capturedPhotoName ?? 'Capture photo'
                                  : 'Capture photo',
                              overflow: TextOverflow.ellipsis,
                            ),
                          )),
                        ],
                      ),
                      Obx(() => Icon(
                        Iconsax.tick_circle,
                        size: controller.capturedPhotoIndicator.value != false
                            ? YHMSizes.iconMd
                            : 0,
                      )),
                    ],
                  ),
                ),
              ),
            ],
          ),

          const SizedBox(
            height: YHMSizes.spaceBtwSections,
          ),

          /// terms and conditions

          Row(
            children: [
              Checkbox(
                value: true,
                onChanged: (value) {},
              ),
              Flexible(
                  child: Text(
                'I confirm that I have read and understood all the terms.',
                style: Theme.of(context).textTheme.bodyLarge,
              )),
            ],
          ),

          /// submit button

          const SizedBox(
            height: YHMSizes.spaceBtwSections,
          ),

          Container(
              width: double.infinity,
              child: ElevatedButton(
                  onPressed: () {controller.registerProfessional();},
                  child: Text('Apply'))),

          // ElevatedButton(
          //   onPressed: () async {
          //     Position position = await _getCurrentLocation();
          //     Map<String, String?> locationDetails = await _getLocationDetails(position);
          //     print('City: ${locationDetails['city']}');
          //     print('State: ${locationDetails['state']}');
          //     print('District: ${locationDetails['district']}');
          //     print('Postal Code: ${locationDetails['postalCode']}');
          //   },
          //   child: Text('Get Location'),
          // ),
        ],
      ),
    );
  }
}
